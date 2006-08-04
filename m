Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWHDPzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWHDPzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWHDPzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:55:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44807 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161256AbWHDPy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:54:59 -0400
Date: Fri, 4 Aug 2006 11:54:58 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Problem: irq 217: nobody cared + backtrace
In-Reply-To: <9a8748490608040736n5c9ea078x79f4ce56b613703a@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0608041142400.6371-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Jesper Juhl wrote:

> On 03/08/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Has this happened more than once?
> 
> Seems to happen consistently after ~100000 interrupts.
> 
> >  In case it happens again, here's how
> > you can get more information.  Turn on CONFIG_USB_DEBUG and
> > CONFIG_DEBUG_FS, and mount a debugfs filesystem somewhere (say
> > /sys/kernel/debug).  Then after the problem occurs, save a copy of
> >
> >         /sys/kernel/debug/uhci/0000:00:1d.1
> >
> 
> # cat /sys/kernel/debug/uhci/0000:00:1d.1
> Root-hub state: auto-stopped   FSBR: 0
> HC status
>   usbcmd    =     0048   Maxp32 CF EGSM
>   usbstat   =     0020   HCHalted
>   usbint    =     0002
>   usbfrnum  =   (1)160
>   flbaseadd = 37428160
>   sof       =       40
>   stat1     =     0080
>   stat2     =     0080
> Most recent frame: 458 (88)   Last ISO frame: 458 (88)
> 
> 
> > That will indicate whether the UHCI controller thinks it is sending an
> > interrupt request.

And it shows that the controller is idle.  No IRQ should be pending.

> And just for completenes, here's the backtrace I got just before
> saving the above info :
> 
> irq 217: nobody cared (try booting with the "irqpoll" option)
>  [<c0103a3c>] show_trace_log_lvl+0x152/0x165
>  [<c0103a5e>] show_trace+0xf/0x13
>  [<c0103b59>] dump_stack+0x15/0x19
>  [<c013846e>] __report_bad_irq+0x24/0x7f
>  [<c0138552>] note_interrupt+0x6b/0xd5
>  [<c0137ca8>] __do_IRQ+0xf4/0x100
>  [<c01050a1>] do_IRQ+0x95/0xbc
>  [<c0103502>] common_interrupt+0x1a/0x20
>  [<c0137b7e>] handle_IRQ_event+0x20/0x56
>  [<c0137c4c>] __do_IRQ+0x98/0x100
>  [<c01050a1>] do_IRQ+0x95/0xbc
>  [<c0103502>] common_interrupt+0x1a/0x20
>  [<c0100e64>] mwait_idle+0x30/0x35
>  [<c0100d45>] cpu_idle+0x78/0x81
>  [<c04cc7fb>] start_kernel+0x173/0x19d
>  [<c0100210>] 0xc0100210
> DWARF2 unwinder stuck at 0xc0100210
> Leftover inexact backtrace:
>  =======================
> handlers:
> [<c02c5c22>] (usb_hcd_irq+0x0/0x53)
> Disabling IRQ #217

Just as before.

I can't tell you what's causing this to happen, except that it appears to 
be some sort of hardware problem.  Since it doesn't seem to cause any harm 
you could just live with it.

Or, if you're not using any full-speed or low-speed USB devices, you could 
simply prevent uhci-hcd from loading at all.  Then IRQ 217 wouldn't get 
enabled in the first place.

Alan Stern

