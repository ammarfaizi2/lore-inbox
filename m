Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266899AbUHCV4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266899AbUHCV4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUHCV4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:56:20 -0400
Received: from bardeen.wciatl.com ([216.27.171.202]:53390 "EHLO wciatl.com")
	by vger.kernel.org with ESMTP id S266896AbUHCVzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:55:00 -0400
Subject: Booting 2.6.x slows to almost to a halt when detecting hard drives
	on Dell Inspiron 5150
From: Jacques Fortier <jacquesf@wciatl.com>
Reply-To: jacquesf@wciatl.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Williams Consulting, Inc.
Date: Tue, 03 Aug 2004 17:54:58 -0400
Message-Id: <1091570098.1612.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've had issues getting 2.6 kernels to boot. It seems to be an issue
either with my Intel ICH4 IDE controller or my Hitachi Travelstar 60GB
disk.

I'm trying to get 2.6 working on a Dell Inspiron 5150. I've been running
2.4 for a while without any problems. I've witnessed this problem in the
Debian 2.6.7 and 2.6.6 kernel packages, 2.6.7 compiled from the Debian
source code, and 2.6.7 compiled from the vanilla kernel.org source.

Everything seems to work fine until the hard drive detection starts.
Since I'm not sure how much of this stuff if relelvant, I've
painstakingly transcribed a bunch of the output

ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA hdb:pio
    ide1: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA hdb:pio
hda: SAMSUNG CDRW/DVD SN-324F, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7 0x3f6 on irq 14
hdc HTS548060M9AT00, ATA DISK drive
ide1 at 0x170-0x177 0x376 on irq 15
hdc: max request size: 1024KiB
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt

After the max request size, things grind almost completely to a halt. A
few minutes later, it finally correctly detects the disk size, etc of
hdc. It then starts working on the partitions, taking a very long time
to print each one. Interspersed among the partition detections messages
are more lost interrupts as well as the following two messages:

hdc: dma_timer_expiry: dma status == 0x24
and
hdc: DMA interrupt recovery

The output above seems pretty consistent with what I get from dmesg on
2.4.26 (minus the error messages of course).

I haven't seen how far the boot will go because I haven't had time to
leave it unattended and am kind of scared that it might cause corruption
or some other nastiness. If it would be useful, I could try backing
things up and then letting it try to boot overnight.

I've compiled IDE support in directly. I've tried things both with and
without support for the Intel ICH compiled in ("Intel PIIXn chipsets
support"). I'm not using SMP. I don't think there's anything
particularly remarkable about the rest of my configuration, but I can
provide any other details that are needed.

Jacques Fortier



