Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTKSXaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbTKSXaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:30:30 -0500
Received: from mailhost.NMT.EDU ([129.138.4.52]:25529 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S264193AbTKSXa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:30:28 -0500
Date: Wed, 19 Nov 2003 16:30:00 -0700
From: Adam Radford <adam@nmt.edu>
Message-Id: <200311192330.hAJNU0cV005517@speare5-1-13.nmt.edu>
To: marcelo.tosatti@cyclades.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.23-rc3 fix scsi disk targets over 1TB to not EIO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Naur linux-2.4.23-rc2/drivers/scsi/sd.c linux-2.4.23-rc3/drivers/scsi/sd.c
--- linux-2.4.23-rc2/drivers/scsi/sd.c	Mon Aug 25 04:44:42 2003
+++ linux-2.4.23-rc3/drivers/scsi/sd.c	Wed Nov 19 15:15:38 2003
@@ -294,7 +294,8 @@
 
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dev, block, this_count;
+	int dev, this_count;
+	unsigned long block;
 	struct hd_struct *ppnt;
 	Scsi_Disk *dpnt;
 #if CONFIG_SCSI_LOGGING
