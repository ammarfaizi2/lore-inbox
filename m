Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132242AbRA1Fup>; Sun, 28 Jan 2001 00:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131572AbRA1Fuf>; Sun, 28 Jan 2001 00:50:35 -0500
Received: from donna.siteprotect.com ([64.26.0.144]:63504 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S132973AbRA1FuP>; Sun, 28 Jan 2001 00:50:15 -0500
Date: Sun, 28 Jan 2001 00:50:16 -0500 (EST)
From: Vince Weaver <vince@deater.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: broken Cyrix 486 cpuinfo in 2.4.0 [patch]
Message-ID: <Pine.LNX.4.30.0101280047320.13858-100000@hal.deaternet.vmw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I have fixed the problem I reported earlier.  The following patch
makes my Cyrix 486-66 report with the same results as on 2.2.x.

If no one finds any problems with it, I'll send it on to Linus.

Vince

--- ./arch/i386/kernel/setup.c.orig	Sat Jan 27 21:05:03 2001
+++ ./arch/i386/kernel/setup.c	Sun Jan 28 00:51:11 2001
@@ -1866,7 +1866,8 @@
 	/* Detect Cyrix with disabled CPUID */
 	if ( c->x86 == 4 && test_cyrix_52div() ) {
 		strcpy(c->x86_vendor_id, "CyrixInstead");
-	}
+	        c->x86_vendor = X86_VENDOR_CYRIX;
+	} else

 	/* Detect NexGen with old hypercode */
 	if ( deep_magic_nexgen_probe() ) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
