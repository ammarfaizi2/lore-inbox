Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132453AbRAGN63>; Sun, 7 Jan 2001 08:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRAGN6T>; Sun, 7 Jan 2001 08:58:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47745 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132453AbRAGN6D>; Sun, 7 Jan 2001 08:58:03 -0500
Date: Sun, 7 Jan 2001 08:58:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: posix_types.h  error
In-Reply-To: <Pine.Linu.4.10.10101070526410.1227-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.3.95.1010107084031.25234A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Mike Galbraith wrote:

> On Sat, 6 Jan 2001, Richard B. Johnson wrote:
> 
> Hi Richard,
> 
> > There is an error at line 80 in linux-2.4.0/include/asm/posix_types.h
> > which prevents source-code from being compiled using the new C compiler
> > that I was forced to install in order to build the new kernel.
> 
> Hmm.. line 80 is the last line in the file, an #endif.
> 
> What do you mean by 'forced to install..'?  gcc-2.95.2, gcc-2.95.2.1
> and gcc-2.97 snapshots will build 2.4.0 (minus netfilter empty struct
> initialzer glitchies).
> 
> > 		gcc 2.95.3
> 
I have been using gcc 2.8.1. The Linux source won't compile using
it because of line 77, linux/init/main.c

Therefore I downloaded the source of the compiler listed in
linux/Documentation/Changes, line 266, from the site listed.
I built and installed it.

The kernel compiles without errors, but simple applications don't.
The version number is what the installed gcc spews  even though the
alleged version number is (hold your hat) gcc-2.95.3-0.20000503.1

Now, if a user can't follow the documentation and end up with
something that works, we have a problem.


> (Only exists at mdk afaik.. RedHat didn't get enough flak?;)
> 

RedHat 'cheats' and supplies two compilers, one for the kernel and
one for whatever.


> > #include <stdlib.h>
> > 
> > 
> > main()
> > {
> >     fd_set x;
> > 
> >     FD_ZERO(&x);
> > }
> > 
> > # gcc -c -o xxx.o xxx.c
> > xxx.c: In function `main':
> > xxx.c:11: Invalid `asm' statement:
> > xxx.c:11: fixed or forbidden register 2 (cx) was spilled for class CREG.
> > # vi /usr/include/asm/posix_types.h
> > #ifndef __ARCH_I386_POSIX_TYPES_H
> > #define __ARCH_I386_POSIX_TYPES_H
> > 
> > 
> > 
> > 
> > [Snipped...]
> > 
> > #define __FD_ZERO(fdsetp) \
> > 
> > exit
> > Script done on Sat Jan  6 22:19:03 2001
> > 
> > Since these inline asm statements no longer use register names, I
> > don't know how to fix them. One of life's little mystries is how
> > previously readable code got into this shape.
> 
> <g>  Agreed!  That code is terribly unreadable.. down right invisible.
> 
> Seriously though, the constraints look fine to me (and the register
> name is there in the output constraint).  I'd say you have a busted
> compiler.  None of the named compilers gripe.
>

None of the named compilers gripe? Where, prey tell, do I get the source-
code of a compiler that works? The only source provided in the site
listed in the Documentation does not.

[Snipped...]

Oh...  `vi` doesn't count lines properly when executed from script.
However, it wasn't too far off.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
