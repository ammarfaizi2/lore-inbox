Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSLBIOH>; Mon, 2 Dec 2002 03:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSLBIOG>; Mon, 2 Dec 2002 03:14:06 -0500
Received: from dp.samba.org ([66.70.73.150]:55742 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265677AbSLBIOF>;
	Mon, 2 Dec 2002 03:14:05 -0500
Date: Mon, 2 Dec 2002 19:16:45 +1100
From: Anton Blanchard <anton@samba.org>
To: levon@movementarian.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fixes for oprofile on ppc64
Message-ID: <20021202081645.GA12110@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are a few fixes I needed when porting oprofile to ppc64:

- __PAGE_OFFSET isnt defined for all architectures, use PAGE_OFFSET
  instead
- include linux/cache.h everywhere we use ____cacheline_aligned etc. 
  Otherwise we end up with a structure called ____cacheline_aligned
  and no alignment :(

Anton


===== drivers/oprofile/buffer_sync.c 1.4 vs edited =====
--- 1.4/drivers/oprofile/buffer_sync.c	Tue Nov  5 08:01:22 2002
+++ edited/drivers/oprofile/buffer_sync.c	Fri Nov 29 14:31:07 2002
@@ -245,7 +245,7 @@
  
 static inline int is_kernel(unsigned long val)
 {
-	return val > __PAGE_OFFSET;
+	return val > PAGE_OFFSET;
 }
 
 
===== drivers/oprofile/cpu_buffer.c 1.2 vs edited =====
--- 1.2/drivers/oprofile/cpu_buffer.c	Wed Nov 27 06:38:46 2002
+++ edited/drivers/oprofile/cpu_buffer.c	Fri Nov 29 14:30:18 2002
@@ -21,6 +21,7 @@
 #include <linux/vmalloc.h>
 #include <linux/smp.h>
 #include <linux/errno.h>
+#include <linux/cache.h>
  
 #include "cpu_buffer.h"
 #include "oprof.h"
===== drivers/oprofile/cpu_buffer.h 1.1 vs edited =====
--- 1.1/drivers/oprofile/cpu_buffer.h	Wed Oct 16 07:45:51 2002
+++ edited/drivers/oprofile/cpu_buffer.h	Mon Dec  2 12:25:16 2002
@@ -12,6 +12,7 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/cache.h>
  
 struct task_struct;
  

