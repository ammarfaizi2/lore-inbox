Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUJLASv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUJLASv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUJLARR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:17:17 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:10627
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269380AbUJLAQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:16:56 -0400
Subject: [patch 4/6] uml: don't declare cpu_online - fix compilation error
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:16:31 +0200
Message-Id: <20041012001631.60C75868F@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid redeclaring again (resulting in a compilation error) cpu_online and
cpu_*_map, which are now declared elsewhere.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/smp.h |    6 ------
 1 files changed, 6 deletions(-)

diff -puN include/asm-um/smp.h~uml-no-decl-cpu_online include/asm-um/smp.h
--- linux-2.6.9-current/include/asm-um/smp.h~uml-no-decl-cpu_online	2004-10-12 01:18:02.531646720 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/smp.h	2004-10-12 01:18:02.533646416 +0200
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
