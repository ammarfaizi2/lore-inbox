Return-Path: <linux-kernel-owner+w=401wt.eu-S1750725AbXAUOaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXAUOaO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 09:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAUOaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 09:30:13 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:45846 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbXAUOaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 09:30:12 -0500
Date: Sun, 21 Jan 2007 15:29:32 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>,
       =?ISO-8859-15?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>
Subject: SATA exceptions triggered by XFS (since 2.6.18)
Message-ID: <20070121152932.6dc1d9fb@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for starting a new thread, but I've deleted the messages from my
mail-box, and I'm sot sure it's the same problem as here:
	http://lkml.org/lkml/2007/1/14/108

Today I've decided to try XFS... and just doing anything on it
(extracting a tarball, for example) make my SATA HD go crazy ;)

I don't remember to have seen this using Ext3.

[  877.839920] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
[  877.839929] ata1.00: cmd 61/02:00:64:98:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 1024 out
[  877.839931]          res 40/00:00:00:4f:c2/00:00:00:4f:c2/00 Emask 0x4 (timeout)
[  878.142367] ata1: soft resetting port
[  878.351791] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  878.354384] ata1.00: configured for UDMA/133
[  878.354392] ata1: EH complete
[  878.355696] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  878.355716] sda: Write Protect is off
[  878.355718] sda: Mode Sense: 00 3a 00 00
[  878.355745] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA


It takes nothing to reproduce it.

My hardware is:

00:00.0 Host bridge: Intel Corporation 82P965/G965 Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82G965 Integrated Graphics Controller (rev 02)
00:03.0 Communication controller: Intel Corporation 82P965/G965 HECI Controller (rev 02)
00:19.0 Ethernet controller: Intel Corporation 82566DC Gigabit Network Connection (rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801HB (ICH8) 4 port SATA AHCI Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 02)
02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)


with a Seagate Barracurda 7200rpm 80GB HD


I've so far tested these kernels:
2.6.20-rc5	BAD
2.6.20-rc4	BAD
2.6.19		BAD
2.6.18		BAD
2.6.17		Good !

I'll start a git-bisection...

-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64
