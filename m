Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUAQTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUAQTrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:47:16 -0500
Received: from fep05-svc.mail.telepac.pt ([194.65.5.209]:19420 "EHLO
	fep05-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S266132AbUAQTrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:47:11 -0500
Date: Sat, 17 Jan 2004 19:47:07 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] Remove ide bootup noise
Message-ID: <20040117194707.GC19667@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,


Recently, while syncing my local tree from 2.4.22 to 2.4.25-pre I found 
this little patchlet (back from the 2.4.20 days, AFAIR) that still 
applies and looks pertinent. I believe the original author is Erik 
Andersen, although I can't say for certain since I don't have the 
original email around anymore. Also, I seem to recall that Jens Axboe 
ok'ed it, but for whatever reason it never found its way into mainline.

This will remove the pointless boot message about wether or not the drive 
supports host protected area. Since we don't report any other drive 
capabilities this should go, as it' is just pointless noise. In 2.6 this 
was killed too. Also, this information can be obtained using 'hdparm'.

Please review and apply.


Regards,


		Nuno




--- linux-2.4.25-pre5/drivers/ide/ide-disk.c.orig	2004-01-15 22:20:25.355342064 +0000
+++ linux-2.4.25-pre5/drivers/ide/ide-disk.c	2004-01-15 22:25:48.189263848 +0000
@@ -1136,10 +1136,7 @@
  */
 static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
 {
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
+	return ((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
 }
 
 /*


