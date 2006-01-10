Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWAJVUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWAJVUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWAJVUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:20:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18066 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932318AbWAJVUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:20:22 -0500
Date: Tue, 10 Jan 2006 15:20:20 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: paulus@samba.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060110212020.GB10837@sergelap.austin.ibm.com>
References: <20060107052221.61d0b600.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/

With both this and 2.6.15-mm1, but not with 2.6.15, I get the following
error:

mm/built-in.o(*ABS*+0x39c3c7ac): In function `__crc___handle_mm_fault':
slab.c: multiple definition of `__crc___handle_mm_fault'
make: *** [.tmp_vmlinux1] Error 1

The culprit appears to be that there are two places where
__handle_mm_fault is EXPORT_SYMBOL_GPLed.  The following trivial patch
fixes it for me.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.15/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.15.orig/arch/powerpc/kernel/ppc_ksyms.c	2006-01-10 04:59:11.000000000 -0600
+++ linux-2.6.15/arch/powerpc/kernel/ppc_ksyms.c	2006-01-10 09:07:40.000000000 -0600
@@ -240,8 +240,6 @@ EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
 #endif
 
-EXPORT_SYMBOL_GPL(__handle_mm_fault);
-
 #ifdef CONFIG_PPC_STD_MMU_32
 extern long mol_trampoline;
 EXPORT_SYMBOL(mol_trampoline); /* For MOL */


thanks,
-serge
