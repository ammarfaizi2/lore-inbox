Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSCGHeR>; Thu, 7 Mar 2002 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293543AbSCGHeH>; Thu, 7 Mar 2002 02:34:07 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:50693 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293544AbSCGHdz>; Thu, 7 Mar 2002 02:33:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL IV: 2.5.6-pre3. APM idle fix.
Date: Thu, 07 Mar 2002 18:37:14 +1100
Message-Id: <E16isSg-0006at-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Stephen Rothwell <sfr@canb.auug.org.au>: [PATCH] APM idleing fix:

	This bug slipped back in with the need_resched() macro substitution.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.6-pre3/arch/i386/kernel/apm.c trivial-2.5.6-pre3/arch/i386/kernel/apm.c
--- linux-2.5.6-pre3/arch/i386/kernel/apm.c	Wed Feb 20 17:56:59 2002
+++ trivial-2.5.6-pre3/arch/i386/kernel/apm.c	Thu Mar  7 18:20:33 2002
@@ -812,7 +812,7 @@
 
 	t1 = IDLE_LEAKY_MAX;
 
-	while (need_resched()) {
+	while (!need_resched()) {
 		if (use_apm_idle) {
 			unsigned int t;
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
