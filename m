Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSA1PrB>; Mon, 28 Jan 2002 10:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289100AbSA1Pqv>; Mon, 28 Jan 2002 10:46:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46852 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281214AbSA1Pqq>; Mon, 28 Jan 2002 10:46:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] [sched] bitmap cleanup, speedup, 2.5.3-pre5
Date: 28 Jan 2002 07:46:19 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a33rob$26r$1@nell.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201281744070.9796-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0201281744070.9796-100000@localhost.localdomain>
By author:    Ingo Molnar <mingo@elte.hu>
In newsgroup: linux.dev.kernel
> 
> +static __inline__ unsigned long __ffs(unsigned long word)
> +{
> +	__asm__("bsfl %1,%0"
> +		:"=r" (word)
> +		:"r" (word));
>  	return word;
>  }
> 

Should typically be:

static __inline__ unsigned long __ffs(unsigned long word)
{
	__asm__("bsfl %1,%0"
		:"=r" (word)
		:"rm" (word));
 	return word;
 }

There is no reason to force the compiler to put the operand in a
register.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
