Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbTGGHqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 03:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbTGGHq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 03:46:26 -0400
Received: from dp.samba.org ([66.70.73.150]:29875 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266835AbTGGHqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 03:46:18 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Remove chatty printk on CPU bringup.
Date: Mon, 07 Jul 2003 17:56:39 +1000
Message-Id: <20030707080052.30EE12C3C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

  Linus, please apply.
  
  The printk is useless, and on archs where cpu_possible(i) is always
  true, it spams the console.
  
  Thanks,
  Rusty.
  --
    Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
  

--- trivial-2.5.74-bk4/init/main.c.orig	2003-07-07 17:36:51.000000000 +1000
+++ trivial-2.5.74-bk4/init/main.c	2003-07-07 17:36:51.000000000 +1000
@@ -342,10 +342,8 @@
 	for (i = 0; i < NR_CPUS; i++) {
 		if (num_online_cpus() >= max_cpus)
 			break;
-		if (cpu_possible(i) && !cpu_online(i)) {
-			printk("Bringing up %i\n", i);
+		if (cpu_possible(i) && !cpu_online(i))
 			cpu_up(i);
-		}
 	}
 
 	/* Any cleanup work */
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Rusty Russell <rusty@rustcorp.com.au>: [PATCH] Remove chatty printk on CPU bringup.
