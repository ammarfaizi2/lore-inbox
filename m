Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTFGGEb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFGGEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:04:30 -0400
Received: from dp.samba.org ([66.70.73.150]:53193 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261819AbTFGGEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:04:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: fleming@austin.ibm.com, zwane@linuxpower.ca, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [PATCH] Remove chatty printk on CPU bringup.
Date: Sat, 07 Jun 2003 16:12:14 +1000
Message-Id: <20030607061805.34E892C15B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

The printk is useless, and on archs where cpu_possible(i) is always
true, it spams the console.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk11/init/main.c working-2.5.70-bk11-tmp/init/main.c
--- linux-2.5.70-bk11/init/main.c	2003-05-27 15:02:23.000000000 +1000
+++ working-2.5.70-bk11-tmp/init/main.c	2003-06-07 16:02:55.000000000 +1000
@@ -339,10 +339,8 @@ static void __init smp_init(void)
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
