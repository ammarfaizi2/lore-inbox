Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbTIARZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTIARZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:25:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26793 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263174AbTIARY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:24:27 -0400
Date: Mon, 1 Sep 2003 14:27:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
In-Reply-To: <Pine.LNX.4.44.0308311353170.15412-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0309011426390.5932-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mind to answer this message Andrea?

On Sun, 31 Aug 2003, Marcelo Tosatti wrote:

> 
> 
> On Sat, 30 Aug 2003, Andrea Arcangeli wrote:
> 
> > On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> > > 
> > > > You need to integrate with -aa on the VM.  It has been hard enough for
> > > > Andrea to get his stuff in, I doubt you will fair any better.
> > > 
> > > Thats because I never received separate patches which make sense one by
> > > one.  Most of Andreas changes are all grouped into few big patches that
> > > only he knows the mess. That is not the way to merge things.
> > > 
> > > I want to work out with him after I merge other stuff to address that.
> > 
> > that's true for only one patch, the others are pretty orthogonal after
> > Andrew helped splitting them:
> > 
> > 
> > 05_vm_03_vm_tunables-4
> > 05_vm_05_zone_accounting-2
> > 05_vm_06_swap_out-3
> 
> Help me understand something about this patch. In try_to_free_pages(), you
> set failed_swapout to zero in case we are under __GFP_IO. And
> failed_swapout decides whether we swap_out() or not.
> 
> So basically with -aa swap_out() is only called by __GFP_IO tasks (which
> are throttled by the page laundering code in shrink_cache) and in mainline
> non __GFP_IO tasks do swap_out() (and those are not throttled by anything).
> 
> Did I understood this right? 
> 
> Part 2:
> 
> Now in try_to_free_pages_zone() and shrink_cache you have: 
> 
>     if (!*failed_swapout)
>         *failed_swapout =  !swap_out(classzone);
> 
> Which means: Keep trying to swap_out() only in case swap_out()  
> successfully desactivates nr_pages pte's. Right? Do you do that to avoid
> terrible expensive swap_out() loops which dont successfully free pages?
> 
> Thanks
> 
> 
> 
> 
> 

