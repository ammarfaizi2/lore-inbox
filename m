Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSKFAFn>; Tue, 5 Nov 2002 19:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265404AbSKFAFn>; Tue, 5 Nov 2002 19:05:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38153 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265402AbSKFAFf>; Tue, 5 Nov 2002 19:05:35 -0500
Date: Tue, 5 Nov 2002 19:11:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.45: gcc 3.2 aligns everything to 16 bytes when I compile for 486
In-Reply-To: <200211031122.gA3BMYp27801@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.3.96.1021105190534.20035D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Denis Vlasenko wrote:

> I'm compiling 2.5.45 for 486.
> 
> For example, exit.c got compiled with this command:
> 
> gcc -v -Wp,-MD,kernel/.exit.o.d -D__KERNEL__ -Iinclude -Wall \
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 \
> -march=i486 -Iarch/i386/mach-generic -nostdinc -iwithprefix include \
> -DKBUILD_BASENAME=exit -c -o zz25.o kernel/exit.c
> 
> Whereas for 2.4, command is different:
> 
> gcc -v -D__KERNEL__ -Iinclude -Iarch/i386/mach-generic \
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing \
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386 -nostdinc \
> -iwithprefix include -DKBUILD_BASENAME=exit -c -o zz24.o kernel/exit.c
> 
> (commands slightly adapted to actually execute in 2.5 tree and
> don't destroy exit.o)
> 
> As you can see, the difference is in -march=.
> 2.5 compiles for 486. I have nothing against 486, but
> gcc 3.x got nasty habit of aligning functions and sometimes
> *even loops* to 16 bytes. Result:

>From memory that's to handle cache line length. I seem to remember back in
the 486 days setting my flags explicitly for anything which might be the
target of a branch. However, my recollection is that things were put on a
quadbyte, not position 16.

You can set the placement of loops, functions, and something else to be
mod any power of two, I believe.

I still run routers on one 486 and a boatload of Cyrix and similar clones.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

