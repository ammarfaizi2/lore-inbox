Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270043AbUJHQ4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270043AbUJHQ4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270023AbUJHQ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:56:34 -0400
Received: from [151.97.230.17] ([151.97.230.17]:16530 "EHLO zion.localdomain")
	by vger.kernel.org with ESMTP id S270043AbUJHQyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:54:31 -0400
Subject: [patch 1/1] uml: don't declare cpu_online - fix compilation error
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 08 Oct 2004 18:54:31 +0200
Message-Id: <20041008165431.EDE238D15@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid redeclaring again (resulting in a compilation error) cpu_online and
cpu_*_map, which are now declared elsewhere.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/smp.h |    6 ------
 1 files changed, 6 deletions(-)

diff -puN include/asm-um/smp.h~uml-no-decl-cpu_online include/asm-um/smp.h
--- linux-2.6.9-current/include/asm-um/smp.h~uml-no-decl-cpu_online	2004-10-08 18:00:49.000000000 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/smp.h	2004-10-08 18:00:49.000000000 +0200
@@ -8,10 +8,6 @@
 #include "asm/current.h"
 #include "linux/cpumask.h"
 
-extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
-
-
 #define smp_processor_id() (current_thread->cpu)
 #define cpu_logical_map(n) (n)
 #define cpu_number_map(n) (n)
@@ -19,8 +15,6 @@ extern cpumask_t cpu_possible_map;
 extern int hard_smp_processor_id(void);
 #define NO_PROC_ID -1
 
-#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-
 extern int ncpus;
 
 
_
