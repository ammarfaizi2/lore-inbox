Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbUKKEP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUKKEP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbUKKEP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:15:57 -0500
Received: from motgate8.mot.com ([129.188.136.8]:39419 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S262090AbUKKEPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:15:49 -0500
Date: Wed, 10 Nov 2004 22:15:43 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Remove __setup_cpu_8xx
Message-ID: <Pine.LNX.4.61.0411102212450.19875@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Remove __setup_cpu_8xx and its initialization in cpu_specs table since it 
hasn't every done anything.  This is at Tom Rini's suggestion.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com> 

--

diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2004-11-10 17:12:09 -06:00
+++ b/arch/ppc/kernel/cputable.c	2004-11-10 17:12:09 -06:00
@@ -30,7 +30,6 @@
 extern void __setup_cpu_power3(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_8xx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_generic(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
@@ -693,7 +692,6 @@
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 		.num_pmcs		= 0,
-		.cpu_setup		= __setup_cpu_8xx	/* Empty */
 	},
 #endif /* CONFIG_8xx */
 #ifdef CONFIG_40x
diff -Nru a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
--- a/arch/ppc/kernel/head_8xx.S	2004-11-10 17:12:09 -06:00
+++ b/arch/ppc/kernel/head_8xx.S	2004-11-10 17:12:09 -06:00
@@ -638,11 +638,6 @@
 giveup_fpu:
 	blr
 
-/* Maybe someday.......
-*/
-_GLOBAL(__setup_cpu_8xx)
-	blr
-
 /*
  * This is where the main kernel code starts.
  */
