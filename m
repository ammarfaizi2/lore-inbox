Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUFUUBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUFUUBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUFUUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:01:18 -0400
Received: from fmr01.intel.com ([192.55.52.18]:23731 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266436AbUFUUBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:01:12 -0400
Subject: Re: [PATCH] 2.4.27-rc1 i386 and x86_64 ACPI mpparse timer bug
From: Len Brown <len.brown@intel.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Hans-Frieder Vogt <hfvogt@arcor.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200406202355.i5KNtPdp021261@harpo.it.uu.se>
References: <200406202355.i5KNtPdp021261@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1087848051.4319.202.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Jun 2004 16:00:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mikael, Hans, you got it right.

-Len

On Sun, 2004-06-20 at 19:55, Mikael Pettersson wrote:
> 2.4.27-rc1 reintroduced the double-speed timer ACPI bug.
> Both x86-64 and i386 are affected.
> 
> The patch below fixes it on my box. It's a backport of a
> patch Hans-Frieder Vogt made for 2.6.7-bk2, extended to
> also handle i386.
> 
> /Mikael Pettersson
> 
> diff -ruN linux-2.4.27-rc1/arch/i386/kernel/mpparse.c linux-2.4.27-rc1.mpparse-fix/arch/i386/kernel/mpparse.c
> --- linux-2.4.27-rc1/arch/i386/kernel/mpparse.c	2004-06-21 00:39:30.000000000 +0200
> +++ linux-2.4.27-rc1.mpparse-fix/arch/i386/kernel/mpparse.c	2004-06-21 00:50:01.000000000 +0200
> @@ -1211,7 +1211,7 @@
>  
>  		for (idx = 0; idx < mp_irq_entries; idx++)
>  			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
> -				(mp_irqs[idx].mpc_dstapic == ioapic) &&
> +				(mp_irqs[idx].mpc_dstapic == mp_ioapics[ioapic].mpc_apicid) &&
>  				(mp_irqs[idx].mpc_srcbusirq == i ||
>  				mp_irqs[idx].mpc_dstirq == i))
>  					break;
> diff -ruN linux-2.4.27-rc1/arch/x86_64/kernel/mpparse.c linux-2.4.27-rc1.mpparse-fix/arch/x86_64/kernel/mpparse.c
> --- linux-2.4.27-rc1/arch/x86_64/kernel/mpparse.c	2004-06-21 00:39:30.000000000 +0200
> +++ linux-2.4.27-rc1.mpparse-fix/arch/x86_64/kernel/mpparse.c	2004-06-21 00:50:01.000000000 +0200
> @@ -866,7 +866,7 @@
>  
>  		for (idx = 0; idx < mp_irq_entries; idx++)
>  			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
> -				(mp_irqs[idx].mpc_dstapic == ioapic) &&
> +				(mp_irqs[idx].mpc_dstapic == intsrc.mpc_dstapic) &&
>  				(mp_irqs[idx].mpc_srcbusirq == i ||
>  				mp_irqs[idx].mpc_dstirq == i))
>  					break;

