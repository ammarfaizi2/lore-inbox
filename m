Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSGaPtZ>; Wed, 31 Jul 2002 11:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318391AbSGaPtZ>; Wed, 31 Jul 2002 11:49:25 -0400
Received: from dsl-213-023-021-098.arcor-ip.net ([213.23.21.98]:64677 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318389AbSGaPtY>;
	Wed, 31 Jul 2002 11:49:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "J.A. Magallon" <jamagallon@able.es>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19rc3aa4
Date: Wed, 31 Jul 2002 17:54:37 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020730060218.GB1181@dualathlon.random> <20020730143657.GA2224@junk.cps.unizar.es>
In-Reply-To: <20020730143657.GA2224@junk.cps.unizar.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Zvo5-0008KY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 July 2002 16:36, J.A. Magallon wrote:
> BTW, are you aware of this in -aa ? I need this patch:
> 
> --- linux/include/asm-i386/processor.h   Fri Jul 19 00:37:45 2002
> +++ linux/include/asm-i386/processor.h~  Fri Jul 19 00:38:48 2002
> @@ -401,7 +401,7 @@
>  	{ [0 ... 7] = 0 },	/* debugging registers */	\
>  	0, 0, 0,						\
>  	{ { 0, }, },		/* 387 state */			\
> -	0,0,0,0,0,0,						\
> +	0,0,0,0,0,						\
>  	0,{~0,}			/* io permissions */		\
>  }
>  
> to shut up gcc and match the struct definition:
> 
> /* floating point info */
>     union i387_union    i387;
> /* virtual 86 mode info */
>     struct vm86_struct  * vm86_info;
>     unsigned long       screen_bitmap;
>     unsigned long       v86flags, v86mask, saved_esp0;
> /* IO permissions */
>     int     ioperm;
>     unsigned long   io_bitmap[IO_BITMAP_SIZE+1];
> 
> Coud be serious to have io_bitmap == 0 instead of == ~0 ??

It should be written "= {.io_bitmap = {~0}}" but that's still
bogus: only the first array element gets the ones, probably not 
what was intended.

-- 
Daniel
