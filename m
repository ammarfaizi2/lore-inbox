Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267123AbUBGTU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 14:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267129AbUBGTU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 14:20:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57817 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267123AbUBGTUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 14:20:20 -0500
Date: Sat, 7 Feb 2004 20:20:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS: remove #ifdef's for kernel 2.0
Message-ID: <20040207192013.GP26093@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two #ifdef's for kernel 2.0 from OSS.

Please apply
Adrian

--- linux-2.6.2-mm1/sound/oss/msnd.c.old	2004-02-07 20:07:00.000000000 +0100
+++ linux-2.6.2-mm1/sound/oss/msnd.c	2004-02-07 20:07:16.000000000 +0100
@@ -25,9 +25,6 @@
  ********************************************************************/
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < 0x020101
-#  define LINUX20
-#endif
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -35,18 +32,10 @@
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#ifdef LINUX20
-#  include <linux/major.h>
-#  include <linux/fs.h>
-#  include <linux/sound.h>
-#  include <asm/segment.h>
-#  include "sound_config.h"
-#else
-#  include <linux/init.h>
-#  include <asm/io.h>
-#  include <asm/uaccess.h>
-#  include <linux/spinlock.h>
-#endif
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <linux/spinlock.h>
 #include <asm/irq.h>
 #include "msnd.h"
 
--- linux-2.6.2-mm1/sound/oss/os.h.old	2004-02-07 20:09:31.000000000 +0100
+++ linux-2.6.2-mm1/sound/oss/os.h	2004-02-07 20:09:38.000000000 +0100
@@ -7,10 +7,6 @@
 #include <linux/module.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE > 131328
-#define LINUX21X
-#endif
-
 #ifdef __KERNEL__
 #include <linux/utsname.h>
 #include <linux/string.h>
