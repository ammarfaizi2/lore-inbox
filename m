Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFBQRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFBQRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFBQRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:17:07 -0400
Received: from math.ut.ee ([193.40.36.2]:65476 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261184AbVFBQPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:15:34 -0400
Date: Thu, 2 Jun 2005 19:15:31 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Disabling IRQ #11 - uhci || e100 || r128-dri problem
Message-ID: <Pine.SOC.4.61.0506021906200.11783@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In recent 2.6.12 prereleases a bug has appeared. Whenever I log out of 
KDE, IRQ 11 is disabled on X server restart (kdm restarts it). It always 
results with the dmesg below and sometimes the new X loses keyboard 
input (ps2 keyboard, usb mouse). USB mouse works well. X works (sans 
keyboard sometimes). Network is dead.

irq 11: nobody cared!
  [<c0136144>] __report_bad_irq+0x24/0x90
  [<c0136241>] note_interrupt+0x61/0x90
  [<c0135c1b>] __do_IRQ+0x13b/0x150
  [<c0105607>] do_IRQ+0x47/0x70
  =======================
  [<c0103b2a>] common_interrupt+0x1a/0x20
  [<c011dfce>] __do_softirq+0x2e/0x80
  [<c0105711>] do_softirq+0x41/0x50
  =======================
  [<c011e0e5>] irq_exit+0x35/0x40
  [<c010560e>] do_IRQ+0x4e/0x70
  [<c0103b2a>] common_interrupt+0x1a/0x20
handlers:
[<e09622b0>] (usb_hcd_irq+0x0/0x60 [usbcore])
[<c02aabb0>] (e100_intr+0x0/0x150)

Disabling IRQ #11
Celeron 900, Intel ICH2 chipset with integrated UHCI and onboard e100 
NIC, running Debian unstable with XFree 4.3. 2.6.12-rc2 + XFree of that 
time was OK, didn't try rc3 and rc4, rc5 probably also not tested but 
rc5+git snapshots are the broken ones (together with current XFree). ATI 
rage128 graphics with DRI enabled; I get the following dmesg lines on 
X server start and at least the agpgart lines on each X server restart 
too. I have seen this bug some time earlier too, probably in 2.6.11 
timeframe, or in early 2.6.12 timeframe.

[drm] Initialized r128 2.5.0 20030725 on minor 0: ATI Technologies Inc Rage 128 RF/SG AGP
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 2x mode

/proc/interrupts during normal work:
            CPU0
   0:   13006046          XT-PIC  timer
   1:      26607          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   7:          1          XT-PIC  parport0
   8:          4          XT-PIC  rtc
   9:          1          XT-PIC  acpi, Intel 82801BA-ICH2
  10:     336628          XT-PIC  uhci_hcd:usb2
  11:    1161748          XT-PIC  uhci_hcd:usb1, eth0, r128@PCI:2:0:0
  14:      48258          XT-PIC  ide0
  15:     194377          XT-PIC  ide1
NMI:       2680
LOC:   13007697
ERR:          0
MIS:          0


-- 
Meelis Roos (mroos@linux.ee)
