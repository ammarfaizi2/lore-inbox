Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135397AbRDRWDJ>; Wed, 18 Apr 2001 18:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135399AbRDRWDA>; Wed, 18 Apr 2001 18:03:00 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:41940 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S135397AbRDRWCr>;
	Wed, 18 Apr 2001 18:02:47 -0400
From: Khalid Aziz <khalid@lyra.fc.hp.com>
Message-Id: <200104182203.QAA09409@lyra.fc.hp.com>
Subject: [PATCH] Incorrect command size for group 4 SCSI commands
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Apr 2001 16:03:21 -0600 (MDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI subsystem defines the size of group 4 SCSI commands as 12. This is
incorrect. SCSI-3 specs define group 4 command size as 16. Following
patch fixes this. 

Thanks, 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO


--- linux-2.4.3-orig/drivers/scsi/scsi.c	Fri Feb  9 12:30:23 2001
+++ linux-2.4.3/drivers/scsi/scsi.c	Wed Apr 18 14:22:00 2001
@@ -104,7 +104,7 @@
 const unsigned char scsi_command_size[8] =
 {
 	6, 10, 10, 12,
-	12, 12, 10, 10
+	16, 12, 10, 10
 };
 static unsigned long serial_number;
 static Scsi_Cmnd *scsi_bh_queue_head;
