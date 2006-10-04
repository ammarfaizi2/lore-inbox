Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWJDR7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWJDR7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWJDR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:59:18 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:61128 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030742AbWJDR7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:59:14 -0400
Date: Wed, 4 Oct 2006 19:59:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] incorrect placement of include.
Message-ID: <20061004175916.GF26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] incorrect placement of include.

The include of linux/smp.h needs to be done before the #if that
checks for the compiler version. Seems like fallout from the
inline assembly cleanup patch vs. the directed yield patch.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2006-10-04 19:53:37.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2006-10-04 19:53:49.000000000 +0200
@@ -11,10 +11,10 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 #include <linux/smp.h>
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
+
 static inline int
 _raw_compare_and_swap(volatile unsigned int *lock,
 		      unsigned int old, unsigned int new)
