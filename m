Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWJHXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWJHXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWJHXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932099AbWJHXQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:27 -0400
Date: Mon, 9 Oct 2006 01:16:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: [2.6.19 patch] ATA must depend on BLOCK
Message-ID: <20061008231621.GM6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_ATA=y, 
CONFIG_BLOCK=n:

<--  snip  -->

...
  CC      drivers/ata/libata-scsi.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c: In function ‘ata_scsi_dev_config’:
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:791: warning: implicit declaration of function ‘blk_queue_max_sectors’
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799: error: ‘request_queue_t’ undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799: error: for each function it appears in.)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799: error: ‘q’ undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:800: warning: implicit declaration of function ‘blk_queue_max_hw_segments’
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c: In function ‘ata_scsi_slave_config’:
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:831: 
warning: implicit declaration of function ‘blk_queue_max_phys_segments’
make[3]: *** [drivers/ata/libata-scsi.o] Error 1

<--  snip  -->

Bug report by Jesper Juhl.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/ata/Kconfig.old	2006-10-08 23:40:05.000000000 +0200
+++ linux-2.6/drivers/ata/Kconfig	2006-10-08 23:40:55.000000000 +0200
@@ -6,6 +6,7 @@
 
 config ATA
 	tristate "ATA device support"
+	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
 	select SCSI

