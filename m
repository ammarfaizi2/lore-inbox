Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTHXQLy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTHXQLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:11:54 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41914 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261244AbTHXQLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:11:53 -0400
Date: Sun, 24 Aug 2003 18:11:45 +0200 (MEST)
Message-Id: <200308241611.h7OGBjnt020780@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: Re: [PATCH] Re: [BUG] 2.4.22-rc3 broke x86-64 ia32 emulation?
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Aug 2003 15:13:48 +0200, Andi Kleen wrote:
>Mikael Pettersson <mikpe@csd.uu.se> writes:
>
>> 2.4.22-rc3 appears to have broken x86-64's ia32-emulation.
>> Now, whenever I run a 32-bit binary I get general protection
>> and a core dump:
>
>Ah, I know what the problem is. It's a side effect of the 
>interrupt gate fix. This patch should fix it. 
>
>Marcelo, can you please apply it? It fixes the 32bit emulation
>on x86-64.
>
>------------------
>
>Fix 32bit system call gate.
>
>--- linux/arch/x86_64/kernel/traps.c-o	2003-06-16 13:03:58.000000000 +0200
>+++ linux/arch/x86_64/kernel/traps.c	2003-08-20 10:00:11.000000000 +0200
>@@ -837,7 +837,7 @@
> 	set_intr_gate(19,&simd_coprocessor_error);
> 
> #ifdef CONFIG_IA32_EMULATION
>-	set_intr_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
>+	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
> #endif

Yes that fixed it. Thanks!

/Mikael
