Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSJWJfl>; Wed, 23 Oct 2002 05:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbSJWJd4>; Wed, 23 Oct 2002 05:33:56 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:4164 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263280AbSJWJa1>; Wed, 23 Oct 2002 05:30:27 -0400
Date: Wed, 23 Oct 2002 02:44:55 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [PATCH] LKCD for 2.5.44 (7/8): dump configuration
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210230244440.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to configure crash dumps in the
kernel, including optional compression mechanisms and loading
of network crash dump capabilities.

 arch/i386/config.in |    7 +++++++
 lib/Config.in       |    2 ++
 2 files changed, 9 insertions(+)

diff -Naur linux-2.5.44.orig/arch/i386/config.in linux-2.5.44.lkcd/arch/i386/config.in
--- linux-2.5.44.orig/arch/i386/config.in	Fri Oct 18 21:01:21 2002
+++ linux-2.5.44.lkcd/arch/i386/config.in	Wed Oct 23 01:39:30 2002
@@ -455,6 +455,17 @@
    dep_bool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
 fi
 
+tristate 'Crash dump support' CONFIG_CRASH_DUMP
+if [ "$CONFIG_CRASH_DUMP" != "n" ]; then
+   dep_tristate '  Crash dump block device driver' CONFIG_CRASH_DUMP_BLOCKDEV $CONFIG_CRASH_DUMP
+   dep_tristate '  Crash dump RLE compression' CONFIG_CRASH_DUMP_COMPRESS_RLE $CONFIG_CRASH_DUMP
+   dep_tristate '  Crash dump GZIP compression' CONFIG_CRASH_DUMP_COMPRESS_GZIP $CONFIG_CRASH_DUMP
+else
+   define_tristate CONFIG_CRASH_DUMP_BLOCKDEV n
+   define_tristate CONFIG_CRASH_DUMP_COMPRESS_RLE n
+   define_tristate CONFIG_CRASH_DUMP_COMPRESS_GZIP n
+fi
+
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Check for stack overflows' CONFIG_DEBUG_STACKOVERFLOW
diff -Naur linux-2.5.44.orig/lib/Config.in linux-2.5.44.lkcd/lib/Config.in
--- linux-2.5.44.orig/lib/Config.in	Fri Oct 18 21:01:10 2002
+++ linux-2.5.44.lkcd/lib/Config.in	Sat Oct 19 12:39:15 2002
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

