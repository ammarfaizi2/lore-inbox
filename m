Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281199AbRKHHKc>; Thu, 8 Nov 2001 02:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281255AbRKHHKW>; Thu, 8 Nov 2001 02:10:22 -0500
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:37057 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S281199AbRKHHKD>; Thu, 8 Nov 2001 02:10:03 -0500
Date: Thu, 8 Nov 2001 12:39:32 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for redefinition of jedec_probe_init
Message-ID: <Pine.LNX.4.21.0111081237330.24010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On inclusion of both these files (modules disabled) the build breaks.
This is because jedec_probe_init () is defined in both these files.

I am sending a patch which makes them static. Of course, there
is another option, since both these functions are doing the same
thing, we could delete one of them. 


diff -u -r /home/manik/linux/orig/linux/drivers/mtd/chips/jedec.c ./drivers/mtd/chips/jedec.c
--- /home/manik/linux/orig/linux/drivers/mtd/chips/jedec.c	Fri Oct  5 03:44:59 2001
+++ ./drivers/mtd/chips/jedec.c	Thu Nov  8 11:12:28 2001
@@ -873,7 +873,7 @@
    }
 }
 
-int __init jedec_probe_init(void)
+static int __init jedec_probe_init(void)
 {
 	register_mtd_chip_driver(&jedec_chipdrv);
 	return 0;
diff -u -r /home/manik/linux/orig/linux/drivers/mtd/chips/jedec_probe.c ./drivers/mtd/chips/jedec_probe.c
--- /home/manik/linux/orig/linux/drivers/mtd/chips/jedec_probe.c	Fri Oct  5 03:44:59 2001
+++ ./drivers/mtd/chips/jedec_probe.c	Thu Nov  8 11:12:31 2001
@@ -422,7 +422,7 @@
 	module: THIS_MODULE
 };
 
-int __init jedec_probe_init(void)
+static int __init jedec_probe_init(void)
 {
 	register_mtd_chip_driver(&jedec_chipdrv);
 	return 0;

