Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTAWXRB>; Thu, 23 Jan 2003 18:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTAWXRB>; Thu, 23 Jan 2003 18:17:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29447 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267371AbTAWXQ5>; Thu, 23 Jan 2003 18:16:57 -0500
Date: Thu, 23 Jan 2003 18:22:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Brice Goglin <bgoglin@ens-lyon.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: copy_from_user broken on i386 since 2.5.57
In-Reply-To: <20030122104928.769d72da.akpm@digeo.com>
Message-ID: <Pine.LNX.3.96.1030123182133.9688A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Andrew Morton wrote:

> Brice Goglin <bgoglin@ens-lyon.fr> wrote:
> >
> > Hi,
> > 
> > Trying to compile a very very simple module for 2.5,
> > I got an error from gcc saying that assembly code
> > is incorrect.
> > This problem appeared in 2.5.57 and is still here
> > in 2.5.59.
> > I only tried on i386.
> > 
> > Here's a very simple example code :
> > 
> > #define __KERNEL__
> > #define MODULE
> > #include "linux/module.h"
> > #include "asm/uaccess.h"
> > 
> > int func(void *to, const void *from) {
> >   return __copy_from_user(to, from, 1);
> > }
> > 
> > 
> > Here's gcc report :
> > 
> > mp760:~/tmp% gcc user.c -c -o user.o -Ipath_to_2.5.57/include
> > /tmp/cceAbcRd.s: Assembler messages:
> > /tmp/cceAbcRd.s:120: Error: `%al' not allowed with `movl'
> > /tmp/cceAbcRd.s:124: Error: `%al' not allowed with `xorl'
> > /tmp/cceAbcRd.s:209: Warning: using `%eax' instead of `%ax' due to `l' suffix
> > /tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to `l' suffix
> > /tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to `l' suffix
> 
> Add `-O2' to the compiler switches.
> 
> No, I don't know either ;)

So, does this actually fix the problem or simply optimize the suspect code
out of existance until some later date?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

