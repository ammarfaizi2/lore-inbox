Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTHXNNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTHXNNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 09:13:54 -0400
Received: from ns.suse.de ([195.135.220.2]:59288 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263537AbTHXNNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 09:13:51 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [BUG] 2.4.22-rc3 broke x86-64 ia32 emulation?
References: <200308241211.h7OCBq7T014859@harpo.it.uu.se.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2003 15:13:48 +0200
In-Reply-To: <200308241211.h7OCBq7T014859@harpo.it.uu.se.suse.lists.linux.kernel>
Message-ID: <p73ad9z5hbn.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> 2.4.22-rc3 appears to have broken x86-64's ia32-emulation.
> Now, whenever I run a 32-bit binary I get general protection
> and a core dump:

Ah, I know what the problem is. It's a side effect of the 
interrupt gate fix. This patch should fix it. 

Marcelo, can you please apply it? It fixes the 32bit emulation
on x86-64.

------------------

Fix 32bit system call gate.

--- linux/arch/x86_64/kernel/traps.c-o	2003-06-16 13:03:58.000000000 +0200
+++ linux/arch/x86_64/kernel/traps.c	2003-08-20 10:00:11.000000000 +0200
@@ -837,7 +837,7 @@
 	set_intr_gate(19,&simd_coprocessor_error);
 
 #ifdef CONFIG_IA32_EMULATION
-	set_intr_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
+	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
 #endif
 
 	/*


-Andi
