Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUHOC7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUHOC7e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 22:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUHOC7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 22:59:34 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36091 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265517AbUHOC7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 22:59:32 -0400
Date: Sat, 14 Aug 2004 23:03:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] smp_call_function WARN_ON
Message-ID: <Pine.LNX.4.58.0408131448020.18353@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN_ON() is really only true if you're waiting for the other
processors.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc4-mm1/arch/i386/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc4-mm1/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8-rc4-mm1/arch/i386/kernel/smp.c	10 Aug 2004 14:49:26 -0000	1.1.1.1
+++ linux-2.6.8-rc4-mm1/arch/i386/kernel/smp.c	13 Aug 2004 18:46:11 -0000
@@ -538,7 +538,7 @@ int smp_call_function (void (*func) (voi
 	}

 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(wait && irqs_disabled());

 	data.func = func;
 	data.info = info;
Index: linux-2.6.8-rc4-mm1/arch/x86_64/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc4-mm1/arch/x86_64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8-rc4-mm1/arch/x86_64/kernel/smp.c	10 Aug 2004 14:49:30 -0000	1.1.1.1
+++ linux-2.6.8-rc4-mm1/arch/x86_64/kernel/smp.c	13 Aug 2004 18:45:54 -0000
@@ -417,7 +417,7 @@ int smp_call_function (void (*func) (voi
 		return 0;

 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(wait && irqs_disabled());

 	data.func = func;
 	data.info = info;
