Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVAIBjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVAIBjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVAIBjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:39:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:17025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262184AbVAIBi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:38:57 -0500
Date: Sat, 8 Jan 2005 17:38:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
In-Reply-To: <20050108182841.GD2701@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501081734400.2339@ppc970.osdl.org>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
 <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet>
 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <20050108182841.GD2701@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jan 2005, Marcelo Tosatti wrote:
>
> > No, I'd just fix them up.
> 
> What do you mean by "fix them up" ? With your minimal fix the other do_brk() callers 
> do not have the lock, you dont mean "fix" by grabbing the lock? 

I'm saying that if we decide to do the debugging warning (and I think 
everybody is agreeing that we should), then we _will_ fix it by just 
grabbing the lock in all the paths. That's what we already did with 
do_mmap(), after all.

I suspect it's not strictly needed, but as Alan has said, even though 
nothing else can chaneg the vma's at the same time, it's the right thing 
to do to keep /proc reads happy (which _can_ happen) anyway. And more 
importantly, invariants are nice - to the point where it's good to follow 
the rules even if it might not be strictly necessary.

I just wanted to keep these two issues separate. I think it's one thing to 
fix a known bug, and another thing to add some debug infrastructure to 
make sure that it doesn't happen in the future. So I think the WARN_ON() + 
adding of extra locking is a separate stage from fixing the known problem.

		Linus
