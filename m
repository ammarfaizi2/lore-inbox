Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTAVP2W>; Wed, 22 Jan 2003 10:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTAVP2W>; Wed, 22 Jan 2003 10:28:22 -0500
Received: from exzh001.alcatel.ch ([212.243.156.171]:14603 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP
	id <S261600AbTAVP2V> convert rfc822-to-8bit; Wed, 22 Jan 2003 10:28:21 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] OSS mpu401 exit fix
Date: Wed, 22 Jan 2003 16:37:22 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301221637.22120.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

who is 2.5 OSS maintainer?

if it's not removed then it should be at least stable. patch to fix module
unload bug in mu401. io and irq can't be __initdata since they're used for
the exit function as well...

rgds,
-daniel


===== sound/oss/mpu401.c 1.9 vs edited =====
--- 1.9/sound/oss/mpu401.c	Mon Dec 30 04:18:41 2002
+++ edited/sound/oss/mpu401.c	Wed Jan 22 16:29:39 2003
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

