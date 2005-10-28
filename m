Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVJ1OI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVJ1OI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbVJ1OI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:08:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:65211 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751648AbVJ1OI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:08:58 -0400
Date: Fri, 28 Oct 2005 16:09:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cborntra@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 8/14] s390: test_bit return value.
Message-ID: <20051028140904.GH7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[patch 8/14] s390: test_bit return value.

The test_bit function returns a non-boolean value, it returns 0,1,2,4,...
instead of only 0 or 1. This causes wrongs results in the mincore
system call. Check against 0 to get a proper boolean value.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bitops.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/bitops.h linux-2.6-patched/include/asm-s390/bitops.h
--- linux-2.6/include/asm-s390/bitops.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/bitops.h	2005-10-28 14:04:50.000000000 +0200
@@ -518,8 +518,8 @@ static inline int __test_bit(unsigned lo
 
 static inline int 
 __constant_test_bit(unsigned long nr, const volatile unsigned long *addr) {
-    return (((volatile char *) addr)
-	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7)));
+    return ((((volatile char *) addr)
+	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7)))) != 0;
 }
 
 #define test_bit(nr,addr) \
