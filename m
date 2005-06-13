Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFMMTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFMMTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFMMTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:19:53 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:25772 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261532AbVFMMTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:19:42 -0400
Date: Mon, 13 Jun 2005 14:19:22 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <42AD761C.6060709@grupopie.com>
Message-Id: <Pine.OSF.4.05.10506131411080.23074-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jun 2005, Paulo Marques wrote:

> Gene Heskett wrote:
> > [...]
> > Lets add the operation of 4 or more stepper motors in real time for 
> > smaller milling machines.  There, the constraints are more related to 
> > maintaining a steady flow of step/direction data at high enough 
> > speeds to make a stepper, with 8 microsteps per step, and 240 steps 
> > per revolution, run smoothly at speeds up to say 20 kilohertz, or 50 
> > microseconds per step, maintaining that 50 microseconds plus or minus 
> > not more than 5 microseconds else the motors will start sounding 
> > ragged and stuttering.
> 
> This is the kind of problem that is screaming "give me dedicated 
> hardware!". Why would one spend $500+ on a PC to do the work of a $2 
> microcontroller (and possibly throw in an FPGA to the mix)?. Not to 
> mention that the microcontroller/FPGA would maintain 50us +/- 0us 
> instead of the 50 +/- 5 you've mentioned.
>
Linux does not always run on a $500+ PC. People also use Linux on
_embedded_ devices costing only a small fraction of a $500+ PC. But I do
agree it is kind of silly to use the OS for this example. 

Assuming you do not put any "highlevel" calculations in a IRQ handler,
the only usefull place to have fast IRQ handlers, as far as I can see,
without having fast preemption is with cheap hardware without a lot of 
buffering. 

I can come up with CAN controllers, which only have very little
bufferspace (because they are cheap as they are sold in large volumes).
Worst case you will have to empty it every 100-200 us or so to avoid
having an overrun and loosing packages. The interpretation of the packets
should ofcourse be deferred to a task. The tolerated latency of that task
ofcourse depend on what you want to use the data for....

Esben

