Return-Path: <linux-kernel-owner+w=401wt.eu-S1161020AbWLUAXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWLUAXx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWLUAXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:23:53 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:37468 "EHLO
	tomts25-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161020AbWLUAXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:23:52 -0500
Date: Wed, 20 Dec 2006 19:23:49 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/10] local_t : ia64
Message-ID: <20061221002349.GT28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221001545.GP28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:22:43 up 119 days, 21:30,  6 users,  load average: 1.99, 2.04, 1.81
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 architecture local_t cleanup : use asm-generic/local.h.

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

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
