Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbREYTew>; Fri, 25 May 2001 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbREYTem>; Fri, 25 May 2001 15:34:42 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:44668
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261783AbREYTea>; Fri, 25 May 2001 15:34:30 -0400
Date: Fri, 25 May 2001 21:34:22 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] check kmalloc return in ide-cd.c (244-ac16)
Message-ID: <20010525213422.B851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adds a check for the return value from kmalloc in
ide_cdrom_open. Applies against ac16.


--- linux-244-ac16-clean/drivers/ide/ide-cd.c	Fri May 25 21:11:08 2001
+++ linux-244-ac16/drivers/ide/ide-cd.c	Fri May 25 21:30:20 2001
@@ -2869,12 +2869,12 @@
 int ide_cdrom_open (struct inode *ip, struct file *fp, ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
-	int rc;
+	int rc = -ENOMEM;
 
 	MOD_INC_USE_COUNT;
 	if (info->buffer == NULL)
 		info->buffer = (char *) kmalloc(SECTOR_BUFFER_SIZE, GFP_KERNEL);
-	if ((rc = cdrom_fops.open(ip, fp))) {
+        if ((info->buffer == NULL) || (rc = cdrom_fops.open(ip, fp))) {
 		drive->usage--;
 		MOD_DEC_USE_COUNT;
 	}
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

The police are not here to create disorder.  They're here to preserve
disorder." -Former Chicago mayor Daley during the infamous 1968 Democratic
Party convention
