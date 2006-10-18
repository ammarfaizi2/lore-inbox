Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWJRJWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWJRJWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWJRJWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:22:18 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:24009 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750983AbWJRJWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:22:17 -0400
Subject: 2.6.19-rc2 : Is something missing in Documentation/dontdiff ?
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 14:55:37 +0530
Message-Id: <1161163537.20400.128.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did following:

1. To start with linux-2.6.19-rc2-orig and linux-2.6.19-rc2 are
identical
2. cd linux-2.6.19-rc2; make allmodconfig; make
3. diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff
linux-2.6.19-rc2-orig linux-2.6.19-rc2 > /tmp/patch

The above generates 2MB patch file. What is wrong ?

It seems a new folder is created: linux-2.6.19-rc2/usr/include

diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-rc2-orig/usr/include/asm-generic/atomic.h linux-2.6.19-rc2/usr/include/asm-generic/atomic.h
--- linux-2.6.19-rc2-orig/usr/include/asm-generic/atomic.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.19-rc2/usr/include/asm-generic/atomic.h	2006-10-18 14:18:47.000000000 +0530
@@ -0,0 +1,117 @@
+#ifndef _ASM_GENERIC_ATOMIC_H
+#define _ASM_GENERIC_ATOMIC_H
+/*
+ * Copyright (C) 2005 Silicon Graphics, Inc.
+ *	Christoph Lameter <clameter@sgi.com>
+ *
+ * Allows to provide arch independent atomic definitions without the need to
+ * edit all arch specific atomic.h files.
+ */
+
+#include <asm/types.h>
+
+/*
+ * Suppport for atomic_long_t
+ *
+ * Casts for parameters are avoided for existing atomic functions in order to
+ * avoid issues with cast-as-lval under gcc 4.x and other limitations that the
+ * macros of a platform may have.
+ */
+
+#if BITS_PER_LONG == 64
+
+typedef atomic64_t atomic_long_t;
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
+
+static __inline__ long atomic_long_read(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	return (long)atomic64_read(v);
+}
+
+static __inline__ void atomic_long_set(atomic_long_t *l, long i)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_set(v, i);
+}
+
+static __inline__ void atomic_long_inc(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_inc(v);
+}
+
+static __inline__ void atomic_long_dec(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_dec(v);
+}
+
+static __inline__ void atomic_long_add(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_add(i, v);
+}
+
+static __inline__ void atomic_long_sub(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_sub(i, v);
+}
+
+#else
+
+typedef atomic_t atomic_long_t;
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+static __inline__ long atomic_long_read(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	return (long)atomic_read(v);
+}
+
+static __inline__ void atomic_long_set(atomic_long_t *l, long i)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_set(v, i);
+}
+
+static __inline__ void atomic_long_inc(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_inc(v);
+}
+
+static __inline__ void atomic_long_dec(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_dec(v);
+}
+
+static __inline__ void atomic_long_add(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_add(i, v);
+}
+
+static __inline__ void atomic_long_sub(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_sub(i, v);
+}
+
+#endif
+#endif

..........
..........

