Return-Path: <linux-kernel-owner+w=401wt.eu-S932515AbXALCXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXALCXS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbXALCXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:23:18 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:49751 "EHLO
	tomts25-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932515AbXALCXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:23:17 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 06/10] local_t : parisc cleanup
Date: Thu, 11 Jan 2007 20:42:57 -0500
Message-Id: <11685661834173-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685661813181-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local_t : parisc cleanup

parisc architecture local_t cleanup : use asm-generic/local.h.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-parisc/local.h
+++ b/include/asm-parisc/local.h
@@ -1,40 +1 @@
-#ifndef _ARCH_PARISC_LOCAL_H
-#define _ARCH_PARISC_LOCAL_H
-
-#include <linux/percpu.h>
-#include <asm/atomic.h>
-
-typedef atomic_long_t local_t;
-
-#define LOCAL_INIT(i)	ATOMIC_LONG_INIT(i)
-#define local_read(v)	atomic_long_read(v)
-#define local_set(v,i)	atomic_long_set(v,i)
-
-#define local_inc(v)	atomic_long_inc(v)
-#define local_dec(v)	atomic_long_dec(v)
-#define local_add(i, v)	atomic_long_add(i, v)
-#define local_sub(i, v)	atomic_long_sub(i, v)
-
-#define __local_inc(v)		((v)->counter++)
-#define __local_dec(v)		((v)->counter--)
-#define __local_add(i,v)	((v)->counter+=(i))
-#define __local_sub(i,v)	((v)->counter-=(i))
-
-/* Use these for per-cpu local_t variables: on some archs they are
- * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
- */
-#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
-
-#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
-
-#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
-
-#endif /* _ARCH_PARISC_LOCAL_H */
+#include <asm-generic/local.h>
