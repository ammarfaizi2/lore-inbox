Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUGOV7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUGOV7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUGOV67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:58:59 -0400
Received: from mail.enyo.de ([212.9.189.167]:42250 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266397AbUGOV5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:57:47 -0400
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior
 2.6.7/-mm1
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com>
	<1089054013.15671.48.camel@dhcppc4>
	<pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de>
	<slrncfb55n.dkv.jgoerzen@christoph.complete.org>
	<87oemhot7l.fsf@deneb.enyo.de>
	<20040715213711.GJ22472@khan.acc.umu.se>
	<87acy1osk1.fsf@deneb.enyo.de>
	<20040715214646.GK22472@khan.acc.umu.se>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 15 Jul 2004 23:57:45 +0200
In-Reply-To: <20040715214646.GK22472@khan.acc.umu.se> (David Weinehall's
 message of "Thu, 15 Jul 2004 23:46:47 +0200")
Message-ID: <87smbtndba.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Weinehall:

> Strange.  suspend works for me (T40 though, not T40p), latest
> BIOS-version, ACPI enabled, APM disabled.

Thanks for your /proc/interrupts file.  You have a lot less IRQ
sharing than me:

           CPU0       
  0:    5484369          XT-PIC  timer
  1:      13698          XT-PIC  i8042
  2:          0          XT-PIC  cascade
 11:     301909          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, Intel 82801DB-ICH4, eth0, yenta, yenta, radeon@PCI:1:0:0
 12:      14446          XT-PIC  i8042
 14:      63403          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0 
ERR:          0

I wonder why the system has got such a high affinity to IRQ 11.  I've
never seen so much IRQ sharing before. 8-/

I'm going to give it a try without the radeon DRM module.

By the way, here's a log message from the system when it tries to come
back from suspend:

Jul 15 18:44:06 deneb kernel: irq 11: nobody cared!
Jul 15 18:44:06 deneb kernel:  [<c01058ca>] __report_bad_irq+0x2a/0x90
Jul 15 18:44:06 deneb kernel:  [<c01059c0>] note_interrupt+0x70/0xb0
Jul 15 18:44:06 deneb kernel:  [<c0105bd0>] do_IRQ+0xe0/0xf0
Jul 15 18:44:06 deneb kernel:  [<c010406c>] common_interrupt+0x18/0x20
Jul 15 18:44:06 deneb kernel:  [<c01190ee>] __do_softirq+0x2e/0x80
Jul 15 18:44:06 deneb kernel:  [<c0119167>] do_softirq+0x27/0x30
Jul 15 18:44:06 deneb kernel:  [<c0105bb5>] do_IRQ+0xc5/0xf0
Jul 15 18:44:06 deneb kernel:  [<c010406c>] common_interrupt+0x18/0x20
Jul 15 18:44:06 deneb kernel: handlers:
Jul 15 18:44:06 deneb kernel: [<c02d22a0>] (snd_intel8x0_interrupt+0x0/0x200)
Jul 15 18:44:06 deneb kernel: [<c027f310>] (usb_hcd_irq+0x0/0x70)
Jul 15 18:44:06 deneb last message repeated 2 times
Jul 15 18:44:06 deneb kernel: [<c023ca40>] (e1000_intr+0x0/0x90)
Jul 15 18:44:06 deneb kernel: Disabling IRQ #11
Jul 15 18:44:06 deneb kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Jul 15 18:44:06 deneb kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Jul 15 18:44:06 deneb kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Jul 15 18:44:06 deneb kernel: [drm] Loading R200 Microcode
Jul 15 18:44:16 deneb kernel: NETDEV WATCHDOG: eth0: transmit timed out
