Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVCJW4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVCJW4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbVCJWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:51:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:27603 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262086AbVCJWtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:49:40 -0500
Subject: Re: [PATCH 2/2] No-exec support for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Olof Johansson <olof@austin.ibm.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <20050310162721.19003dac.moilanen@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	 <20050308171326.3d72363a.moilanen@austin.ibm.com>
	 <20050310032507.GC20789@austin.ibm.com> <1110438934.32524.203.camel@gaston>
	 <20050310162721.19003dac.moilanen@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 09:44:28 +1100
Message-Id: <1110494668.32525.283.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>  /* Free memory returned from module_alloc */
> diff -puN arch/ppc64/mm/fault.c~nx-kernel-ppc64 arch/ppc64/mm/fault.c
> --- linux-2.6-bk/arch/ppc64/mm/fault.c~nx-kernel-ppc64	2005-03-10 13:54:14 -06:00
> +++ linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c	2005-03-10 13:54:14 -06:00
> @@ -76,6 +76,13 @@ static int store_updates_sp(struct pt_re
>  	return 0;
>  }
>  
> +pte_t *lookup_address(unsigned long address) 
> +{ 
> +	pgd_t *pgd = pgd_offset_k(address); 
> +
> +	return find_linux_pte(pgd, address);
> +} 

static please, even inline in this case.

I've removed Andrew from CC upon his request, Paul, Anton or I will
forward to him when it's ready, no need to clobber his mailbox in the
meantime.

Ben.


