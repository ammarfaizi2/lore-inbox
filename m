Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSEIQwH>; Thu, 9 May 2002 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313907AbSEIQwG>; Thu, 9 May 2002 12:52:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:49383 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313906AbSEIQwF>; Thu, 9 May 2002 12:52:05 -0400
Date: Thu, 9 May 2002 18:47:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marc-Christian Petersen <mcp@linux-systeme.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with param.h/time.h/timex.h
In-Reply-To: <200204032254.g33MsudC028678@codeman.linux-systeme.org>
Message-ID: <Pine.NEB.4.44.0205091841490.19321-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Marc-Christian Petersen wrote:

> Hi there,
>
> i have a strange problem, i don't understand!
>
> In include/asm-i386/param.h i have the following:
>
> #ifndef HZ
> #ifdef CONFIG_100HZ
> #define HZ 100
> #warning Just an info: 100HZ
>...
> #endif
> #endif
>
> If i do make bzImage i get the following error:
>
> /usr/src/linux-2.4.18/include/asm/param.h:7: warning: #warning Just an info:
> 100HZ
> cc  -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno
> -common -pipe -mpreferred-stack-boundary=2 -march=i686
> -DKBUILD_BASENAME=panic  -DEXPORT_SYMTAB -c panic.c
> In file included from /usr/src/linux-2.4.18/include/linux/sched.h:14,
>                  from panic.c:11:
>
> /usr/src/linux-2.4.18/include/linux/timex.h:78: #error You lose.
>...
> So, all the files have an include to asm/param.h, where HZ is defined. The
> warning defined in param.h is also printed out, but why i got those
> errors?!?! Maybe any have a clue :)

The compilation output already shows that HZ wasn't set while compiling
panic.c (there's none of your "Just an info" messages).

Most likely you've forgotten to add a

  #include <linux/config.h>

to your modified param.h and therefore none of your custom CONFIG_*HZ is
defined when the compiler goes through param.h.

> Many thnx!
>
> Please CC, i am not subscribed to the lkml!

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


