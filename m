Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbTBFTKa>; Thu, 6 Feb 2003 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTBFTKa>; Thu, 6 Feb 2003 14:10:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267562AbTBFTK3>;
	Thu, 6 Feb 2003 14:10:29 -0500
Subject: [PATCH 2.5] fix megaraid driver compile error
From: Mark Haverkamp <markh@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1044559247.4858.49.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 Feb 2003 11:20:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves access of the host element to device since host has been
removed from struct scsi_cmnd.


===== drivers/scsi/megaraid.c 1.32 vs edited =====
--- 1.32/drivers/scsi/megaraid.c        Fri Jan  3 10:58:49 2003
+++ edited/drivers/scsi/megaraid.c      Thu Feb  6 10:18:43 2003
@@ -4515,7 +4515,7 @@
                if(scsicmd == NULL) return -ENOMEM;

                memset(scsicmd, 0, sizeof(Scsi_Cmnd));
-               scsicmd->host = shpnt;
+               scsicmd->device->host = shpnt;

                if( outlen || inlen ) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
@@ -4652,7 +4652,7 @@
                if(scsicmd == NULL) return -ENOMEM;

                memset(scsicmd, 0, sizeof(Scsi_Cmnd));
-               scsicmd->host = shpnt;
+               scsicmd->device->host = shpnt;

                if (outlen || inlen) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-- 
Mark Haverkamp <markh@osdl.org>

