Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266927AbUBRXZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267051AbUBRXYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:24:43 -0500
Received: from ns.suse.de ([195.135.220.2]:36506 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267158AbUBRXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:22:40 -0500
Date: Thu, 19 Feb 2004 01:11:59 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix microcode change for i386
Message-Id: <20040219011159.6f60aa69.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch should fix the i386 compile problem in the microcode driver I caused with
the IA32e updates.

diff -u linux-2.6.3-amd64/arch/i386/kernel/microcode.c-o linux-2.6.3-amd64/arch/i386/kernel/microcode.c
--- linux-2.6.3-amd64/arch/i386/kernel/microcode.c-o	2004-02-19 00:19:32.000000000 +0100
+++ linux-2.6.3-amd64/arch/i386/kernel/microcode.c	2004-02-19 00:56:41.000000000 +0100
@@ -371,8 +371,8 @@
 	spin_lock_irqsave(&microcode_update_lock, flags);          
 
 	/* write microcode via MSR 0x79 */
-	wrmsr(MSR_IA32_UCODE_WRITE, (u64)(uci->mc->bits), 
-	      (u64)(uci->mc->bits) >> 32);
+	wrmsr(MSR_IA32_UCODE_WRITE, (u32)(unsigned long)(uci->mc->bits), 
+	      (u32)(((unsigned long)uci->mc->bits) >> 32));
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
 	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
