Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbTCGL4W>; Fri, 7 Mar 2003 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTCGL4W>; Fri, 7 Mar 2003 06:56:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12234 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261539AbTCGL4V>;
	Fri, 7 Mar 2003 06:56:21 -0500
Date: Fri, 7 Mar 2003 14:05:04 +0100
From: Jens Axboe <axboe@suse.de>
To: tim@physik3.uni-rostock.de, akpm@digeo.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.64 and jiffies wrap
Message-ID: <20030307130504.GA903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch doesn't look right, why is INITIAL_JIFFIES being cast to
unsigned int? This breaks x86_64 at least.

--- /opt/kernel/linux-2.5.64/arch/x86_64/kernel/time.c	2003-03-07 13:54:40.000000000 +0100
+++ linux-2.5.64/arch/x86_64/kernel/time.c	2003-03-07 13:17:58.000000000 +0100
@@ -30,7 +30,7 @@
 #include <asm/apic.h>
 #endif
 
-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;
 
 extern int using_apic_timer;
 
--- /opt/kernel/linux-2.5.64/include/linux/time.h	2003-03-07 13:54:41.000000000 +0100
+++ linux-2.5.64/include/linux/time.h	2003-03-07 13:18:10.000000000 +0100
@@ -31,7 +31,7 @@
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
-#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
+#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))
 
 /*
  * Change timeval to jiffies, trying to avoid the

-- 
Jens Axboe

