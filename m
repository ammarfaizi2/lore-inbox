Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVBYWc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVBYWc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVBYWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:32:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:10153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262783AbVBYWcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:32:20 -0500
Date: Fri, 25 Feb 2005 14:37:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
Cc: ak@suse.de, riel@redhat.com, linux-kernel@vger.kernel.org,
       Ian.Pratt@cl.cam.ac.uk, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       ian.pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-Id: <20050225143712.3dd97429.akpm@osdl.org>
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D1E3291@liverpoolst.ad.cl.cam.ac.uk>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D1E3291@liverpoolst.ad.cl.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk> wrote:
>
>  
> > The Xen team still believe that it's best to keep arch/xen, 
> > arch/xen/i386,
> > arch/xen/x86_64, etc.  And I believe that Andi (who is the 
> > world expert on
> > maintaining an i386 derivative) thinks that this is will be a 
> > long-term
> > maintenance problem.
> 
> I think there's an interim compromise position that everyone might go
> for:
> 
> Phase 1 is for us to submit a load of patches that squeeze out the low
> hanging fruit in unifying xen/i386 and i386. Most of these will be
> strict cleanups to i386, and the result will be to almost halve the
> number of files that we need to modify.

OK.  It would be good to have a phase 0: any refactoring, abstracting, etc
to the core kernel and to i386 which is a preparatory step, prior to
introducing any Xen code.  After phase 0 everything should still compile
and run.  The subsequent Xen patches should merely add stuff and not move
existing code around.

> The next phase is that we re-organise the current arch/xen as follows:
> 
> We move the remaining (reduced) contents of arch/xen/i386 to
> arch/i386/xen (ditto for x86_64). We then move the xen-specific files
> that are shared between all the different xen architectures to
> drivers/xen/core. I know this last step is a bit odd, but it's the best
> location that Rusty Russel and I could come up with.
> 
> At this point, I'd hope that we could get xen into the main-line tree.

What would you propose doing with the i386 header files?  Such as the
pagetable handling?

> The final phase is to see if we can further unify more native and xen
> files. This is going to require some significant i386 code refactoring,
> and I think its going to be much easier to do if all the code is in the
> main-line tree so that people can see the motivation for what's going
> on.
> 
> What do you think?

It sounds decent.  The main objective is to minimise code duplication.  The
question of where in the tree all the resulting code actually lands is
secondary from a maintainability POV.

