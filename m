Return-Path: <linux-kernel-owner+w=401wt.eu-S1161058AbWLUAHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWLUAHM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWLUAHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:07:12 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:62537 "EHLO
	tomts5-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161058AbWLUAHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:07:09 -0500
Date: Wed, 20 Dec 2006 19:07:06 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/9] atomic.h : generic atomic_long
Message-ID: <20061221000706.GH28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221000351.GF28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:06:18 up 119 days, 21:13,  6 users,  load average: 1.29, 1.52, 1.17
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch completes the atomic_long operations in asm-generic.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -66,6 +66,90 @@ static inline void atomic_long_sub(long 
 	atomic64_sub(i, v);
 }
 
+static inline int atomic_long_sub_and_test(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_sub_and_test(i, v);
+}
+
+static inline int atomic_long_dec_and_test(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_dec_and_test(v);
+}
+
+static inline int atomic_long_inc_and_test(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_inc_and_test(v);
+}
+
+static inline int atomic_long_add_negative(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_add_negative(i, v);
+}
+
+static inline long atomic_long_add_return(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_add_return(i, v);
+}
+
+static inline long atomic_long_sub_return(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_sub_return(i, v);
+}
+
+static inline long atomic_long_inc_return(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_inc_return(v);
+}
+
+static inline long atomic_long_dec_return(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_dec_return(v);
+}
+
+static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_add_unless(v, a, u);
+}
+
+static inline long atomic_long_inc_not_zero(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_inc_not_zero(v);
+}
+
+static inline long atomic_long_cmpxchg(atomic_long_t *l, long old, long new)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_cmpxchg(v, old, new);
+}
+
+static inline long atomic_long_xchg(atomic_long_t *l, long new)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	
+	return (long)atomic64_xchg(v, new);
+}
+
 #else  /*  BITS_PER_LONG == 64  */
 
 typedef atomic_t atomic_long_t;
@@ -113,6 +197,90 @@ static inline void atomic_long_sub(long 
 	atomic_sub(i, v);
 }
 
+static inline int atomic_long_sub_and_test(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return atomic_sub_and_test(i, v);
+}
+
+static inline int atomic_long_dec_and_test(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return atomic_dec_and_test(v);
+}
+
+static inline int atomic_long_inc_and_test(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return atomic_inc_and_test(v);
+}
+
+static inline int atomic_long_add_negative(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return atomic_add_negative(i, v);
+}
+
+static inline long atomic_long_add_return(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_add_return(i, v);
+}
+
+static inline long atomic_long_sub_return(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_sub_return(i, v);
+}
+
+static inline long atomic_long_inc_return(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_inc_return(v);
+}
+
+static inline long atomic_long_dec_return(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_dec_return(v);
+}
+
+static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_add_unless(v, a, u);
+}
+
+static inline long atomic_long_inc_not_zero(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_inc_not_zero(v);
+}
+
+static inline long atomic_long_cmpxchg(atomic_long_t *l, long old, long new)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_cmpxchg(v, old, new);
+}
+
+static inline long atomic_long_xchg(atomic_long_t *l, long new)
+{
+	atomic_t *v = (atomic_t *)l;
+	
+	return (long)atomic_xchg(v, new);
+}
+
 #endif  /*  BITS_PER_LONG == 64  */
 
 #endif  /*  _ASM_GENERIC_ATOMIC_H  */

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
