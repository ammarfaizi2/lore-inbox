Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272847AbRIGUtX>; Fri, 7 Sep 2001 16:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272848AbRIGUtM>; Fri, 7 Sep 2001 16:49:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2569 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272847AbRIGUtF>; Fri, 7 Sep 2001 16:49:05 -0400
Subject: Re: K7/Athlon optimizations and Sacrifices to the Great Ones.
To: heinz@auto.tuwien.ac.at (Heinz Deinhart)
Date: Fri, 7 Sep 2001 21:52:27 +0100 (BST)
Cc: goemon@anime.net (Dan Hollis), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109071856530.6747-100000@xenon.auto.tuwien.ac.at> from "Heinz Deinhart" at Sep 07, 2001 07:03:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fSbz-0002Uv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did some trial and error modifications to mmx.c and found out
> that this one makes my athlons happy (but must admin i have
> no clue why). it seems to run stable now.
> 
> --- linux-2.4.9/arch/i386/lib/mmx.c	Tue May 22 19:23:16 2001
> +++ linux-2.4.9-ac6-hack/arch/i386/lib/mmx.c	Sat Sep  8 00:51:33 2001
> @@ -194,6 +194,9 @@
>  		: : "r" (from), "r" (to) : "memory");
>  		from+=64;
>  		to+=64;
> +	__asm__ __volatile__ (
> +		"  sfence \n" : :
> +	);
>  	}
>  	for(i=(4096-320)/64; i<4096/64; i++)
>  	{
> 

You are effectively continually stalling the processor so that the fast
streaming memory transfers dont occur. Instead you start, block, start,
block, ...

Alan
