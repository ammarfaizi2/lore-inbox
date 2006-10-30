Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161489AbWJ3VXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161489AbWJ3VXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161495AbWJ3VXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:23:39 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:38590 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1161489AbWJ3VXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:23:38 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 30 Oct 2006 16:20:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] atomic.h : atomic_t "counter" members should be volatile
Message-ID: <Pine.LNX.4.64.0610301616160.13077@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure all typedef struct's for atomic_t have a "volatile" counter
member.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
  According to what I read, it's highly recommended that that counter
member be declared with storage class "volatile".  This patch just
makes it consistently volatile across all architectures.

 asm-frv/atomic.h       |    2 +-
 asm-h8300/atomic.h     |    2 +-
 asm-m68k/atomic.h      |    2 +-
 asm-m68knommu/atomic.h |    2 +-
 asm-v850/atomic.h      |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-frv/atomic.h b/include/asm-frv/atomic.h
index 066386a..df564bb 100644
--- a/include/asm-frv/atomic.h
+++ b/include/asm-frv/atomic.h
@@ -35,7 +35,7 @@ #define smp_mb__before_atomic_inc()	barr
 #define smp_mb__after_atomic_inc()	barrier()

 typedef struct {
-	int counter;
+	volatile int counter;
 } atomic_t;

 #define ATOMIC_INIT(i)		{ (i) }
diff --git a/include/asm-h8300/atomic.h b/include/asm-h8300/atomic.h
index 21f5442..3436bda 100644
--- a/include/asm-h8300/atomic.h
+++ b/include/asm-h8300/atomic.h
@@ -6,7 +6,7 @@ #define __ARCH_H8300_ATOMIC__
  * resource counting etc..
  */

-typedef struct { int counter; } atomic_t;
+typedef struct { volatile int counter; } atomic_t;
 #define ATOMIC_INIT(i)	{ (i) }

 #define atomic_read(v)		((v)->counter)
diff --git a/include/asm-m68k/atomic.h b/include/asm-m68k/atomic.h
index d5eed64..4a8c625 100644
--- a/include/asm-m68k/atomic.h
+++ b/include/asm-m68k/atomic.h
@@ -13,7 +13,7 @@ #include <asm/system.h>	/* local_irq_XXX
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */

-typedef struct { int counter; } atomic_t;
+typedef struct { volatile int counter; } atomic_t;
 #define ATOMIC_INIT(i)	{ (i) }

 #define atomic_read(v)		((v)->counter)
diff --git a/include/asm-m68knommu/atomic.h b/include/asm-m68knommu/atomic.h
index 6c4e4b6..c77e601 100644
--- a/include/asm-m68knommu/atomic.h
+++ b/include/asm-m68knommu/atomic.h
@@ -12,7 +12,7 @@ #include <asm/system.h>	/* local_irq_XXX
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */

-typedef struct { int counter; } atomic_t;
+typedef struct { volatile int counter; } atomic_t;
 #define ATOMIC_INIT(i)	{ (i) }

 #define atomic_read(v)		((v)->counter)
diff --git a/include/asm-v850/atomic.h b/include/asm-v850/atomic.h
index e4e57de..527480e 100644
--- a/include/asm-v850/atomic.h
+++ b/include/asm-v850/atomic.h
@@ -21,7 +21,7 @@ #ifdef CONFIG_SMP
 #error SMP not supported
 #endif

-typedef struct { int counter; } atomic_t;
+typedef struct { volatile int counter; } atomic_t;

 #define ATOMIC_INIT(i)	{ (i) }

