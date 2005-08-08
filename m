Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVHHItV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVHHItV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVHHItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:49:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:9165 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750763AbVHHItU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:49:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Export handle_mm_fault to modules.
Date: Mon, 8 Aug 2005 10:44:10 +0200
User-Agent: KMail/1.7.2
Cc: Olof Johansson <olof@lixom.net>, Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1123278912.8224.2.camel@localhost.localdomain> <20050805232530.GA8791@austin.ibm.com> <Pine.LNX.4.58.0508051642360.3258@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508051642360.3258@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508081044.10875.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 06 August 2005 01:43, Linus Torvalds wrote:
> diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
> --- a/arch/ppc/kernel/ppc_ksyms.c
> +++ b/arch/ppc/kernel/ppc_ksyms.c
> @@ -324,7 +324,7 @@ EXPORT_SYMBOL(__res);
>  
>  EXPORT_SYMBOL(next_mmu_context);
>  EXPORT_SYMBOL(set_context);
> -EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
> +EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
>  EXPORT_SYMBOL(disarm_decr);
>  #ifdef CONFIG_PPC_STD_MMU
>  extern long mol_trampoline;

We will need the same export on ppc64 for managing SPEs on the
Cell processor. My current patch removes the export on ppc
and adds a global (*_GPL) one. Should I rather have another
architecture specific export in ppc64?

	Arnd <><
