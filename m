Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267173AbUBRXIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUBRXIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:08:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267173AbUBRXIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:08:39 -0500
Date: Wed, 18 Feb 2004 15:08:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
In-Reply-To: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Stephen Hemminger wrote:
>
> In the mad rush to put in Intel 64 bit support, did anyone make sure and not
> break the 32 bit build?

Heh. Somebody has the driver enabled ;).

How about this patch?

		Linus

---
===== arch/i386/kernel/microcode.c 1.24 vs edited =====
--- 1.24/arch/i386/kernel/microcode.c	Tue Feb 17 18:14:37 2004
+++ edited/arch/i386/kernel/microcode.c	Wed Feb 18 15:05:38 2004
@@ -371,8 +371,9 @@
 	spin_lock_irqsave(&microcode_update_lock, flags);          
 
 	/* write microcode via MSR 0x79 */
-	wrmsr(MSR_IA32_UCODE_WRITE, (u64)(uci->mc->bits), 
-	      (u64)(uci->mc->bits) >> 32);
+	wrmsr(MSR_IA32_UCODE_WRITE,
+		(unsigned long) uci->mc->bits, 
+		(unsigned long) uci->mc->bits >> 16 >> 16);
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
 	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
