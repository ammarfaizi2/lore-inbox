Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWG0VCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWG0VCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWG0VCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751049AbWG0VBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:01:46 -0400
Date: Thu, 27 Jul 2006 14:01:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
In-Reply-To: <Pine.LNX.4.63.0607272247420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Message-ID: <Pine.LNX.4.64.0607271354270.4168@g5.osdl.org>
References: <1153929715.13509.12.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org> 
 <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>  <Pine.LNX.4.64.0607261041490.29649@g5.osdl.org>
 <1154025127.13509.90.camel@localhost.localdomain> <Pine.LNX.4.64.0607271206461.4168@g5.osdl.org>
 <Pine.LNX.4.63.0607272247420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jul 2006, Johannes Schindelin wrote:
> 
> On Thu, 27 Jul 2006, Linus Torvalds wrote:
> 
> > On Thu, 27 Jul 2006, Alan Cox wrote:
> > > 
> > > git-lost-found turns up some of the missing stuff that was applied
> > > earliest in the rebase but the other stuff is apparently neither visible
> > > anywhere in the tree or missing (the tree I was rebasing "^^^..." never
> > > shows it nor does the log).
> > 
> > Did you try "git-fsck-objects --full"?
> > 
> > The git-lost-found script is apparently broken, exactly because it doesn't 
> > do a "full".
> 
> Of course, I was assuming that nothing like repacking or pruning took 
> place after the crash...

That's not the point.

If somebody does a "git rebase", he might be changing the heads that have 
already been packed, and replacing them them with heads that have _not_ 
yet been packed. So the _dangling_ links are the old ones (in the 
pack-file), and "git-fsck-objects --full" is needed to see them.

That said, I still don't think Alan sees what he says he sees. Even if 
something crashes in the middle of a "git rebase", I think the old head 
should have been saved in .git/ORIG_HEAD, for example. 

That said, some of the more invasive operations (and "git rebase" 
certainly counts) should probably have a few "sync" operations to make 
sure that things like ORIG_HEAD really are on disk, so that we would be 
able to recreate the tree even _without_ anything like "git-fsck-objects".

		Linus
