Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbSK3Apz>; Fri, 29 Nov 2002 19:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbSK3Apz>; Fri, 29 Nov 2002 19:45:55 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:39808 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267195AbSK3Apy>; Fri, 29 Nov 2002 19:45:54 -0500
Date: Sat, 30 Nov 2002 11:53:05 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 / pcmcia doesn't work anymore
Message-ID: <20021130005305.GC3831@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least not for me. :/

If I insert the Xircom RealPort card into the slot whilst the laptop is
running, the event gets registered but all I get out of it is:

PCI: Device 02:00.0 not available because of resource collisions
PCI: Device 02:00.1 not available because of resource collisions

And no serial or ethernet devices. When I eject the card I get an oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c01e9c39
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[pci_remove_device+25/64]    Not tainted
EFLAGS: 00010296
EIP is at pci_remove_device+0x19/0x40
eax: 00000000   ebx: cf6b7800   ecx: cf6b7894   edx: 00000000
esi: 00000000   edi: cf6b7800   ebp: c12aff04   esp: c12aff00
ds: 0068   es: 0068   ss: 0068
Process events/0 (pid: 3, threadinfo=c12ae000 task=c12b2c40)
Stack: cf6b7800 c12aff1c c029f75c cf6b7800 cfdfe000 cfdfe000 c055b240 c12aff44
       c029ca16 cfdfe000 cfdfe000 cfdfe000 cfdfe00c cfdfe000 00000080 c055b240
       c12aff48 c12aff58 c029cd25
029cd65
Call Trace:
 [cb_free+40/104] cb_free+0x28/0x68
 [shutdown_socket+126/244] shutdown_socket+0x7e/0xf4
 [do_shutdown+93/100] do_shutdown+0x5d/0x64
 [parse_events+57/208] parse_events+0x39/0xd0
 [yenta_bh+59/68] yenta_bh+0x3b/0x44
 [worker_thread+467/684] worker_thread+0x1d3/0x2ac
 [worker_thread+0/684] worker_thread+0x0/0x2ac
 [yenta_bh+0/68] yenta_bh+0x0/0x44
 [default_wake_function+0/52] default_wake_function+0x0/0x34
 [default_wake_function+0/52] default_wake_function+0x0/0x34
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

Code: 89 50 04 89 02 8b 53 04 8b 03 89 50 04 89 02 53 e8 9e ff ff
 <5>cs: socket cfdfe000 timed out during reset.  Try increasing setup_delay.

At this point I have no option but to reboot the laptop. Console
switching does not work and neither is the reboot clean (no processes
wind up getting killed from memory).

In 2.5.49 the card was detected nicely and at least ethernet worked
(serial didn't, but that's for another bug report). The card would oops
on eject but that was only when I had the ethernet driver for it (either
old or new version) compiled in.

If you require further info, or any debugging, please holler and I'll
try and help.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
