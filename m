Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLMTyq>; Wed, 13 Dec 2000 14:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQLMTyh>; Wed, 13 Dec 2000 14:54:37 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:2631 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129604AbQLMTyT>; Wed, 13 Dec 2000 14:54:19 -0500
Date: Wed, 13 Dec 2000 19:23:52 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test12:
Message-ID: <20001213192352.L5918@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch from Armin Kuster which adds inline documentation to
some macros.

Tim.
*/

2000-12-13  Tim Waugh  <twaugh@redhat.com>

	* include/linux/init.h, include/linux/module.h: Inline
	documentation for some macros.  Patch from Armin Kuster.

--- linux-2.4.0-test12/include/linux/init.h.macrodoc	Wed Nov  1 15:06:38 2000
+++ linux-2.4.0-test12/include/linux/init.h	Wed Dec 13 14:02:38 2000
@@ -86,7 +86,27 @@
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"
 
+/**
+ * module_init() - driver initialization entry point
+ * @x: function to be run at kernel boot time or module insertion
+ * 
+ * module_init() will add the driver initialization routine in
+ * the "__initcall.int" code segment if the driver is checked as
+ * "y" or static, or else it will wrap the driver initialization
+ * routine with init_module() which is used by insmod and
+ * modprobe when the driver is used as a module.
+ */
 #define module_init(x)	__initcall(x);
+
+/**
+ * module_exit() - driver exit entry point
+ * @x: function to be run when driver is removed
+ * 
+ * module_exit() will wrap the driver clean-up code
+ * with cleanup_module() when used with rmmod when
+ * the driver is a module.  If the driver is statically
+ * compiled into the kernel, module_exit() has no effect.
+ */
 #define module_exit(x)	__exitcall(x);
 
 #else
--- linux-2.4.0-test12/include/asm-i386/atomic.h.macrodoc	Tue Oct 10 14:34:08 2000
+++ linux-2.4.0-test12/include/asm-i386/atomic.h	Wed Dec 13 14:02:29 2000
@@ -23,9 +23,30 @@
 
 #define ATOMIC_INIT(i)	{ (i) }
 
+/**
+ * atomic_read - read atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically reads the value of @v.
+ */ 
 #define atomic_read(v)		((v)->counter)
+
+/**
+ * atomic_set - set atomic variable
+ * @v: pointer of type atomic_t
+ * @i: required value
+ * 
+ * Atomically sets the value of @v to @i.
+ */ 
 #define atomic_set(v,i)		(((v)->counter) = (i))
 
+/**
+ * atomic_add - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically adds @i to @v.
+ */
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
 	__asm__ __volatile__(
@@ -34,6 +55,13 @@
 		:"ir" (i), "m" (v->counter));
 }
 
+/**
+ * atomic_sub - subtract the atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically subtracts @i from @v.
+ */
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
 	__asm__ __volatile__(
@@ -42,6 +70,15 @@
 		:"ir" (i), "m" (v->counter));
 }
 
+/**
+ * atomic_sub_and_test - test variable then subtract 
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
 static __inline__ int atomic_sub_and_test(int i, atomic_t *v)
 {
 	unsigned char c;
@@ -53,6 +90,12 @@
 	return c;
 }
 
+/**
+ * atomic_inc - increment atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1.
+ */ 
 static __inline__ void atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__(
@@ -61,6 +104,12 @@
 		:"m" (v->counter));
 }
 
+/**
+ * atomic_dec - decrement the atomic variable
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1.
+ */ 
 static __inline__ void atomic_dec(atomic_t *v)
 {
 	__asm__ __volatile__(
@@ -69,6 +118,14 @@
 		:"m" (v->counter));
 }
 
+/**
+ * atomic_dec_and_test - decrement by 1 and test
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */ 
 static __inline__ int atomic_dec_and_test(atomic_t *v)
 {
 	unsigned char c;
@@ -80,6 +137,14 @@
 	return c != 0;
 }
 
+/**
+ * atomic_inc_and_test - increment by 1 and test 
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */ 
 static __inline__ int atomic_inc_and_test(atomic_t *v)
 {
 	unsigned char c;
@@ -91,6 +156,15 @@
 	return c != 0;
 }
 
+/**
+ * atomic_add_negative - add and test if negative
+ * @v: pointer of type atomic_t
+ * @i: integer value to add
+ * 
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */ 
 static __inline__ int atomic_add_negative(int i, atomic_t *v)
 {
 	unsigned char c;
--- linux-2.4.0-test12/Documentation/DocBook/kernel-api.tmpl.macrodoc	Tue Oct 10 14:33:27 2000
+++ linux-2.4.0-test12/Documentation/DocBook/kernel-api.tmpl	Wed Dec 13 14:05:13 2000
@@ -34,6 +34,18 @@
  </bookinfo>
 
 <toc></toc>
+
+  <chapter id="Basics">
+     <title>Driver Basic</title>
+     <sect1><title>Driver Entry and Exit points</title>
+!Iinclude/linux/init.h
+     </sect1>
+
+     <sect1><title>Atomics</title>
+!Iinclude/asm-i386/atomic.h
+     </sect1>
+  </chapter>
+
   <chapter id="adt">
      <title>Data Types</title>
      <sect1><title>Doubly Linked Lists</title>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
