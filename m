Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264425AbUDZEzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbUDZEzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 00:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUDZEzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 00:55:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49575 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264425AbUDZEzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 00:55:49 -0400
Subject: Problems with pdc202xx_old.c
From: Vince Castellano <surye@datamachine.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082955196.5590.34.camel@aurora.datamachine.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Sun, 25 Apr 2004 21:53:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: linux-2.6.5

I just got a new Promise IDE controller card, and after installing it,
and using the drivers for PDC20265, it appears to be working fine, with
a hard drive on it as /dev/hdf. Then, I tried to burn a CD, and I was
getting errors like this from cdrecord:

Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 30 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x30 Qual 0x00 (incompatible medium installed) Fru 0x0

on a disk I know is blank. So I check dmesg for possible errors, and see
this:

ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  Incompatible medium installed -- (asc=0x30, ascq=0x00)
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "

And looking up dmesg, I see a slew of errors about pdc202xx_old.c as
follows:

hdf: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdf: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdf: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdf: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdf: dma_intr: error=0x84 { DriveStatusError BadCRC }
Badness in pdc202xx_reset_host at drivers/ide/pci/pdc202xx_old.c:599
Call Trace:
 [<c02a63b7>] pdc202xx_reset_host+0x147/0x150
 [<c02b4381>] __ide_dma_host_on+0x11/0x80
 [<c02a63e1>] pdc202xx_reset+0x21/0x50
 [<c02ad7a0>] reset_pollfunc+0x0/0x1d0
 [<c02ad7a0>] reset_pollfunc+0x0/0x1d0
 [<c02adbc8>] do_reset1+0x168/0x200
 [<c02adc75>] ide_do_reset+0x15/0x20
 [<c02b7382>] idedisk_error+0x172/0x220
 [<c02a5bcf>] pdc_old_disable_66MHz_clock+0x3f/0x60
 [<c02b4762>] __ide_dma_end+0x72/0xa0
 [<c02a6144>] pdc202xx_old_ide_dma_end+0x64/0xc0
 [<c02b3d2a>] ide_dma_intr+0x5a/0xb0
 [<c02ac16e>] ide_intr+0xee/0x1a0
 [<c02b3cd0>] ide_dma_intr+0x0/0xb0
 [<c0107719>] handle_IRQ_event+0x49/0x80
 [<c0107a8f>] do_IRQ+0x8f/0x130
 [<c0105ea8>] common_interrupt+0x18/0x20
 [<c03d007b>] auth_unix_add_addr+0x3b/0xb0
 [<c0103bf3>] default_idle+0x23/0x40
 [<c0103c84>] cpu_idle+0x34/0x40
 [<c051285a>] start_kernel+0x19a/0x1e0
 [<c0512480>] unknown_bootoption+0x0/0x120
 
Badness in pdc202xx_reset_host at drivers/ide/pci/pdc202xx_old.c:601
Call Trace:
 [<c02a6377>] pdc202xx_reset_host+0x107/0x150
 [<c02b4381>] __ide_dma_host_on+0x11/0x80
 [<c02a63e1>] pdc202xx_reset+0x21/0x50
 [<c02ad7a0>] reset_pollfunc+0x0/0x1d0
 [<c02ad7a0>] reset_pollfunc+0x0/0x1d0
 [<c02adbc8>] do_reset1+0x168/0x200
 [<c02adc75>] ide_do_reset+0x15/0x20
 [<c02b7382>] idedisk_error+0x172/0x220
 [<c02a5bcf>] pdc_old_disable_66MHz_clock+0x3f/0x60
 [<c02b4762>] __ide_dma_end+0x72/0xa0
 [<c02a6144>] pdc202xx_old_ide_dma_end+0x64/0xc0
 [<c02b3d2a>] ide_dma_intr+0x5a/0xb0
 [<c02ac16e>] ide_intr+0xee/0x1a0
 [<c02b3cd0>] ide_dma_intr+0x0/0xb0
 [<c0107719>] handle_IRQ_event+0x49/0x80
 [<c0107a8f>] do_IRQ+0x8f/0x130
 [<c0105ea8>] common_interrupt+0x18/0x20
 [<c03d007b>] auth_unix_add_addr+0x3b/0xb0
 [<c0103bf3>] default_idle+0x23/0x40
 [<c0103c84>] cpu_idle+0x34/0x40
 [<c051285a>] start_kernel+0x19a/0x1e0
 [<c0512480>] unknown_bootoption+0x0/0x120
 
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.
ide2: reset: master: error (0x00?)

So I am unsure what to look to next. My cdrom drive (which is on the
onboard controller, not the PCI card) now reads empty all even when
there is a valid data disk. If some one could help, I'd appreciate it,
and if those errors help anyone working with pdc202xx_old.c, I'm glad.
Thank you, and please CC any responses my way.

Vince Castellano

