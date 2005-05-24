Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVEXX1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVEXX1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVEXX1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:27:43 -0400
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:62620 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262159AbVEXX1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:27:33 -0400
Message-ID: <4293B859.3070609@jg555.com>
Date: Tue, 24 May 2005 16:27:21 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Random IDE Lock ups with via IDE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using the 2.6.10.x series kernel for a while on my other 
systems with no issues at all.

But on my laptop which has the via 686 chipset, I started having some 
wierd issues. This happens after about 2 weeks of non-shutting down

Here is a sample of the data from my kernel log
About the device
May 24 16:22:22 laptop kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
May 24 16:22:22 laptop kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
May 24 16:22:22 laptop kernel: VP_IDE: IDE controller at PCI slot 
0000:00:07.1
May 24 16:22:22 laptop kernel: VP_IDE: chipset revision 16
May 24 16:22:22 laptop kernel: VP_IDE: not 100%% native mode: will probe 
irqs later
May 24 16:22:22 laptop kernel: VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 
controller on pci0000:00:07.1
May 24 16:22:22 laptop kernel:     ide0: BM-DMA at 0x1100-0x1107, BIOS 
settings: hda:DMA, hdb:pio
May 24 16:22:22 laptop kernel:     ide1: BM-DMA at 0x1108-0x110f, BIOS 
settings: hdc:DMA, hdd:pio
May 24 16:22:22 laptop kernel: Probing IDE interface ide0...
May 24 16:22:22 laptop kernel: hda: FUJITSU MHS2030AT, ATA DISK drive
May 24 16:22:22 laptop kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 24 16:22:22 laptop kernel: Probing IDE interface ide1...
May 24 16:22:22 laptop kernel: hdc: DW-224E, ATAPI CD/DVD-ROM drive
May 24 16:22:22 laptop kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 24 16:22:22 laptop kernel: hda: max request size: 128KiB
May 24 16:22:22 laptop kernel: hda: 58605120 sectors (30005 MB) 
w/2048KiB Cache, CHS=58140/16/63
May 24 16:22:22 laptop kernel: hda: cache flushes supported
May 24 16:22:22 laptop kernel:  hda: hda1 hda2 hda3 hda4

Error Messages
First sign of the problem
May 24 01:37:03 laptop kernel: ide: failed opcode was: unknown
May 24 01:37:03 laptop kernel: ide0: reset: success
May 24 01:38:15 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 01:38:15 laptop kernel:
May 24 01:38:15 laptop kernel: ide: failed opcode was: unknown
May 24 01:38:17 laptop kernel: ide0: reset: success
May 24 01:47:57 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 01:47:57 laptop kernel:
May 24 01:47:57 laptop kernel: ide: failed opcode was: unknown
May 24 01:48:32 laptop kernel: ide0: reset timed-out, status=0xd0
May 24 01:48:32 laptop kernel: hda: status timeout: status=0xd0 { Busy }
May 24 01:48:32 laptop kernel:
May 24 01:48:32 laptop kernel: ide: failed opcode was: unknown
May 24 01:48:32 laptop kernel: hda: drive not ready for command
May 24 01:48:32 laptop kernel: ide0: reset: success
May 24 01:50:59 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 01:50:59 laptop kernel:
May 24 01:50:59 laptop kernel: ide: failed opcode was: unknown
May 24 01:51:04 laptop kernel: ide0: reset: success
May 24 01:53:44 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 01:53:49 laptop kernel:
May 24 01:53:49 laptop kernel: ide: failed opcode was: unknown
May 24 01:53:49 laptop kernel: ide0: reset: success
May 24 01:54:14 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 01:54:25 laptop kernel:
May 24 01:54:25 laptop kernel: ide: failed opcode was: unknown
May 24 01:54:25 laptop kernel: ide0: reset: success
May 24 02:00:12 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 02:00:12 laptop kernel:
May 24 02:00:12 laptop kernel: ide: failed opcode was: unknown
May 24 02:00:16 laptop kernel: ide0: reset: success
May 24 02:00:35 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 02:00:35 laptop kernel:
May 24 02:00:35 laptop kernel: ide: failed opcode was: unknown
May 24 02:00:47 laptop kernel: ide0: reset: success
May 24 02:23:36 laptop kernel: hda: status timeout: status=0xd0 { Busy }

Different error messages
May 24 16:10:47 laptop kernel: hda: status timeout: status=0xd0 { Busy }
May 24 16:10:47 laptop kernel:
May 24 16:10:47 laptop kernel: ide: failed opcode was: unknown
May 24 16:10:47 laptop kernel: hda: no DRQ after issuing MULTWRITE
May 24 16:10:50 laptop kernel: ide0: reset: success
May 24 16:14:50 laptop kernel: hda: status timeout: status=0xd0 { Busy }
May 24 16:14:50 laptop kernel:
May 24 16:14:50 laptop kernel: ide: failed opcode was: unknown
May 24 16:14:50 laptop kernel: hda: no DRQ after issuing MULTWRITE
May 24 16:14:55 laptop kernel: ide0: reset: success
May 24 16:15:35 laptop kernel: hda: irq timeout: status=0xd0 { Busy }
May 24 16:15:35 laptop kernel:
May 24 16:15:35 laptop kernel: ide: failed opcode was: unknown
May 24 16:15:37 laptop kernel: ide0: reset: success
May 24 16:16:01 laptop kernel: hda: status timeout: status=0xd0 { Busy }
May 24 16:16:01 laptop kernel:
May 24 16:16:01 laptop kernel: ide: failed opcode was: unknown
May 24 16:16:01 laptop kernel: hda: no DRQ after issuing MULTWRITE
May 24 16:16:01 laptop kernel: ide0: reset: success

The issue is also described here in this forum post from someone else
http://forums.viaarena.com/messageview.aspx?catid=28&threadid=66084&enterthread=y

-- 
----
Jim Gifford
maillist@jg555.com

