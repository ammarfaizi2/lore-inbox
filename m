Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270333AbRHHFaI>; Wed, 8 Aug 2001 01:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270335AbRHHF36>; Wed, 8 Aug 2001 01:29:58 -0400
Received: from zok.SGI.COM ([204.94.215.101]:50390 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270333AbRHHF3t>;
	Wed, 8 Aug 2001 01:29:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.8-pre6 - towards a clean kernel compile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Aug 2001 15:29:55 +1000
Message-ID: <29863.997248595@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix duplicate symbols in ieee1394.
Remove dead call to rio_init from tty_io.
Correct missing () in ldm.h.

Some of these patches have already appeared on l-k but they are not in
the latest pre-patch.

Index: 8-pre6.1/drivers/ieee1394/raw1394.c
--- 8-pre6.1/drivers/ieee1394/raw1394.c Fri, 20 Jul 2001 16:36:16 +1000 kaos (linux-2.4/u/b/50_raw1394.c 1.1.1.2 644)
+++ 8-pre6.1(w)/drivers/ieee1394/raw1394.c Wed, 08 Aug 2001 11:14:21 +1000 kaos (linux-2.4/u/b/50_raw1394.c 1.1.1.2 644)
@@ -45,7 +45,7 @@ static devfs_handle_t devfs_handle;
 
 LIST_HEAD(host_info_list);
 static int host_count;
-spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
 
 static struct hpsb_highlevel *hl_handle;
 
Index: 8-pre6.1/drivers/ieee1394/nodemgr.c
--- 8-pre6.1/drivers/ieee1394/nodemgr.c Tue, 31 Jul 2001 11:09:45 +1000 kaos (linux-2.4/H/e/29_nodemgr.c 1.2 644)
+++ 8-pre6.1(w)/drivers/ieee1394/nodemgr.c Wed, 08 Aug 2001 11:14:21 +1000 kaos (linux-2.4/H/e/29_nodemgr.c 1.2 644)
@@ -43,7 +43,7 @@ static LIST_HEAD(node_list);
 rwlock_t node_lock = RW_LOCK_UNLOCKED;
 
 static LIST_HEAD(host_info_list);
-spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
 
 struct bus_options {
 	u8	irmc;		/* Iso Resource Manager Capable */
Index: 8-pre6.1/drivers/char/tty_io.c
--- 8-pre6.1/drivers/char/tty_io.c Thu, 19 Jul 2001 11:12:10 +1000 kaos (linux-2.4/b/c/32_tty_io.c 1.1.2.2.1.1.1.4 644)
+++ 8-pre6.1(w)/drivers/char/tty_io.c Wed, 08 Aug 2001 11:31:00 +1000 kaos (linux-2.4/b/c/32_tty_io.c 1.1.2.2.1.1.1.4 644)
@@ -105,7 +105,6 @@
 #ifdef CONFIG_VT
 extern void con_init_devfs (void);
 #endif
-extern int rio_init(void);
 
 #define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
 #define TTY_DEV MKDEV(TTYAUX_MAJOR,0)
@@ -2341,9 +2340,6 @@ void __init tty_init(void)
 #endif
 #ifdef CONFIG_SPECIALIX
 	specialix_init();
-#endif
-#ifdef CONFIG_RIO
-	rio_init();
 #endif
 #if (defined(CONFIG_8xx) || defined(CONFIG_8260))
 	rs_8xx_init();
Index: 8-pre6.1/fs/partitions/ldm.h
--- 8-pre6.1/fs/partitions/ldm.h Sun, 05 Aug 2001 13:29:36 +1000 kaos (linux-2.4/I/e/44_ldm.h 1.2 644)
+++ 8-pre6.1(w)/fs/partitions/ldm.h Wed, 08 Aug 2001 11:14:24 +1000 kaos (linux-2.4/I/e/44_ldm.h 1.2 644)
@@ -81,13 +81,13 @@
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
 
 /* Borrowed from msdos.c */
-#define SYS_IND(p)		(get_unaligned(&p->sys_ind))
-#define NR_SECTS(p)		({ __typeof__(p->nr_sects) __a =	\
-					get_unaligned(&p->nr_sects);	\
+#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
+#define NR_SECTS(p)		({ __typeof__((p)->nr_sects) __a =3D	\
+					get_unaligned(&(p)->nr_sects);	\
 					le32_to_cpu(__a);		\
 				})
-#define START_SECT(p)		({ __typeof__(p->start_sect) __a =	\
-					get_unaligned(&p->start_sect);	\
+#define START_SECT(p)		({ __typeof__((p)->start_sect) __a =3D	\
+					get_unaligned(&(p)->start_sect);\
 					le32_to_cpu(__a);		\
 				})
 

