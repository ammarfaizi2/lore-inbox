Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSIYSOR>; Wed, 25 Sep 2002 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbSIYSOR>; Wed, 25 Sep 2002 14:14:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22542 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262046AbSIYSOQ>; Wed, 25 Sep 2002 14:14:16 -0400
Date: Wed, 25 Sep 2002 11:22:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
In-Reply-To: <20020925123223.16082@192.168.4.1>
Message-ID: <Pine.LNX.4.33.0209251120590.1817-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Benjamin Herrenschmidt wrote:
> --- 1.1/drivers/ide/ide-iops.c	Wed Sep 11 08:54:11 2002
> +++ edited/drivers/ide/ide-iops.c	Wed Sep 25 14:19:58 2002
> @@ -54,12 +54,20 @@
>  
>  static inline void ide_insw (u32 port, void *addr, u32 count)
>  {
> +#ifdef __BIG_ENDIAN
> +	insw(port, addr, count);
> +#else	
>  	while (count--) { *(u16 *)addr = IN_WORD(port); addr += 2; }
> +#endif	

If insw is correct on big-endian, then it sure as hell should be correct 
on little-endian. I don't understand why we wouldn't use insw on PC's, 
since it's smaller and much more traditional.

			Linus

