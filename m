Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVAHSrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVAHSrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVAHSrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:47:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:52908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVAHSrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:47:04 -0500
Date: Sat, 8 Jan 2005 10:46:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
In-Reply-To: <20050107221255.GA8749@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
 <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Marcelo Tosatti wrote:
> 
> Only problem is that current do_brk() callers dont take the lock - you would
> need a version of do_brk() that doesnt warn for them? 

No, I'd just fix them up.

They mostly don't _need_ the lock (at least not the binary loader ones),
since at executable loading time you're guaranteed to be the only user
anyway, but hey, we get the lock for do_mmap() there for the same reason:  
to just keep things consistent (and I think we used to have a warning in
do_mmap() a long time ago when we were chasing down some other bug, so
doign the same thing for do_brk() is just very consistent).

Another issue is likely that we should make the whole "uselib()"
interfaces configurable. I don't think modern binaries use it (where
"modern" probably means "compiled within the last 8 years" ;).

		Linus
