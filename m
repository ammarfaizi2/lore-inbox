Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267820AbUHJXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267820AbUHJXyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHJXwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:52:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:51368 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267835AbUHJXvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:51:13 -0400
Date: Wed, 11 Aug 2004 01:56:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][trivial] line up 'ESR value before/after enabling vector'
 messages
Message-ID: <Pine.LNX.4.61.0408110145030.2690@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a very trivial patch to make the values in these messages line up 
nicely :

ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000

Much nicer to read when they line up like so : 

ESR value before enabling vector: 00000000
ESR value after enabling vector:  00000000

We got the "CPU: After ... caps:" messages nicely lined up recently, now I 
figured it was time for these ones as well..

Patches for both i386 and x86_64 below. Both diffs where created against 
2.6.8-rc3-mm1

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8-rc3-mm1-orig/arch/i386/kernel/apic.c linux-2.6.8-rc3-mm1/arch/i386/kernel/apic.c
--- linux-2.6.8-rc3-mm1-orig/arch/i386/kernel/apic.c	2004-08-05 21:48:50.000000000 +0200
+++ linux-2.6.8-rc3-mm1/arch/i386/kernel/apic.c	2004-08-11 01:40:56.000000000 +0200
@@ -473,7 +473,7 @@ void __init setup_local_APIC (void)
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
 		apic_printk(APIC_VERBOSE, "ESR value after enabling vector:"
-				" %08lx\n", value);
+				"  %08lx\n", value);
 	} else {
 		if (esr_disable)	
 			/* 

diff -up linux-2.6.8-rc3-mm1-orig/arch/x86_64/kernel/apic.c linux-2.6.8-rc3-mm1/arch/x86_64/kernel/apic.c
--- linux-2.6.8-rc3-mm1-orig/arch/x86_64/kernel/apic.c	2004-08-05 21:48:52.000000000 +0200
+++ linux-2.6.8-rc3-mm1/arch/x86_64/kernel/apic.c	2004-08-11 01:41:52.000000000 +0200
@@ -421,7 +421,7 @@ void __init setup_local_APIC (void)
 		if (maxlvt > 3)
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
-		Dprintk("ESR value after enabling vector: %08x\n", value);
+		Dprintk("ESR value after enabling vector:  %08x\n", value);
 	} else {
 		if (esr_disable)	
 			/* 


--
Jesper Juhl


