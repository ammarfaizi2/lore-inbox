Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbSKLKir>; Tue, 12 Nov 2002 05:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbSKLKir>; Tue, 12 Nov 2002 05:38:47 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:15942 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S266435AbSKLKip>; Tue, 12 Nov 2002 05:38:45 -0500
Date: Tue, 12 Nov 2002 21:40:38 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: David Lloyd <dlloyd@microbits.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Memory Errors (Debian Woody 2.4.18-bf2.4)
In-Reply-To: <20021112094813.602c2dbb.dlloyd@microbits.com.au>
Message-ID: <Pine.LNX.4.05.10211122130210.2446-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, 12 Nov 2002, David Lloyd wrote:

> 
> I am experiencing some strange behaviour with Debian Woody. I have
> attached a log as plain text and the output of dmesg.
> 
> I suspect it may be faulty RAM.

Nah, it's most likely not telling you anything like that.  Your log:

	Nov 12 09:08:41 lothlorien kernel: memory : ca174cd0
	Nov 12 09:08:41 lothlorien kernel: memory : 00000000
	Nov 12 09:08:41 lothlorien kernel: memory : ca174410
	Nov 12 09:08:42 lothlorien kdm[4949]: session start failed
	Nov 12 09:08:43 lothlorien kernel: memory : ca174cd0

The giveaway is the space before the colon.  Here's what I previously
posted on this issue:

===================================8<===================================
On Fri, 20 Sep 2002, Neale Banks wrote:
> 
> Date: Fri, 20 Sep 2002 09:15:27 +1000 (EST)
> From: Neale Banks <neale@lowendale.com.au>
> To: linux-kernel@vger.kernel.org
> Cc: Gustavo Lozano <glozano@noldata.com>
> Subject: [PATCH 2.(2|4)] agpgart_fe printk is too terse
> 
> 
> Appended patch against 2.4.20-pre4 fixes a (IMHO) way-too-terse printk in
> drivers/char/agp/agpgart_fe.c
> 
> Motivation is that when scrounging through syslog etc finding an entry
> that simply says "memory : <value>" leaves rather too much to the
> imagination (not to mention being interesting to grep out of the
> source).
> 
> This applies to 2.2 also (but has already been applied to 2.5).
> 
> Thanks,
> Neale.
> 
> --- linux-2.4.20-pre4/drivers/char/agp/agpgart_fe.c	Mon Aug 13 03:38:48 2001
> +++ linux-2.4.20-pre4-ntb/drivers/char/agp/agpgart_fe.c	Fri Sep 20 08:57:40 2002
> @@ -301,7 +301,7 @@
>  	agp_memory *memory;
>  
>  	memory = agp_allocate_memory(pg_count, type);
> -   	printk(KERN_DEBUG "memory : %p\n", memory);
> +   	printk(KERN_DEBUG "agp_allocate_memory: %p\n", memory);
>  	if (memory == NULL) {
>  		return NULL;
>  	}
> 
===================================8<===================================

> This occurs ONLY when I am in a KDE kdm managed X session and press
> ctrl+alt+f[1-6] to get to a virtual console. It's not always consistent
> but that's when it's most likely to happen.
> 
> X disappears from underneath me as well.

Probably an X issue that's not relevant here.

What's the video card?

HTH,
Neale.

