Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUFCDRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUFCDRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbUFCDRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:17:04 -0400
Received: from vt-williston-cuda1k1-188.sbtnvt.adelphia.net ([69.162.184.188]:21701
	"EHLO aluminum.jimlawson.org") by vger.kernel.org with ESMTP
	id S265463AbUFCDQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:16:58 -0400
Message-ID: <40BE982C.1080509@jimlawson.org>
Date: Wed, 02 Jun 2004 23:17:00 -0400
From: Jim Lawson <jim+linux-kernel@jimlawson.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: USB interrupt is turned off after periods of inactivity
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick (and the rest of LKML:)

I am seeing what might be a similar problem (usb interrupts get lost in 
relation to X), and in my case I lose my USB keyboard, which is very 
frustrating. 

Looking at your output, I see some similarities between your system and 
mine.  I am running Debian also, with kernel.org kernel 2.6.6 in my 
case.  I am running unstable, and I suspect you are, too:  this problem 
did not appear until I updated from unstable yesterday, pulling down the 
latest Gnome 2.  Now, at the moment I log out of my Gnome session, and 
gdm restarts X, I lose my USB keyboard, and a similar message appears in 
the logs:

Jun  1 17:18:33 aluminum kernel: irq 10: nobody cared!
Jun  1 17:18:33 aluminum kernel: Call Trace:
Jun  1 17:18:33 aluminum kernel:  [__report_bad_irq+43/144] 
__report_bad_irq+0x2b/0x90
Jun  1 17:18:33 aluminum kernel:  [note_interrupt+100/160] 
note_interrupt+0x64/0xa0
Jun  1 17:18:33 aluminum kernel:  [do_IRQ+303/320] do_IRQ+0x12f/0x140
Jun  1 17:18:33 aluminum kernel:  [process_timeout+0/16] 
process_timeout+0x0/0x10
Jun  1 17:18:33 aluminum kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Jun  1 17:18:33 aluminum kernel:  [process_timeout+0/16] 
process_timeout+0x0/0x10
Jun  1 17:18:33 aluminum kernel:  [preempt_schedule+14/80] 
preempt_schedule+0xe/0x50
Jun  1 17:18:33 aluminum kernel:  [run_timer_softirq+217/432] 
run_timer_softirq+0xd9/0x1b0
Jun  1 17:18:33 aluminum kernel:  [__do_softirq+133/144] 
__do_softirq+0x85/0x90
Jun  1 17:18:33 aluminum kernel:  [do_softirq+44/48] do_softirq+0x2c/0x30
Jun  1 17:18:33 aluminum kernel:  [do_IRQ+265/320] do_IRQ+0x109/0x140
Jun  1 17:18:33 aluminum kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Jun  1 17:18:33 aluminum kernel:
Jun  1 17:18:33 aluminum kernel: handlers:
Jun  1 17:18:33 aluminum kernel: [__crc_sleep_on+2315217/6815505] 
(usb_hcd_irq+0x0/0x70 [usbcore])
Jun  1 17:18:33 aluminum kernel: [__crc_sleep_on+2315217/6815505] 
(usb_hcd_irq+0x0/0x70 [usbcore])
Jun  1 17:18:33 aluminum kernel: Disabling IRQ #10

I'm running 2.6.6 on an Athlon XP 2800+, VIA K6 chipset.  Silicon Image 
controller, SATA drives.  Riva 128 video.

More info on the system in question (from /proc, lspci, etc) at 
http://www.uvm.edu/~jtl/lkml/usbprob/

In my case, I'm not using the Nvidia driver, or any other modules which 
would taint the kernel.

Hope someone can help....
Jim

Nick Piggin wrote:

> After periods of inactivity (maybe 20 minutes?), I come
> back to find the mouse pointer frozen due to the USB
> interrupt turned off.
>
> The USB mouse is the only USB device have connected.
>
> This didn't used to happen, but I couldn't say when it
> started. Maybe a few months ago? (I don't run into it
> often).
>
> I don't think it happens in console mode (ie not X),
> but I'm not 100% sure.
>
> dmesg, interrupts, config attached.


