Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpI6rqA9zDRGwT/iyMnsSXs4DYg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 21:58:15 +0000
Message-ID: <024801c415a4$8eab3020$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:43:18 +0100
Content-Class: urn:content-classes:message
From: "Vojtech Pavlik" <vojtech@suse.cz>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [PATCH] Remove Intel check in i386 HPET code
References: <20040104131350.GA21508@averell>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20040104131350.GA21508@averell>
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:43:18.0625 (UTC) FILETIME=[8EB4CD10:01C415A4]

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
