Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSFQVmV>; Mon, 17 Jun 2002 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSFQVmU>; Mon, 17 Jun 2002 17:42:20 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:30676 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317036AbSFQVmT>; Mon, 17 Jun 2002 17:42:19 -0400
Message-Id: <200206172142.XAA19452@post.webmailer.de>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.22 ide disk hang on boot
Date: Tue, 18 Jun 2002 01:41:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Arnd Bergmann <arndb@de.ibm.com>, Martin Dalecki <martin@dalecki.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.5.22, I get during the partition detection (2.5.21 was ok):

...
/dev/ide/host0/bus0/target0/lun0: [PTBC] (6201/240/63) p1 p2 p3 <hda: status
error: status = 0x58 [drive ready seek complete data request]
hda: recalibrating

After that, I have to reboot. The machine is an IBM thinkpad A30p, the
ide controller is an ICH3 ("Intel Corp. 82801CAM IDE U100 (rev 1)") and
the drive says it is "IC25T048ATDA05-0".
I tried reverting the last IDE patches but got too many rejects.

After replacing the ata_error that came last with BUG(), I got the
backtrace below (assuming I copied every address correctly from the
screen).

	Arnd <><

Trace; c01f9242 <ata_status_poll+92/c8>
Trace; c01fb2d1 <start_request+c5/17c>
Trace; c01eb38a <__elv_next_request+a/10>
Trace; c01fb64e <queue_commands+126/160>
Trace; c01fb6c8 <do_request+40/68>
Trace; c01fb700 <do_ide_request+10/14>
Trace; c01ec2d7 <generic_unplug_device+3b/48>
Trace; c01ec3c0 <blk_run_queues+6c/7c>
Trace; c0137ea9 <block_sync_page+5/8>
Trace; c01273fa <__lock_page+96/c4>
Trace; c012743c <lock_page+14/18>
Trace; c01289e0 <read_cache_page+a8/100>
Trace; c01526fa <read_dev_sector+32/a4>
Trace; c01397d0 <blkdev_readpage+0/14>
Trace; c0152953 <extended_partition+a7/1ec>
Trace; c01175d7 <printk+ff/114>
Trace; c0152dd5 <msdos_partition+179/2c4>
Trace; c01fd0e0 <ata_get_queue+0/2c>
Trace; c01521d4 <check_partition+1b4/230>
Trace; c0139b35 <bdput+8d/94>
Trace; c0152698 <grok_partitions+e4/114>
Trace; c0150300 <statm_pgd_range+15c/1a8>
Trace; c01f9c31 <ata_revalidate+c9/f0>
Trace; c0200c1c <idedisk_attach+d0/e4>
Trace; c01fa358 <subdriver_match+58/68>
Trace; c01fa67f <register_ata_driver+2f/48>
Trace; c0105023 <init+7/124>
Trace; c010701c <kernel_thread+28/38>

