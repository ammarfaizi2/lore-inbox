Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271863AbRH1R3s>; Tue, 28 Aug 2001 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271862AbRH1R3m>; Tue, 28 Aug 2001 13:29:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2433 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271860AbRH1R3G>; Tue, 28 Aug 2001 13:29:06 -0400
Date: Tue, 28 Aug 2001 13:29:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: Roman Zippel <zippel@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <je4rqsdv4z.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.3.95.1010828132756.16020A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2001, Andreas Schwab wrote:

> Roman Zippel <zippel@linux-m68k.org> writes:
> 
> |> Hi,
> |> 
> |> Linus Torvalds wrote:
> [...]
> |> > You just fixed the "re-use arguments" bug - which is a bug, but doesn't
> |> > address the fact that most of the min/max bugs are due to the programmer
> |> > _indending_ a unsigned compare because he didn't even think about the
> |> > type.


#if 0
If the comparison was made unsigned, cast to the largest natural
value on the target, while keeping the types and sizes of the
input variables the same, this macro does about what 99.9999999 percent
of what everybody wants:
#endif

#include <stdio.h>

#define min(a,b) ((size_t)(a) < (size_t)(b) ? (a) : (b))

int main()
{
    printf("%d\n", min(1,2));
    printf("%d\n", min(-1,2));
    printf("%d\n", min(0xffffffff,3));
    printf("%d\n", min(0x8000,4));
    printf("%d\n", min(0x7fff,5));
    printf("%d\n", min(0x80000000,6));
    printf("%d\n", min(0x7fffffff,7));

    printf("%ld\n", min(1L,2L));
    printf("%ld\n", min(-1L,2L));
    printf("%ld\n", min(0xffffffff,3L));
    printf("%ld\n", min(0x8000,4L));
    printf("%ld\n", min(0x7fff,5L));
    printf("%ld\n", min(0x80000000,6L));
    printf("%ld\n", min(0x7fffffff,7L));

    printf("%lu\n", min(1L,2LU));
    printf("%lu\n", min(-1L,2LU));
    printf("%lu\n", min(0xffffffff,3LU));
    printf("%lu\n", min(0x8000,4LU));
    printf("%lu\n", min(0x7fff,5LU));
    printf("%lu\n", min(0x80000000,6LU));
    printf("%lu\n", min(0x7fffffff,7LU));

    printf("%d\n", min(-1, -2));
    printf("%d\n", min(-1, 0));
    printf("%p\n", min((void *)0x80000000, (void *)0x7fffffff));
    return 0;
}



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


