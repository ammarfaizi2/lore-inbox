Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbTGWL6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270218AbTGWL6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:58:11 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:10679 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S270214AbTGWL6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:58:02 -0400
Date: Wed, 23 Jul 2003 14:13:07 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: IDE TCQ Oops in 2.6.0-test1
Message-ID: <20030723141306.B17013@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello, I've just tried to test 2.6.0-test1 with IDE TCQ on,
and I've got the following Oops during boot, just after discovering
the first IDE drive (IBM DTLA 45GB). Rebuilding without
CONFIG_BLK_DEV_IDE_TCQ fixes the problem (altough I still have problems
with LVM on 2.6.0-test1).

	More info on both hardware and software of this box is available
on request.

-Yenya

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010046
EIP is at 0x0
eax: f7f9fd9c   ebx: c045a77c   ecx: c045a76c   edx: 00000000
esi: 00000000   edi: 00000001   ebp: f7f9fd4c   esp: f7f9fd34
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9e000 task=c1cbb840)
Stack: c0273683 c045a77c f7f9fd9c 00000000 f7f9fd9c 00000202 f7f9fd88 c028c0cd 
       c045a77c f7f9fd9c 00000001 00000000 00000001 00000000 00000000 f7f9fd70 
       f7f9fd70 00000000 00000000 f7d53640 f7f9fd9c f7f9fe48 c029116d c045a76c 
Call Trace:
 [<c0273683>] __elv_add_request+0x33/0x50
 [<c028c0cd>] ide_do_drive_cmd+0xad/0x120
 [<c029116d>] ide_diag_taskfile+0x8d/0xc0
 [<c02911c7>] ide_raw_taskfile+0x27/0x30
 [<c029ba82>] ide_tcq_configure+0xa2/0x120
 [<c029bb5a>] ide_enable_queued+0x5a/0x100
 [<c029bd6f>] __ide_dma_queued_on+0x8f/0xc0
 [<c029a1e1>] __ide_dma_on+0x51/0x60
 [<c028a6da>] via82cxxx_ide_dma_check+0xda/0xf0
 [<c028a600>] via82cxxx_ide_dma_check+0x0/0xf0
 [<c028cf17>] probe_hwif+0x267/0x490
 [<c028d164>] probe_hwif_init+0x24/0x80
 [<c02997ae>] ide_setup_pci_device+0x4e/0x80
 [<c03edc3d>] via_init_one+0x3d/0x80
 [<c03eea4d>] ide_scan_pcidev+0x5d/0x70
 [<c03eeaa6>] ide_scan_pcibus+0x46/0xe0
 [<c03ee803>] probe_for_hwifs+0x13/0x20
 [<c03ee818>] ide_init_builtin_drivers+0x8/0x20
 [<c03ee86c>] ide_init+0x3c/0x50
 [<c03d676c>] do_initcalls+0x2c/0xa0
 [<c0129972>] init_workqueues+0x12/0x60
 [<c010506d>] init+0x2d/0x180
 [<c0105040>] init+0x0/0x180
 [<c0107219>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|__ If you want "aesthetics", go play with microkernels. -Linus Torvalds __|
