Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVHEXnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVHEXnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVHEXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:43:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbVHEXnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:43:19 -0400
Date: Fri, 5 Aug 2005 16:43:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olof Johansson <olof@lixom.net>
cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export handle_mm_fault to modules.
In-Reply-To: <20050805232530.GA8791@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0508051642360.3258@g5.osdl.org>
References: <1123278912.8224.2.camel@localhost.localdomain>
 <Pine.LNX.4.58.0508051558520.3258@g5.osdl.org> <20050805232530.GA8791@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Aug 2005, Olof Johansson wrote:
>
> On Fri, Aug 05, 2005 at 04:02:13PM -0700, Linus Torvalds wrote:
> 
> > The only thing that has ever exported it afaik is
> > 
> > 	arch/ppc/kernel/ppc_ksyms.c:EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
> > 
> > and that looks pretty suspicious too (what is MOL, and regardless, 
> > shouldn't it be an EXPORT_SYMBOL_GPL?).
> 
> Mac-on-Linux, see http://www.maconlinux.org/. Run MacOS in a virtualized
> machine under Linux (or the other way around). It's GPL.

Ok. Then I suspect the right patch is this one. Stelian, can you verify?

		Linus
---
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -324,7 +324,7 @@ EXPORT_SYMBOL(__res);
 
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
-EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
+EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
 EXPORT_SYMBOL(disarm_decr);
 #ifdef CONFIG_PPC_STD_MMU
 extern long mol_trampoline;
