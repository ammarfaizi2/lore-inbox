Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131203AbRACWJi>; Wed, 3 Jan 2001 17:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130669AbRACWJ2>; Wed, 3 Jan 2001 17:09:28 -0500
Received: from linuxcare.com.au ([203.29.91.49]:58895 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130111AbRACWJN>; Wed, 3 Jan 2001 17:09:13 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 4 Jan 2001 09:07:41 +1100
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@redhat.com>
Subject: Re: 2.2.19pre5 on sparc64: Missing symbols
Message-ID: <20010104090741.A21322@linuxcare.com>
In-Reply-To: <200101031650.f03Go4D29320@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101031650.f03Go4D29320@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Wed, Jan 03, 2001 at 01:50:04PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> depmod: *** Unresolved symbols in /lib/modules/2.2.19pre5/fs/binfmt_elf.o
> depmod: 	get_pte_slow
> depmod: 	get_pmd_slow
> depmod: 	pgt_quicklists

Thanks, fix is in cvs.

Anton

--- arch/sparc64/kernel/sparc64_ksyms.c.orig	Thu Jan  4 09:04:07 2001
+++ arch/sparc64/kernel/sparc64_ksyms.c	Thu Jan  4 08:48:29 2001
@@ -210,6 +210,11 @@
 /* Should really be in linux/kernel/ksyms.c */
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
+EXPORT_SYMBOL(get_pmd_slow);
+EXPORT_SYMBOL(get_pte_slow);
+#ifndef CONFIG_SMP
+EXPORT_SYMBOL(pgt_quicklists);
+#endif
 
 /* math-emu wants this */
 EXPORT_SYMBOL(die_if_kernel);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
