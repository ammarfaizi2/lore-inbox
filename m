Return-Path: <linux-kernel-owner+w=401wt.eu-S932819AbXALBxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbXALBxS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXALBxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:53:17 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:48636 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932608AbXALBxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:53:16 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 04/10] local_t : ia64 extension
Date: Thu, 11 Jan 2007 20:42:55 -0500
Message-Id: <11685661821081-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local_t : ia64 extension

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-ia64/local.h
+++ b/include/asm-ia64/local.h
@@ -1,50 +1 @@
-#ifndef _ASM_IA64_LOCAL_H
-#define _ASM_IA64_LOCAL_H
-
-/*
- * Copyright (C) 2003 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- */
-
-#include <linux/percpu.h>
-
-typedef struct {
-	atomic64_t val;
-} local_t;
-
-#define LOCAL_INIT(i)	((local_t) { { (i) } })
-#define local_read(l)	atomic64_read(&(l)->val)
-#define local_set(l, i)	atomic64_set(&(l)->val, i)
-#define local_inc(l)	atomic64_inc(&(l)->val)
-#define local_dec(l)	atomic64_dec(&(l)->val)
-#define local_add(i, l)	atomic64_add((i), &(l)->val)
-#define local_sub(i, l)	atomic64_sub((i), &(l)->val)
-
-/* Non-atomic variants, i.e., preemption disabled and won't be touched in interrupt, etc.  */
-
-#define __local_inc(l)		(++(l)->val.counter)
-#define __local_dec(l)		(--(l)->val.counter)
-#define __local_add(i,l)	((l)->val.counter += (i))
-#define __local_sub(i,l)	((l)->val.counter -= (i))
-
-/*
- * Use these for per-cpu local_t variables.  Note they take a variable (eg. mystruct.foo),
- * not an address.
- */
-#define cpu_local_read(v)	local_read(&__ia64_per_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__ia64_per_cpu_var(v), (i))
-#define cpu_local_inc(v)	local_inc(&__ia64_per_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__ia64_per_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__ia64_per_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__ia64_per_cpu_var(v))
-
-/*
- * Non-atomic increments, i.e., preemption disabled and won't be touched in interrupt,
- * etc.
- */
-#define __cpu_local_inc(v)	__local_inc(&__ia64_per_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__ia64_per_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__ia64_per_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__ia64_per_cpu_var(v))
-
-#endif /* _ASM_IA64_LOCAL_H */
+#include <asm-generic/local.h>
