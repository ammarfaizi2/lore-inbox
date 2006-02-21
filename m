Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161436AbWBUIsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbWBUIsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWBUIsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:48:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:715 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161436AbWBUIsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:48:11 -0500
Date: Tue, 21 Feb 2006 09:46:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Paul Jackson <pj@sgi.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/6] lightweight robust futexes: arch defaults
Message-ID: <20060221084637.GB5506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add placeholder futex_atomic_cmpxchg_inuser() implementations to every
architecture that supports futexes. It returns -ENOSYS.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Acked-by: Ulrich Drepper <drepper@redhat.com>

----

 include/asm-frv/futex.h     |    6 ++++++
 include/asm-generic/futex.h |    6 ++++++
 include/asm-i386/futex.h    |    6 ++++++
 include/asm-mips/futex.h    |    6 ++++++
 include/asm-powerpc/futex.h |    6 ++++++
 include/asm-x86_64/futex.h  |    6 ++++++
 6 files changed, 36 insertions(+)

Index: linux-robust-list.q/include/asm-frv/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-frv/futex.h
+++ linux-robust-list.q/include/asm-frv/futex.h
@@ -9,5 +9,11 @@
 
 extern int futex_atomic_op_inuser(int encoded_op, int __user *uaddr);
 
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
+	return -ENOSYS;
+}
+
 #endif
 #endif
Index: linux-robust-list.q/include/asm-generic/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-generic/futex.h
+++ linux-robust-list.q/include/asm-generic/futex.h
@@ -49,5 +49,11 @@ futex_atomic_op_inuser (int encoded_op, 
 	return ret;
 }
 
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
+	return -ENOSYS;
+}
+
 #endif
 #endif
Index: linux-robust-list.q/include/asm-i386/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-i386/futex.h
+++ linux-robust-list.q/include/asm-i386/futex.h
@@ -104,5 +104,11 @@ futex_atomic_op_inuser (int encoded_op, 
 	return ret;
 }
 
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
+	return -ENOSYS;
+}
+
 #endif
 #endif
Index: linux-robust-list.q/include/asm-mips/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-mips/futex.h
+++ linux-robust-list.q/include/asm-mips/futex.h
@@ -99,5 +99,11 @@ futex_atomic_op_inuser (int encoded_op, 
 	return ret;
 }
 
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
+	return -ENOSYS;
+}
+
 #endif
 #endif
Index: linux-robust-list.q/include/asm-powerpc/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-powerpc/futex.h
+++ linux-robust-list.q/include/asm-powerpc/futex.h
@@ -81,5 +81,11 @@ static inline int futex_atomic_op_inuser
 	return ret;
 }
 
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
+	return -ENOSYS;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_FUTEX_H */
Index: linux-robust-list.q/include/asm-x86_64/futex.h
===================================================================
--- linux-robust-list.q.orig/include/asm-x86_64/futex.h
+++ linux-robust-list.q/include/asm-x86_64/futex.h
@@ -94,5 +94,11 @@ futex_atomic_op_inuser (int encoded_op, 
 	return ret;
 }
 
+static inline int
+futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+{
+	return -ENOSYS;
+}
+
 #endif
 #endif
