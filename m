Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286553AbSABBVx>; Tue, 1 Jan 2002 20:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286491AbSABBVb>; Tue, 1 Jan 2002 20:21:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12562 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286502AbSABBUs>;
	Tue, 1 Jan 2002 20:20:48 -0500
Message-ID: <3C32606A.7240E019@mandrakesoft.com>
Date: Tue, 01 Jan 2002 20:20:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com
Subject: PATCH 2.5.2.6: fix cpuid, msr builds
Content-Type: multipart/mixed;
 boundary="------------15C9640AB2CD5890A7403E5E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------15C9640AB2CD5890A7403E5E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Obvious changes, the drivers manage the minor number similar to other
chr drivers
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------15C9640AB2CD5890A7403E5E
Content-Type: text/plain; charset=us-ascii;
 name="i386-2.5.2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-2.5.2.6.patch"

Index: arch/i386/kernel/cpuid.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/arch/i386/kernel/cpuid.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpuid.c
--- arch/i386/kernel/cpuid.c	2001/10/11 16:04:57	1.1.1.1
+++ arch/i386/kernel/cpuid.c	2002/01/02 01:15:26
@@ -101,7 +101,7 @@
   u32 data[4];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = minor(file->f_dentry->d_inode->i_rdev);
   
   if ( count % 16 )
     return -EINVAL; /* Invalid chunk size */
@@ -119,7 +119,7 @@
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
   if ( !(cpu_online_map & (1UL << cpu)) )
Index: arch/i386/kernel/msr.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/arch/i386/kernel/msr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 msr.c
--- arch/i386/kernel/msr.c	2001/10/11 16:04:57	1.1.1.1
+++ arch/i386/kernel/msr.c	2002/01/02 01:15:26
@@ -181,7 +181,7 @@
   u32 data[2];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = minor(file->f_dentry->d_inode->i_rdev);
   int err;
 
   if ( count % 8 )
@@ -206,7 +206,7 @@
   u32 data[2];
   size_t rv;
   u32 reg = *ppos;
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = minor(file->f_dentry->d_inode->i_rdev);
   int err;
 
   if ( count % 8 )
@@ -226,7 +226,7 @@
 
 static int msr_open(struct inode *inode, struct file *file)
 {
-  int cpu = MINOR(file->f_dentry->d_inode->i_rdev);
+  int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
   if ( !(cpu_online_map & (1UL << cpu)) )

--------------15C9640AB2CD5890A7403E5E--

