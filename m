Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbRGSGco>; Thu, 19 Jul 2001 02:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266973AbRGSGcY>; Thu, 19 Jul 2001 02:32:24 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:5564 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266967AbRGSGcH>; Thu, 19 Jul 2001 02:32:07 -0400
Message-ID: <3B567F22.29BA20DA@uow.edu.au>
Date: Thu, 19 Jul 2001 16:33:06 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
In-Reply-To: <200107181617.KAA326921@ibg.colorado.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Lessem wrote:
> 
> Andrew Morton wrote:
> 
> >Jeff Lessem wrote:
> >> I tried that, but the Symbios SCSI controller freaks out with noapic.
> >> I can be more detailed if that would be useful.
> >
> >Please do - that sounds like a strange interaction.
> 
> I tried with nosmp and that gave the same response as noapic, so here
> it is:  It will keep repeating sym53c8xx_reset until the machine is
> reset.  I banged on SysRq to try to get some useful information.

Does the other machine also play up in this manner?

>...
> SysRq: Show Memory
> Mem-info:
> Free pages:      8492416kB (7733248kB HighMem)
> ( Active: 0, inactive_dirty: 0, inactive_clean: 0, free: 2123104 (638 1276 1914) )
> 1*4kB 2*8kB 3*16kB 3*32kB 2*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 6*2048kB = 14244kB)
> 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 363*2048kB = 744924kB)
> 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 3776*2048kB = 7733248kB)
> Swap cache: add 0, delete 0, find 0/0
> Free swap:            0kB
> 2162688 pages of RAM
> 1933312 pages of HIGHMEM
> 36506 reserved pages
> -13 pages shared

An interesting statistic.  It's not obvious how this happened.

>...
> 
> >>EIP; c010b5d7 <timer_interrupt+43/130>   <=====
> Trace; c0108431 <handle_IRQ_event+4d/78>
> Trace; c0108616 <do_IRQ+a6/ec>
> Trace; c01051d0 <default_idle+0/34>
> Trace; c01051d0 <default_idle+0/34>
> Trace; c0106d84 <ret_from_intr+0/7>
> Trace; c01051d0 <default_idle+0/34>
> Trace; c01051d0 <default_idle+0/34>
> Trace; c01051fc <default_idle+2c/34>
> Trace; c0105262 <cpu_idle+3e/54>

Again, spinning in the timer interrupt handler.  It does
appear that the interrupt is not being negated.  Try -ac
and other kernels if/when you can, but it does seem that
the hardware is unwell.

-
