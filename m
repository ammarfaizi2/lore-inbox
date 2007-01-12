Return-Path: <linux-kernel-owner+w=401wt.eu-S1751566AbXALBku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbXALBku (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbXALBkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:40:49 -0500
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:60853 "EHLO
	tomts22-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751564AbXALBkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:40:49 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 02/09] atomic.h : Complete atomic_long operations in asm-generic
Date: Thu, 11 Jan 2007 20:35:34 -0500
Message-Id: <11685657424039-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685657414033-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685657414033-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atomic.h : Complete atomic_long operations in asm-generic

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -66,6 +66,90 @@ static inline void atomic_long_sub(long i, atomic_long_t *l)
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
@@ -113,6 +197,90 @@ static inline void atomic_long_sub(long i, atomic_long_t *l)
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
