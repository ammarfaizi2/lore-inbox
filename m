Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUA0SJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUA0SJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:09:16 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:56488 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263983AbUA0SJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:09:13 -0500
Date: Tue, 27 Jan 2004 19:09:11 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: SMP AMD64 (Tyan S2882) problems.
Message-ID: <20040127190911.B13769@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

I have a new Opteron server based on Tyan Thunder K8S Pro (S882GNR) board.
The storage is 3ware 7506 controller with 4 disks in RAID-5. The system
has 4GB of RAM, and runs 2.6.1 kernel.

Problem 1:
	I have tried to run a test load (multiple kernel compiles using
make -j4, copying a filesystem subtrees, etc), and I have noticed that
all IRQs go to the CPU0 only. My /proc/interrupts says:

# cat /proc/interrupts
           CPU0       CPU1
  0:    3188815          0    IO-APIC-edge  timer
  1:      10387          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  9:          0          0    IO-APIC-edge  acpi
 24:      46802          0   IO-APIC-level  eth0
 27:     384890          0   IO-APIC-level  3ware Storage Controller
NMI:     903323     881935
LOC:    3188129    3188158
ERR:          0
MIS:          0

Is it normal? How can I set up some IRQ balancing (or at least hard-wire
3ware for CPU1 and eth0 for CPU0)?

Output of "dmesg" is at http://www.fi.muni.cz/~kas/tmp/dmesg-K8SPro.txt

Other problems are not so important or lkml-related:

Problem 2: the 3ware controller does not work correctly on the first
PCI bus (slot 1 and 2) - in slot 1 it hangs under bigger load (e.g.
an array rebuild), in slot 2 it hangs during boot in 3ware BIOS.
It is probably not Linux-specific, but has anyone seen the same problem?

Problem 3:
What the "PCI-DMA: Disabling IOMMU." message in dmesg output means?

Problem 4:
Does Linux support the hardware sensors on this board? The i2c driver
AMD8111 seems to be working, but what sensors driver should I use?

Problem 5:
Is there a 3ware configuration program (tw_cli), which works on AMD64?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
