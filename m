Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVGGIIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVGGIIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVGGIHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:07:37 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:28378 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261243AbVGGIEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:04:41 -0400
Subject: SATA: Assertion failed! qc->flags &
	ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
From: Soeren Sonnenburg <kernel@nn7.de>
To: jgarzik@pobox.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 10:04:33 +0200
Message-Id: <1120723473.18056.29.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I am using your ata-passthru patch

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.12-git4-passthru1.patch.bz2  


with hddtemp regularly polling for the temperature state together with
libsata from kernel 2.6.12 on a promise tx2. The disk is set to go to
sleep mode (hdparm -S 35 /dev/sda). And after a couple of hours the
machine oopsed (the disk was sleeping/not mounted at that time - with
high probability) :

ata2: command timeout
ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0xb0 { Busy }
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0118eac
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0118eac>]    Tainted: P      VLI
EFLAGS: 00010082   (2.6.12) 
EIP is at complete+0xc/0x40
eax: 00000000   ebx: 00000082   ecx: 00000000   edx: 00000000
esi: f3b45ab8   edi: 00000292   ebp: f7d11e7c   esp: f7d11e64
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_1 (pid: 320, threadinfo=f7d10000 task=f7c735b0)
Stack: 00000000 f3b45ab8 00000292 c0311544 f7c02c4c f7c71b40 f7c02c4c c03125d4 
       f3b45ab8 c02d18f2 f3b45ab8 f7c72460 c0350945 f3b45ab8 00000001 00000000 
       00000016 f7c7252e f5df5dc6 f7c72460 c0350c9e f7c72460 00000001 00000000 
Call Trace:
 [<c0311544>] blk_end_sync_rq+0x24/0x40
 [<c03125d4>] end_that_request_last+0x54/0xa0
 [<c02d18f2>] add_disk_randomness+0x32/0x40
 [<c0350945>] scsi_end_request+0xb5/0xe0
 [<c0350c9e>] scsi_io_completion+0x17e/0x4e0
 [<c035d650>] sd_rw_intr+0xc0/0x230
 [<c034be6e>] scsi_finish_command+0x8e/0xb0
 [<c035b1d5>] ata_scsi_qc_complete+0x45/0x90
 [<c0358d6a>] ata_qc_complete+0x3a/0xd0
 [<c035c480>] pdc_eng_timeout+0x90/0x120
 [<c035ad2a>] ata_scsi_error+0x1a/0x30
 [<c034fcea>] scsi_error_handler+0x8a/0xd0
 [<c034fc60>] scsi_error_handler+0x0/0xd0
 [<c0101311>] kernel_thread_helper+0x5/0x14
Code: eb fe ff ff 53 9d 8b 5d f4 8b 75 f8 8b 7d fc c9 c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 18 89 5d fc 9c 5b fa <ff> 00 83 c0 04 c7 44 24 10 00 00 00 00 c7 44 24 0c 00 00 00 00 

I am now trying w/o hddtemp, lets see how long it survives...

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

