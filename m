Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTAXD3N>; Thu, 23 Jan 2003 22:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267523AbTAXD3N>; Thu, 23 Jan 2003 22:29:13 -0500
Received: from imap.gmx.net ([213.165.65.60]:18140 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267513AbTAXD3L>;
	Thu, 23 Jan 2003 22:29:11 -0500
Message-Id: <5.1.1.6.2.20030124035109.00ce15f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 24 Jan 2003 04:35:04 +0100
To: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@digeo.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: copy_from_user broken on i386 since 2.5.57
Cc: Brice Goglin <bgoglin@ens-lyon.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030123182133.9688A-100000@gatekeeper.tmr.co
 m>
References: <20030122104928.769d72da.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:22 PM 1/23/2003 -0500, Bill Davidsen wrote:
>On Wed, 22 Jan 2003, Andrew Morton wrote:
>
> > Brice Goglin <bgoglin@ens-lyon.fr> wrote:
> > >
> > > Hi,
> > >
> > > Trying to compile a very very simple module for 2.5,
> > > I got an error from gcc saying that assembly code
> > > is incorrect.
> > > This problem appeared in 2.5.57 and is still here
> > > in 2.5.59.
> > > I only tried on i386.
> > >
> > > Here's a very simple example code :
> > >
> > > #define __KERNEL__
> > > #define MODULE
> > > #include "linux/module.h"
> > > #include "asm/uaccess.h"
> > >
> > > int func(void *to, const void *from) {
> > >   return __copy_from_user(to, from, 1);
> > > }
> > >
> > >
> > > Here's gcc report :
> > >
> > > mp760:~/tmp% gcc user.c -c -o user.o -Ipath_to_2.5.57/include
> > > /tmp/cceAbcRd.s: Assembler messages:
> > > /tmp/cceAbcRd.s:120: Error: `%al' not allowed with `movl'
> > > /tmp/cceAbcRd.s:124: Error: `%al' not allowed with `xorl'
> > > /tmp/cceAbcRd.s:209: Warning: using `%eax' instead of `%ax' due to 
> `l' suffix
> > > /tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to 
> `l' suffix
> > > /tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to 
> `l' suffix
> >
> > Add `-O2' to the compiler switches.
> >
> > No, I don't know either ;)
>
>So, does this actually fix the problem or simply optimize the suspect code
>out of existance until some later date?

Compiler bug?  With -O2, gcc-2.95.3 emits movb and xorb at the same spot.

gcc-3.2.1 doesn't have a problem with that code optimized or not... it flat 
refuses to suck up any inline assembly unless you use at least -O 
-finline-limit=1580.  (why 1580?)

         -Mike

