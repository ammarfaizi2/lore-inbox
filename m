Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284088AbRLKWOa>; Tue, 11 Dec 2001 17:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284118AbRLKWOJ>; Tue, 11 Dec 2001 17:14:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53766 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284088AbRLKWOI>; Tue, 11 Dec 2001 17:14:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.16 memory badness (reproducible)
Date: 11 Dec 2001 14:13:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9v60ef$ad2$1@cesium.transmeta.com>
In-Reply-To: <200112082142.fB8LgAb02089@orp.orf.cx> <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>
By author:    Hugh Dickins <hugh@veritas.com>
In newsgroup: linux.dev.kernel
> 
> I believe this error comes, not from a (genuine or mistaken) shortage
> of free memory, but from shortage or fragmentation of vmalloc's virtual
> address space.  Does patch below (to 2.4.17-pre4-aa1 since I think that's
> what you tried last; easily adaptible to other trees) doubling vmalloc's
> address space (on your 1GB machine or larger) make any difference?
> Perhaps there's a vmalloc leak and this will only delay the error.
> 
> Hugh
> 
> --- 1704aa1/arch/i386/kernel/setup.c	Tue Dec 11 15:22:53 2001
> +++ linux/arch/i386/kernel/setup.c	Tue Dec 11 19:01:37 2001
> @@ -835,7 +835,7 @@
>  /*
>   * 128MB for vmalloc and initrd
>   */
> -#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
> +#define VMALLOC_RESERVE	(unsigned long)(256 << 20)
>  #define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
>  #ifdef CONFIG_HIGHMEM_EMULATION
>  #define ORDER_DOWN(x)	((x >> (MAX_ORDER-1)) << (MAX_ORDER-1))
> 

Well, for one thing it will screw over just about every Linux boot
loader in existence if you are using an initrd.  You need my boot
protocol 2.03 patch *plus* a 2.03 compliant boot loader (e.g. SYSLINUX
1.65-pre2 or later) if you apply this change to a 1 GB or larger
machine.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
