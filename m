Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVHFVHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVHFVHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbVHFVH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 17:07:29 -0400
Received: from sd291.sivit.org ([194.146.225.122]:53008 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261248AbVHFVH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 17:07:27 -0400
Subject: Re: [PATCH] Export handle_mm_fault to modules.
From: Stelian Pop <stelian@popies.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olof Johansson <olof@lixom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508051642360.3258@g5.osdl.org>
References: <1123278912.8224.2.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508051558520.3258@g5.osdl.org>
	 <20050805232530.GA8791@austin.ibm.com>
	 <Pine.LNX.4.58.0508051642360.3258@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Sat, 06 Aug 2005 23:07:14 +0200
Message-Id: <1123362434.4635.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 05 août 2005 à 16:43 -0700, Linus Torvalds a écrit :
> 
> On Fri, 5 Aug 2005, Olof Johansson wrote:
> >
> > On Fri, Aug 05, 2005 at 04:02:13PM -0700, Linus Torvalds wrote:
> > 
> > > The only thing that has ever exported it afaik is
> > > 
> > > 	arch/ppc/kernel/ppc_ksyms.c:EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
> > > 
> > > and that looks pretty suspicious too (what is MOL, and regardless, 
> > > shouldn't it be an EXPORT_SYMBOL_GPL?).
> > 
> > Mac-on-Linux, see http://www.maconlinux.org/. Run MacOS in a virtualized
> > machine under Linux (or the other way around). It's GPL.
> 
> Ok. Then I suspect the right patch is this one. Stelian, can you verify?

I confirm, it works perfectly.

Stelian.

> 
> 		Linus
> ---
> diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
> --- a/arch/ppc/kernel/ppc_ksyms.c
> +++ b/arch/ppc/kernel/ppc_ksyms.c
> @@ -324,7 +324,7 @@ EXPORT_SYMBOL(__res);
>  
>  EXPORT_SYMBOL(next_mmu_context);
>  EXPORT_SYMBOL(set_context);
> -EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
> +EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
>  EXPORT_SYMBOL(disarm_decr);
>  #ifdef CONFIG_PPC_STD_MMU
>  extern long mol_trampoline;
> 
-- 
Stelian Pop <stelian@popies.net>

