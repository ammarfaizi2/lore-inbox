Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945979AbWBOPTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945979AbWBOPTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945975AbWBOPTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:19:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38863 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1945974AbWBOPTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:19:24 -0500
Date: Wed, 15 Feb 2006 16:17:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 3/5] lightweight robust futexes: arch defaults
Message-ID: <20060215151739.GD31569@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
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
 include/asm-mips/futex.h    |    6 ++++++
 include/asm-powerpc/futex.h |    6 ++++++
 4 files changed, 24 insertions(+)

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
