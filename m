Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbSLFDu3>; Thu, 5 Dec 2002 22:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbSLFDuZ>; Thu, 5 Dec 2002 22:50:25 -0500
Received: from dp.samba.org ([66.70.73.150]:5026 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267542AbSLFDuU>;
	Thu, 5 Dec 2002 22:50:20 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Remove reference to timer_exit() from kernel-locking.tmpl, fix typo.
Date: Fri, 06 Dec 2002 14:45:32 +1100
Message-Id: <20021206035756.3D6C92C2E0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Tommi Virtanen <tv@debian.org>

  	timer_exit() isn't a public function, and doesn't even exist in 2.5.
  	2.4 calls it internally after timers. It seems timer users need not
  	do anything special.
  

--- trivial-2.5-bk/Documentation/DocBook/kernel-locking.tmpl.orig	2002-12-06 13:56:55.000000000 +1100
+++ trivial-2.5-bk/Documentation/DocBook/kernel-locking.tmpl	2002-12-06 13:56:55.000000000 +1100
@@ -1055,10 +1055,8 @@
       Another common problem is deleting timers which restart
       themselves (by calling <function>add_timer()</function> at the end 
       of their timer function).  Because this is a fairly common case 
-      which is prone to races, you can put a call to
-      <function>timer_exit()</function> at the very end of your timer function,
-      and user <function>del_timer_sync()</function> 
-      (<filename class=headerfile>include/linux/timer.h</filename>)
+      which is prone to races, you should use <function>del_timer_sync()</function> 
+      (<filename class=headerfile>include/linux/timer.h</filename>) 
       to handle this case.  It returns the number of times the timer 
       had to be deleted before we finally stopped it from adding itself back 
       in.
-- 
  Don't blame me: the Monkey is driving
  File: Tommi Virtanen <tv@debian.org>: Remove reference to timer_exit() from kernel-locking.tmpl, fix typo.
