Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263824AbTCUS4P>; Fri, 21 Mar 2003 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263826AbTCUSzN>; Fri, 21 Mar 2003 13:55:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34692
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263824AbTCUSyt>; Fri, 21 Mar 2003 13:54:49 -0500
Date: Fri, 21 Mar 2003 20:10:05 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212010.h2LKA5AW026298@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: mpu401 uses __init vars during __exit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/mpu401.c linux-2.5.65-ac2/sound/oss/mpu401.c
--- linux-2.5.65/sound/oss/mpu401.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/mpu401.c	2003-03-06 23:55:25.000000000 +0000
@@ -1762,13 +1762,13 @@
 
 static struct address_info cfg;
 
-static int __initdata io = -1;
-static int __initdata irq = -1;
+static int io = -1;
+static int irq = -1;
 
 MODULE_PARM(irq, "i");
 MODULE_PARM(io, "i");
 
-int __init init_mpu401(void)
+static int __init init_mpu401(void)
 {
 	int ret;
 	/* Can be loaded either for module use or to provide functions
@@ -1785,7 +1785,7 @@
 	return 0;
 }
 
-void __exit cleanup_mpu401(void)
+static void __exit cleanup_mpu401(void)
 {
 	if (io != -1 && irq != -1) {
 		/* Check for use by, for example, sscape driver */
