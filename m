Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSLPJ6E>; Mon, 16 Dec 2002 04:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbSLPJ6D>; Mon, 16 Dec 2002 04:58:03 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:43273 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266535AbSLPJ6C>; Mon, 16 Dec 2002 04:58:02 -0500
Date: Mon, 16 Dec 2002 10:06:08 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 1/19
Message-ID: <20021216100608.GB7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Four constants:
   DM_DIR,
   DM_MAX_TYPE_NAME,
   DM_NAME_LEN,
   DM_UUID_LEN

Were being declared in device-mapper.h, these are all specific to 
the ioctl interface, so they've been moved to dm-ioctl.h.  Nobody
in userland should ever include <linux/device-mapper.h> so remove 
ifdef __KERNEL guards.
--- diff/include/linux/device-mapper.h	2002-11-11 11:09:38.000000000 +0000
+++ source/include/linux/device-mapper.h	2002-12-16 09:40:25.000000000 +0000
@@ -7,13 +7,6 @@
 #ifndef _LINUX_DEVICE_MAPPER_H
 #define _LINUX_DEVICE_MAPPER_H
 
-#define DM_DIR "mapper"	/* Slashes not supported */
-#define DM_MAX_TYPE_NAME 16
-#define DM_NAME_LEN 128
-#define DM_UUID_LEN 129
-
-#ifdef __KERNEL__
-
 struct dm_target;
 struct dm_table;
 struct dm_dev;
@@ -101,6 +94,4 @@
 int dm_register_target(struct target_type *t);
 int dm_unregister_target(struct target_type *t);
 
-#endif				/* __KERNEL__ */
-
 #endif				/* _LINUX_DEVICE_MAPPER_H */
--- diff/include/linux/dm-ioctl.h	2002-11-11 11:09:38.000000000 +0000
+++ source/include/linux/dm-ioctl.h	2002-12-16 09:40:25.000000000 +0000
@@ -7,9 +7,13 @@
 #ifndef _LINUX_DM_IOCTL_H
 #define _LINUX_DM_IOCTL_H
 
-#include <linux/device-mapper.h>
 #include <linux/types.h>
 
+#define DM_DIR "mapper"	/* Slashes not supported */
+#define DM_MAX_TYPE_NAME 16
+#define DM_NAME_LEN 128
+#define DM_UUID_LEN 129
+
 /*
  * Implements a traditional ioctl interface to the device mapper.
  */
