Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282224AbRK2Ahp>; Wed, 28 Nov 2001 19:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282223AbRK2Ahe>; Wed, 28 Nov 2001 19:37:34 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:18146 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282222AbRK2AhQ>; Wed, 28 Nov 2001 19:37:16 -0500
Subject: [PATCH] 2.5.1-pre3 fix error in drivers/block/rd.c
To: torvalds@transmeta.com
Date: Thu, 29 Nov 2001 00:37:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E169FCV-0006RS-00@draco.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I think someone made a very silly mistake which this patchlet fixes.
Taking a spinlock and returning from a function before releasing it...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.5.1-pre3-vanilla/drivers/block/rd.c.old	Thu Nov 29 00:34:17 2001
+++ linux-2.5.1-pre3-vanilla/drivers/block/rd.c	Thu Nov 29 00:35:03 2001
@@ -437,9 +437,9 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (unit == INITRD_MINOR) {
+		if (!initrd_start) return -ENODEV;
 		spin_lock( &initrd_users_lock );
 		initrd_users++;
-		if (!initrd_start) return -ENODEV;
 		spin_unlock( &initrd_users_lock );
 		filp->f_op = &initrd_fops;
 		return 0;
