Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262794AbSI2QSr>; Sun, 29 Sep 2002 12:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbSI2QSr>; Sun, 29 Sep 2002 12:18:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50139 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262794AbSI2QSq>; Sun, 29 Sep 2002 12:18:46 -0400
Date: Sun, 29 Sep 2002 18:24:02 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andi Kleen <ak@muc.de>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
In-Reply-To: <20020929152731.GA10631@averell>
Message-ID: <Pine.NEB.4.44.0209291821130.8188-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Andi Kleen wrote:

>...
> --- linux/include/linux/kernel.h	2002-09-29 16:54:34.000000000 +0200
> +++ linux-2.5.39-work/include/linux/kernel.h	2002-09-29 17:20:52.000000000 +0200
> @@ -47,6 +47,16 @@ void __might_sleep(char *file, int line)
>  #define might_sleep() do {} while(0)
>  #endif
>
> +#if __GNUC__ >= 3 && __GNUC_MINOR__ >= 1
> +/* Function allocates new memory and return cannot alias with anything */
> +#define malloc_function __attribute__((malloc))
> +/* Never inline */
> +#define noinline __attribute__((noinline))
> +#else
> +#define malloc_function
> +#define noinline
> +#endif
> +
>...


Why did you put it in kernel.h and not in compiler.h?


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


