Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSLLJ0s>; Thu, 12 Dec 2002 04:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSLLJ0r>; Thu, 12 Dec 2002 04:26:47 -0500
Received: from dp.samba.org ([66.70.73.150]:40164 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265683AbSLLJ0q>;
	Thu, 12 Dec 2002 04:26:46 -0500
Date: Thu, 12 Dec 2002 20:33:34 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] 2.5 fix for > 25 disks
Message-ID: <20021212093334.GA30312@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.5 currently tries to register disk sda twice. Not nice and now we use
sysfs to do name to dev_t mapping, I couldnt mount my root filesystem.

Anton

===== drivers/scsi/sd.c 1.96 vs edited =====
--- 1.96/drivers/scsi/sd.c	Sat Nov 30 09:56:42 2002
+++ edited/drivers/scsi/sd.c	Thu Dec 12 20:19:12 2002
@@ -1217,7 +1217,7 @@
 	gd->minors = 16;
 	gd->fops = &sd_fops;
 
-	if (index > 26) {
+	if (index >= 26) {
 		sprintf(gd->disk_name, "sd%c%c",
 			'a' + index/26-1,'a' + index % 26);
 	} else {
