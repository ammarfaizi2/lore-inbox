Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTEZLvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 07:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTEZLvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 07:51:35 -0400
Received: from pointblue.com.pl ([62.89.73.6]:44807 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264352AbTEZLve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 07:51:34 -0400
Subject: [RFC] HZ entry in /proc/sys/kernel
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053950030.2028.4.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 12:53:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen few scripts allready that are assuming HZ==100.
Afaik this value is different in 2.5/2.4 for the same arch.
So is it worth to add on both simple /proc/sys/kernel/HZ ?
   
Simple patch for 2.4.21-rc3 , if it is allright i will do same thing for
2.5

----------------------------------------------------------

diff -ur 2/include/linux/sysctl.h 1/include/linux/sysctl.h
--- 2/include/linux/sysctl.h    2003-05-24 12:10:35.000000000 +0100
+++ 1/include/linux/sysctl.h    2003-05-26 12:44:16.000000000 +0100
@@ -125,6 +125,7 @@
        KERN_TAINTED=53,        /* int: various kernel tainted flags */
        KERN_CADPID=54,         /* int: PID of the process to notify on
CAD */
        KERN_CORE_PATTERN=56,   /* string: pattern for core-files */
+       KERN_HZ=57,             /* int: HZ value */
 };


diff -ur 2/kernel/sysctl.c 1/kernel/sysctl.c
--- 2/kernel/sysctl.c   2003-05-26 12:33:37.000000000 +0100
+++ 1/kernel/sysctl.c   2003-05-26 12:45:31.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/highuid.h>

 #include <asm/uaccess.h>
+#include <asm/param.h>

 #ifdef CONFIG_ROOT_NFS
 #include <linux/nfs_fs.h>
@@ -123,6 +124,8 @@

 #ifdef CONFIG_PROC_FS

+static unsigned int hz=HZ;
+
 static ssize_t proc_readsys(struct file *, char *, size_t, loff_t *);
 static ssize_t proc_writesys(struct file *, const char *, size_t,
loff_t *);
 static int proc_sys_permission(struct inode *, int);
@@ -244,6 +247,8 @@
         0600, NULL, &proc_dointvec},
        {KERN_MAX_THREADS, "threads-max", &max_threads, sizeof(int),
         0644, NULL, &proc_dointvec},
+       {KERN_HZ, "HZ", &hz, sizeof(unsigned int),
+        0444, NULL, &proc_dointvec},
        {KERN_RANDOM, "random", NULL, 0, 0555, random_table},
        {KERN_OVERFLOWUID, "overflowuid", &overflowuid, sizeof(int),
0644, NULL,
         &proc_dointvec_minmax, &sysctl_intvec, NULL,

  
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

