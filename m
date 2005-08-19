Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVHSNZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVHSNZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVHSNZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:25:28 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:51409 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S932669AbVHSNZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:25:27 -0400
Message-ID: <4305DDBF.1060309@ens-lyon.org>
Date: Fri, 19 Aug 2005 15:25:19 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/traps.c: In function 'die_nmi':
arch/i386/kernel/traps.c:633: warning: statement with no effect

Another smp_nmi_call.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice


--- linux-mm/arch/i386/kernel/traps.c.old	2005-08-19 15:19:14.000000000
+0200
+++ linux-mm/arch/i386/kernel/traps.c	2005-08-19 15:19:47.000000000 +0200
@@ -630,7 +630,9 @@ void die_nmi (struct pt_regs *regs, cons
 	printk(" on CPU%d, eip %08lx, registers:\n",
 		smp_processor_id(), regs->eip);
 	show_registers(regs);
+#ifdef CONFIG_SMP
 	smp_nmi_call_function(smp_show_regs, NULL, 1);
+#endif
 	bust_spinlocks(1);
 	printk("console shuts up ...\n");
 	console_silent();

