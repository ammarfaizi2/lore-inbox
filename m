Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293538AbSCGHeG>; Thu, 7 Mar 2002 02:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293546AbSCGHd4>; Thu, 7 Mar 2002 02:33:56 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:20997 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293538AbSCGHdo>; Thu, 7 Mar 2002 02:33:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL I: 2.5.6-pre3. Documentation
Date: Thu, 07 Mar 2002 18:37:02 +1100
Message-Id: <E16isSU-0006aV-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  atomic ops are *not* barriers any more.

Sebastian Wilhelmi <wilhelmi@ira.uka.de>: Re: Question on your "Unreliable Guide To Locking":
  > Yes, this is no longer true.  The modern assumptions are that they are
  > not barriers.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/Documentation/DocBook/kernel-locking.tmpl trivial-2.5.6-pre3/Documentation/DocBook/kernel-locking.tmpl
--- linux-2.5.6-pre3/Documentation/DocBook/kernel-locking.tmpl	Sun May 20 10:43:05 2001
+++ trivial-2.5.6-pre3/Documentation/DocBook/kernel-locking.tmpl	Thu Mar  7 18:20:33 2002
@@ -788,8 +788,18 @@
     </para>
 
     <para>
-      Note that the atomic operations are defined to act as both
-      read and write barriers on all platforms.
+      Note that the atomic operations do in general not act as memory
+      barriers. Instead you can insert a memory barrier before or
+      after <function>atomic_inc()</function> or
+      <function>atomic_dec()</function> by inserting
+      <function>smp_mb__before_atomic_inc()</function>,
+      <function>smp_mb__after_atomic_inc()</function>,
+      <function>smp_mb__before_atomic_dec()</function> or
+      <function>smp_mb__after_atomic_dec()</function>
+      respectively. The advantage of using those macros instead of
+      <function>smp_mb()</function> is, that they are cheaper on some
+      platforms.    
+      <!-- Sebastian Wilhelmi <seppi@seppi.de> 2002-03-04 -->
     </para>
    </sect1>
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
