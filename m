Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRHQB4i>; Thu, 16 Aug 2001 21:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269436AbRHQB41>; Thu, 16 Aug 2001 21:56:27 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:58502 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269413AbRHQB4H>; Thu, 16 Aug 2001 21:56:07 -0400
Date: Thu, 16 Aug 2001 18:56:18 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch(?): linux-2.4.9/include/linux/spinlock.h sometimes needs to redefine atomic_dec_and_lock
Message-ID: <20010816185618.A5159@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch to linux-2.4.9/include/linux/spinlock.h
defines atomic_dec_and_lock to atomic_dec_and_test on SMP
architectures that do not have an "atomic_dec_and_lock", such as
i386.  I am not sure if this is the correct patch because, as I
mentioned in my previous email to this list a few minutes ago,
I'm not completely clear on the semantics of these two functions
and I think the problems with this routine may be the result of
an incompletely applied patch.  However, I am posting this patch
in case it is correct or otherwise helpful.  This patch does eliminate
the problem of atomic_dec_and_lock not being defined in sunrpc.o.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="spinlock.diff"

--- linux-2.4.9/include/linux/spinlock.h	Wed Aug 15 14:21:11 2001
+++ linux/include/linux/spinlock.h	Thu Aug 16 18:29:09 2001
@@ -34,6 +34,11 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
+# ifndef CONFIG_HAVE_DEC_LOCK
+#  define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
+# endif
+
+
 #elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
                                   defined (e.g. by including asm/spinlock.h */
 

--FL5UXtIhxfXey3p5--
