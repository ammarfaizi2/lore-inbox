Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271295AbTGQQXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTGQQXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:23:47 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:26518 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S271295AbTGQQXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:23:40 -0400
Date: Thu, 17 Jul 2003 18:37:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/6): s390 arch.
Message-ID: <20030717163728.GB2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - New default configuration.
 - Fix get_tv32/put_tv32.
 - Replace generic dma-mapping file with empty one.
 - Remove wrong comment from dma.h.

diffstat:
 arch/s390/defconfig             |    6 +++---
 arch/s390/kernel/compat_linux.c |    4 ++--
 include/asm-s390/dma-mapping.h  |   12 +++++++++++-
 include/asm-s390/dma.h          |    2 --
 4 files changed, 16 insertions(+), 8 deletions(-)

diff -urN linux-2.6.0-test1/arch/s390/defconfig linux-2.6.0-s390/arch/s390/defconfig
--- linux-2.6.0-test1/arch/s390/defconfig	Mon Jul 14 05:37:26 2003
+++ linux-2.6.0-s390/arch/s390/defconfig	Thu Jul 17 17:27:29 2003
@@ -20,6 +20,7 @@
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_EMBEDDED is not set
+# CONFIG_KALLSYMS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 
@@ -169,7 +170,7 @@
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
-CONFIG_IPV6=m
+CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
@@ -180,7 +181,7 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=m
+CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -383,7 +384,6 @@
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SLAB is not set
-# CONFIG_KALLSYMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 
 #
diff -urN linux-2.6.0-test1/arch/s390/kernel/compat_linux.c linux-2.6.0-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6.0-test1/arch/s390/kernel/compat_linux.c	Mon Jul 14 05:37:14 2003
+++ linux-2.6.0-s390/arch/s390/kernel/compat_linux.c	Thu Jul 17 17:27:29 2003
@@ -250,14 +250,14 @@
 static inline long get_tv32(struct timeval *o, struct compat_timeval *i)
 {
 	return (!access_ok(VERIFY_READ, tv32, sizeof(*tv32)) ||
-		(__get_user(o->tv_sec, &i->tv_sec) |
+		(__get_user(o->tv_sec, &i->tv_sec) ||
 		 __get_user(o->tv_usec, &i->tv_usec)));
 }
 
 static inline long put_tv32(struct compat_timeval *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
-		(__put_user(i->tv_sec, &o->tv_sec) |
+		(__put_user(i->tv_sec, &o->tv_sec) ||
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
diff -urN linux-2.6.0-test1/include/asm-s390/dma-mapping.h linux-2.6.0-s390/include/asm-s390/dma-mapping.h
--- linux-2.6.0-test1/include/asm-s390/dma-mapping.h	Mon Jul 14 05:39:36 2003
+++ linux-2.6.0-s390/include/asm-s390/dma-mapping.h	Thu Jul 17 17:27:29 2003
@@ -1 +1,11 @@
-#include <asm-generic/dma-mapping.h>
+/*
+ *  include/asm-s390/dma-mapping.h
+ *
+ *  S390 version
+ *
+ *  This file exists so that #include <dma-mapping.h> doesn't break anything.
+ */
+
+#ifndef _ASM_DMA_MAPPING_H
+#define _ASM_DMA_MAPPING_H
+#endif /* _ASM_DMA_MAPPING_H */
diff -urN linux-2.6.0-test1/include/asm-s390/dma.h linux-2.6.0-s390/include/asm-s390/dma.h
--- linux-2.6.0-test1/include/asm-s390/dma.h	Mon Jul 14 05:37:33 2003
+++ linux-2.6.0-s390/include/asm-s390/dma.h	Thu Jul 17 17:27:29 2003
@@ -2,8 +2,6 @@
  *  include/asm-s390/dma.h
  *
  *  S390 version
- *
- *  This file exists so that an #include <dma.h> doesn't break anything.
  */
 
 #ifndef _ASM_DMA_H
