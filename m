Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVBDRjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVBDRjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbVBDRfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:35:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56007 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263450AbVBDRb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:31:56 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Make the bit finding functions take const pointers
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 17:31:50 +0000
Message-ID: <28761.1107538310@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the bit finding functions in asm/bitops.h take const
pointers since they don't modify what they access.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-findbit-const-2611rc3.diff 
 include/asm-frv/bitops.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/bitops.h linux-2.6.11-rc3-frv/include/asm-frv/bitops.h
--- /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/bitops.h	2005-02-04 11:50:21.000000000 +0000
+++ linux-2.6.11-rc3-frv/include/asm-frv/bitops.h	2005-02-04 14:24:36.000000000 +0000
@@ -178,9 +178,9 @@ extern int find_next_bit(const unsigned 
 #define find_first_zero_bit(addr, size) \
         find_next_zero_bit((addr), (size), 0)
 
-static inline int find_next_zero_bit (void * addr, int size, int offset)
+static inline int find_next_zero_bit(const void *addr, int size, int offset)
 {
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
+	const unsigned long *p = ((const unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
 	unsigned long tmp;
 
@@ -277,11 +277,11 @@ static inline int ext2_test_bit(int nr, 
 #define ext2_find_first_zero_bit(addr, size) \
         ext2_find_next_zero_bit((addr), (size), 0)
 
-static inline unsigned long ext2_find_next_zero_bit(void *addr,
+static inline unsigned long ext2_find_next_zero_bit(const void *addr,
 						    unsigned long size,
 						    unsigned long offset)
 {
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
+	const unsigned long *p = ((const unsigned long *) addr) + (offset >> 5);
 	unsigned long result = offset & ~31UL;
 	unsigned long tmp;
 
