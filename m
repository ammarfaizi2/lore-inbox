Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVI3DU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVI3DU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 23:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVI3DU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 23:20:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39579 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751400AbVI3DU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 23:20:58 -0400
Date: Fri, 30 Sep 2005 04:20:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] missing qualifiers in readb() et.al. on ppc
Message-ID: <20050930032057.GE7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/include/asm-ppc/io.h current/include/asm-ppc/io.h
--- RC14-rc2-git6-base/include/asm-ppc/io.h	2005-06-17 15:48:29.000000000 -0400
+++ current/include/asm-ppc/io.h	2005-09-29 22:47:06.000000000 -0400
@@ -56,7 +56,7 @@
  * is actually performed (i.e. the data has come back) before we start
  * executing any following instructions.
  */
-extern inline int in_8(volatile unsigned char __iomem *addr)
+extern inline int in_8(const volatile unsigned char __iomem *addr)
 {
 	int ret;
 
@@ -72,7 +72,7 @@
 	__asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
 
-extern inline int in_le16(volatile unsigned short __iomem *addr)
+extern inline int in_le16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
@@ -83,7 +83,7 @@
 	return ret;
 }
 
-extern inline int in_be16(volatile unsigned short __iomem *addr)
+extern inline int in_be16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
@@ -104,7 +104,7 @@
 	__asm__ __volatile__("sth%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
 
-extern inline unsigned in_le32(volatile unsigned __iomem *addr)
+extern inline unsigned in_le32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
@@ -115,7 +115,7 @@
 	return ret;
 }
 
-extern inline unsigned in_be32(volatile unsigned __iomem *addr)
+extern inline unsigned in_be32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
@@ -139,7 +139,7 @@
 #define readb(addr) in_8((volatile u8 *)(addr))
 #define writeb(b,addr) out_8((volatile u8 *)(addr), (b))
 #else
-static inline __u8 readb(volatile void __iomem *addr)
+static inline __u8 readb(const volatile void __iomem *addr)
 {
 	return in_8(addr);
 }
@@ -150,11 +150,11 @@
 #endif
 
 #if defined(CONFIG_APUS)
-static inline __u16 readw(volatile void __iomem *addr)
+static inline __u16 readw(const volatile void __iomem *addr)
 {
 	return *(__force volatile __u16 *)(addr);
 }
-static inline __u32 readl(volatile void __iomem *addr)
+static inline __u32 readl(const volatile void __iomem *addr)
 {
 	return *(__force volatile __u32 *)(addr);
 }
@@ -173,11 +173,11 @@
 #define writew(b,addr) out_le16((volatile u16 *)(addr),(b))
 #define writel(b,addr) out_le32((volatile u32 *)(addr),(b))
 #else
-static inline __u16 readw(volatile void __iomem *addr)
+static inline __u16 readw(const volatile void __iomem *addr)
 {
 	return in_le16(addr);
 }
-static inline __u32 readl(volatile void __iomem *addr)
+static inline __u32 readl(const volatile void __iomem *addr)
 {
 	return in_le32(addr);
 }
