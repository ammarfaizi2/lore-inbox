Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUADV4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264602AbUADV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:56:32 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:30952 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264535AbUADV42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:56:28 -0500
Date: Sun, 4 Jan 2004 22:56:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Remove Intel check in i386 HPET code
Message-ID: <20040104215621.GC14982@ucw.cz>
References: <20040104131350.GA21508@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104131350.GA21508@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 02:13:50PM +0100, Andi Kleen wrote:
> 
> The i386 HPET time setup code would explicitely check for the Intel
> vendor ID. That is bogus because other chipset vendors (like AMD) 
> are implementing HPET too. 
> 
> Remove this check.

You can also remove the HPET_ID_VENDOR_8086 definition.

> 
> -Andi
> 
> diff -u linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c~ linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c
> --- linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c~	2004-01-04 14:10:59.000000000 +0100
> +++ linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c	2004-01-04 14:10:59.000000000 +0100
> @@ -91,10 +91,6 @@
>  	    !(id & HPET_ID_LEGSUP))
>  		return -1;
>  
> -	if (((id & HPET_ID_VENDOR) >> HPET_ID_VENDOR_SHIFT) !=
> -				HPET_ID_VENDOR_8086)
> -		return -1;
> -
>  	hpet_period = hpet_readl(HPET_PERIOD);
>  	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD))
>  		return -1;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
