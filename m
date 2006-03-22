Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWCVPQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWCVPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWCVPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:16:26 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40833 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751279AbWCVPQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:16:24 -0500
Date: Wed, 22 Mar 2006 16:16:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/24] s390: BUG() warnings.
Message-ID: <20060322151651.GF5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 6/24] s390: BUG() warnings.

Use __builtin_trap instead of an inline assembly in the BUG() macro.
That way the compiler knows that BUG() won't return.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bug.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/bug.h linux-2.6-patched/include/asm-s390/bug.h
--- linux-2.6/include/asm-s390/bug.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/bug.h	2006-03-22 14:36:15.000000000 +0100
@@ -4,9 +4,10 @@
 #include <linux/kernel.h>
 
 #ifdef CONFIG_BUG
+
 #define BUG() do { \
-        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-        __asm__ __volatile__(".long 0"); \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	__builtin_trap(); \
 } while (0)
 
 #define HAVE_ARCH_BUG
