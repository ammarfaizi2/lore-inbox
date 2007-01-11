Return-Path: <linux-kernel-owner+w=401wt.eu-S1751459AbXAKT4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXAKT4x (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAKT4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:56:52 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:61009 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459AbXAKT4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:56:52 -0500
Message-ID: <45A69634.4090201@lwfinger.net>
Date: Thu, 11 Jan 2007 13:55:32 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Need help with PCI-E interrupts
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for help with PCI-E interrupts. The problem occurs with the following device:

01:00.0 Network controller: Broadcom Corporation Dell Wireless 1390 WLAN Mini-PCI Card (rev 01)
        Subsystem: Hewlett-Packard Company Unknown device 1363
        Flags: bus master, fast devsel, latency 0, IRQ 20
        Memory at c3000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
        Capabilities: [d0] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel

The card is recognized as of the PCI-E variety and appears to be set up properly, but interrupts are
not delivered to the driver as shown by the output of 'cat /proc/interrupts':

           CPU0       CPU1
  0:       4752    1884273   IO-APIC-edge      timer
  1:         21       6306   IO-APIC-edge      i8042
  8:          0          2   IO-APIC-edge      rtc
  9:        249     158866   IO-APIC-fasteoi   acpi
 12:       3670     846095   IO-APIC-edge      i8042
 15:        337      65615   IO-APIC-edge      ide1
 16:       1427     329891   IO-APIC-fasteoi   libata
 17:       2315     925273   IO-APIC-fasteoi   eth0
 18:          0          2   IO-APIC-fasteoi   ohci1394
 19:          3        117   IO-APIC-fasteoi   HDA Intel
 20:          0          0   IO-APIC-fasteoi   ohci_hcd:usb1, bcm43xx
 21:          0          0   IO-APIC-fasteoi   ehci_hcd:usb2
NMI:          0          0
LOC:    1825978    1826429
ERR:          1
MIS:          0

I'm currently have an i386 system, but the problem is there with an x86_64 system. I've tried the
following boot-time fixups: acpi=noirq, irqfixup, irqpoll, pci=routeirq and a UP system without any
effect. It did work a couple of times with the x86_64 system, which made me think it was some kind
of race condition. I have also compared the bcm43xx code with that of the bcm43xx-d80211 version
that works, but I don't find any differences other than those related to design changes. I'm
currently working with 2.6.20-rc4, but get the same results with 2.6.18 and 2.6.19, which need a
PCI-E patch to recognize the card.

I would appreciate any suggestions regarding differences between PCI and PCI-E interrupts.

Thanks,

Larry
