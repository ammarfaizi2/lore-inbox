Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262188AbSJJTx7>; Thu, 10 Oct 2002 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262191AbSJJTx7>; Thu, 10 Oct 2002 15:53:59 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:12878 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262188AbSJJTu3>; Thu, 10 Oct 2002 15:50:29 -0400
Date: Thu, 10 Oct 2002 13:04:36 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4ae29589@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (7/8): dump configuration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to configure crash dumps in the
kernel, including optional compression mechanisms and loading
of network crash dump capabilities.


 arch/i386/config.in |    7 +++++++
 lib/Config.in       |    2 ++
 2 files changed, 9 insertions(+)


diff -Naur linux-2.5.41.orig/arch/i386/config.in linux-2.5.41.lkcd/arch/i386/config.in
--- linux-2.5.41.orig/arch/i386/config.in	Mon Oct  7 11:24:02 2002
+++ linux-2.5.41.lkcd/arch/i386/config.in	Tue Oct  8 01:15:13 2002
@@ -445,6 +445,13 @@
    dep_bool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
 fi
 
+tristate 'Linux Kernel Crash Dump (LKCD) Support' CONFIG_CRASH_DUMP
+if [ "$CONFIG_CRASH_DUMP" != "n" ]; then
+   dep_tristate '  LKCD Block Device Driver' CONFIG_CRASH_DUMP_BLOCKDEV $CONFIG_CRASH_DUMP
+   dep_tristate '  LKCD RLE compression' CONFIG_CRASH_DUMP_COMPRESS_RLE $CONFIG_CRASH_DUMP
+   dep_tristate '  LKCD GZIP compression' CONFIG_CRASH_DUMP_COMPRESS_GZIP $CONFIG_CRASH_DUMP
+fi
+
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
diff -Naur linux-2.5.41.orig/lib/Config.in linux-2.5.41.lkcd/lib/Config.in
--- linux-2.5.41.orig/lib/Config.in	Mon Oct  7 11:23:24 2002
+++ linux-2.5.41.lkcd/lib/Config.in	Tue Oct  8 01:15:13 2002
@@ -26,10 +26,12 @@
 fi
 
 if [ "$CONFIG_PPP_DEFLATE" = "y" -o \
+     "$CONFIG_CRASH_DUMP_COMPRESS_GZIP" = "y" -o \
      "$CONFIG_JFFS2_FS" = "y" ]; then
    define_tristate CONFIG_ZLIB_DEFLATE y
 else
   if [ "$CONFIG_PPP_DEFLATE" = "m" -o \
+       "$CONFIG_CRASH_DUMP_COMPRESS_GZIP" = "m" -o \
        "$CONFIG_JFFS2_FS" = "m" ]; then
      define_tristate CONFIG_ZLIB_DEFLATE m
   else
