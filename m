Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVAUOMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVAUOMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVAUOMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:12:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262371AbVAUOMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:12:15 -0500
Date: Fri, 21 Jan 2005 15:11:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Chris Han <xiphux@gmail.com>
Subject: Re: [ANNOUNCE][RFC] plugsched-2.0 patches ...
Message-ID: <20050121141136.GG2790@suse.de>
References: <NIBBJLJFDHPDIBEEKKLPGELGDHAA.mef@cs.princeton.edu> <200501201751.j0KHpvdQ030760@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501201751.j0KHpvdQ030760@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20 2005, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 20 Jan 2005 11:14:48 EST, "Marc E. Fiuczynski" said:
> > Peter, thank you for maintaining Con's plugsched code in light of Linus' and
> > Ingo's prior objections to this idea.  On the one hand, I partially agree
> > with Linus&Ingo's prior views that when there is only one scheduler that the
> > rest of the world + dog will focus on making it better. On the other hand,
> > having a clean framework that lets developers in a clean way plug in new
> > schedulers is quite useful.
> > 
> > Linus & Ingo, it would be good to have an indepth discussion on this topic.
> > I'd argue that the Linux kernel NEEDS a clean pluggable scheduling
> > framework.
> 
> Is this something that would benefit from several trips around the -mm
> series?
> 
> ISTR that we started with one disk elevator, and now we have 3 or 4
> that are selectable on the fly after some banging around in -mm.  (And
> yes, I realize that the only reason we can change the elevator on the
> fly is because it can switch from the current to the 'stupid FIFO
> none' elevator and thence to the new one, which wouldn't really work
> for the CPU scheduler....)

I don't think you can compare the two. Yes they are both schedulers, but
that's about where the 'similarity' stops. The CPU scheduler must be
really fast, overhead must be kept to a minimum. For a disk scheduler,
we can affort to burn cpu cycles to increase the io performance. The
extra abstraction required to fully modularize the cpu scheduler would
come at a non-zero cost as well, but I bet it would have a larger impact
there. I doubt you could measure the difference in the disk scheduler.

There are vast differences between io storage devices, that is why we
have different io schedulers. I made those modular so that the desktop
user didn't have to incur the cost of having 4 schedulers when he only
really needs one.

> All the arguments that support having more than one elevator apply
> equally well to the CPU scheduler....

Not at all, imho. It's two completely different problems.

-- 
Jens Axboe

