Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTB0T3t>; Thu, 27 Feb 2003 14:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTB0T3t>; Thu, 27 Feb 2003 14:29:49 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30851 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266640AbTB0T3q>; Thu, 27 Feb 2003 14:29:46 -0500
Message-Id: <200302271940.h1RJe1JT010312@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 - if/ifdef janitor work - include/linux/*
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1349971881P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 14:40:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1349971881P
Content-Type: text/plain; charset=us-ascii

Cleaning up include/linux...

--- include/linux/sched.h.dist	2003-02-24 14:05:07.000000000 -0500
+++ include/linux/sched.h	2003-02-27 01:36:55.213742840 -0500
@@ -466,7 +466,7 @@
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
--- include/linux/blkdev.h.dist	2003-02-24 14:05:12.000000000 -0500
+++ include/linux/blkdev.h	2003-02-27 01:37:21.380998808 -0500
@@ -302,7 +302,7 @@
 #define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
-#if CONFIG_MMU
+#ifdef CONFIG_MMU
 extern int init_emergency_isa_pool(void);
 extern void blk_queue_bounce(request_queue_t *q, struct bio **bio);
 #else
--- include/linux/timer.h.dist	2003-02-24 14:05:38.000000000 -0500
+++ include/linux/timer.h	2003-02-27 01:37:44.631114260 -0500
@@ -65,7 +65,7 @@
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
   
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list * timer);
 #else
 # define del_timer_sync(t) del_timer(t)
--- include/linux/nfs_fs_sb.h.dist	2003-02-24 14:06:03.000000000 -0500
+++ include/linux/nfs_fs_sb.h	2003-02-27 01:38:00.027853268 -0500
@@ -27,7 +27,7 @@
 	char *			hostname;	/* remote hostname */
 	struct nfs_fh		fh;
 	struct sockaddr_in	addr;
-#if CONFIG_NFS_V4
+#ifdef CONFIG_NFS_V4
 	/* Our own IP address, as a null-terminated string.
 	 * This is used to generate the clientid, and the callback address.
 	 */
--- include/linux/tpqic02.h.dist	2003-02-24 14:05:11.000000000 -0500
+++ include/linux/tpqic02.h	2003-02-27 01:39:24.963929504 -0500
@@ -12,7 +12,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_QIC02_TAPE || CONFIG_QIC02_TAPE_MODULE
+#if defined(CONFIG_QIC02_TAPE) || defined(CONFIG_QIC02_TAPE_MODULE)
 
 /* need to have QIC02_TAPE_DRIVE and QIC02_TAPE_IFC expand to something */
 #include <linux/mtio.h>
@@ -724,7 +724,7 @@
 	unsigned short	dma_enable_value;
 };
 
-#if MODULE
+#ifdef MODULE
 static int qic02_tape_init(void);
 #else
 extern int qic02_tape_init(void);			  /* for mem.c */
--- include/linux/smp_lock.h.dist	2003-02-24 14:05:40.000000000 -0500
+++ include/linux/smp_lock.h	2003-02-27 01:45:00.424031816 -0500
@@ -5,7 +5,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 
 extern spinlock_t kernel_flag;
 
--- include/linux/interrupt.h.dist	2003-02-24 14:05:33.000000000 -0500
+++ include/linux/interrupt.h	2003-02-27 02:01:32.824663760 -0500
@@ -28,7 +28,7 @@
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
-#if !CONFIG_SMP
+#if !defined(CONFIG_SMP)
 # define cli()			local_irq_disable()
 # define sti()			local_irq_enable()
 # define save_flags(x)		local_save_flags(x)


--==_Exmh_1349971881P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+XmmRcC3lWbTT17ARAqRKAKCUpqYEAKO6izM/MFuAcvWIH4AY3QCeJvng
ZXARt6Qqf+WXsQoUYbOWHn4=
=wU2C
-----END PGP SIGNATURE-----

--==_Exmh_1349971881P--
