Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSHCE3u>; Sat, 3 Aug 2002 00:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSHCE3u>; Sat, 3 Aug 2002 00:29:50 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:9491 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317462AbSHCE3t>;
	Sat, 3 Aug 2002 00:29:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19 vmalloc.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 14:33:09 +1000
Message-ID: <10755.1028349189@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/vmalloc.h -> include/asm/pgtable.h which defines
VMALLOC_END.  Several architectures define VMALLOC_END via PKMAP_BASE
for CONFIG_HIGHMEM=y but PKMAP_BASE is undefined.  Adding highmem.h to
vmalloc.h is the simplest fix.

Index: 19.1/include/linux/vmalloc.h
--- 19.1/include/linux/vmalloc.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/b/b/38_vmalloc.h 1.1 644)
+++ 19.1(w)/include/linux/vmalloc.h Sat, 03 Aug 2002 14:27:36 +1000 kaos (linux-2.4/b/b/38_vmalloc.h 1.1.2.1 644)
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 
+#include <linux/highmem.h>	/* several arch define VMALLOC_END via PKMAP_BASE */
 #include <asm/pgtable.h>
 
 /* bits in vm_struct->flags */

