Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSHZVFf>; Mon, 26 Aug 2002 17:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSHZVFf>; Mon, 26 Aug 2002 17:05:35 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:21171 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318268AbSHZVFe>; Mon, 26 Aug 2002 17:05:34 -0400
Date: Mon, 26 Aug 2002 15:09:43 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make raid5 checksums preempt-safe
In-Reply-To: <1030392363.905.418.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208261507590.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26 Aug 2002, Robert Love wrote:
> @@ -543,6 +545,7 @@
>  #define XMMS_SAVE				\
> +	preempt_disable();			\
>  	__asm__ __volatile__ ( 			\
>  		"movl %%cr0,%0		;\n\t"	\
>  		"clts			;\n\t"	\
> @@ -564,7 +567,8 @@
>  		"movl 	%0,%%cr0	;\n\t"	\
>  		:				\
>  		: "r" (cr0), "r" (xmm_save)	\
> -		: "memory")
> +		: "memory")			\
> +	preempt_enable();
> @@ -38,7 +38,8 @@
>  #define XMMS_SAVE				\
> -	asm volatile ( 			\
> +	preempt_disable();			\
> +	asm volatile (				\
>  		"movq %%cr0,%0		;\n\t"	\
>  		"clts			;\n\t"	\
>  		"movups %%xmm0,(%1)	;\n\t"	\
> @@ -59,7 +60,8 @@
>  		"movq 	%0,%%cr0	;\n\t"	\
>  		:				\
>  		: "r" (cr0), "r" (xmm_save)	\
> -		: "memory")
> +		: "memory")			\
> +	preempt_enable();

These will suck when on if, I guess... Anyway, will this compile at all? 
There seems no semicolon after the asm volatile ()

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

