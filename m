Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274216AbRISVnj>; Wed, 19 Sep 2001 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274200AbRISVnT>; Wed, 19 Sep 2001 17:43:19 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:56075 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S274216AbRISVnK>; Wed, 19 Sep 2001 17:43:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 17:43:30 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0109191635310.29593-100000@terbidium.openservices.net>
In-Reply-To: <Pine.LNX.4.33.0109191635310.29593-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010919214317Z274216-760+14235@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 September 2001 16:40, Ignacio Vazquez-Abrams wrote:
> On Wed, 19 Sep 2001, Ignacio Vazquez-Abrams wrote:
> > On Wed, 19 Sep 2001, Ignacio Vazquez-Abrams wrote:
> > > From an Athlon 1050/KT133 (middle 3 of 5):
> > >
> > > Clear:
> > > warm up run: 16653.33
> > > 2.4 non MMX: 10803.33
> > > 2.4 MMX fallback: 10576.67
> > > 2.4 MMX version: 9824.33
> > > faster_copy: 4416.67
> > > even_faster: 4316.67
> > >
> > > Copy:
> > > warm up run: 15268.33
> > > 2.4 non MMX: 23765.33
> > > 2.4 MMX fallback: 23629.33
> > > 2.4 MMX version: 15316.67
> > > faster_copy: 9352.00
> > > even_faster: 9333.33
> >
> > Please note that the 'faster_copy' under clear is in fact
> > 'faster_clear_page'. It got messed up in the post-processing of the
> > results.
>
> After Athlon patch:
>
> clear_page() tests
> clear_page function 'warm up run'        took 17860 cycles per page
> clear_page function '2.4 non MMX'        took 11805 cycles per page
> clear_page function '2.4 MMX fallback'   took 11777 cycles per page
> clear_page function '2.4 MMX version'    took 12003 cycles per page
> clear_page function 'faster_clear_page'  took 4416 cycles per page
> clear_page function 'even_faster_clear'  took 4315 cycles per page
>
> copy_page() tests
> copy_page function 'warm up run'         took 14930 cycles per page
> copy_page function '2.4 non MMX'         took 23337 cycles per page
> copy_page function '2.4 MMX fallback'    took 23314 cycles per page
> copy_page function '2.4 MMX version'     took 20293 cycles per page
> copy_page function 'faster_copy'         took 9159 cycles per page
> copy_page function 'even_faster'         took 9071 cycles per page
>
> This is with 2.4.9-ac12-preempt1 in both cases and niced to -20. Subsequent
> runs are very similar.

this is with 2.4.9-ac12 non preempt and without the patch on an athlon 850 
k7-2 . niced to -20.  It was compiled with gcc 3.0.2  no CFLAGS

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 21392 cycles per page
clear_page function '2.4 non MMX'        took 14020 cycles per page
clear_page function '2.4 MMX fallback'   took 14778 cycles per page
clear_page function '2.4 MMX version'    took 15416 cycles per page
clear_page function 'faster_clear_page'  took 4396 cycles per page
clear_page function 'even_faster_clear'  took 4165 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 19788 cycles per page
copy_page function '2.4 non MMX'         took 23562 cycles per page
copy_page function '2.4 MMX fallback'    took 23174 cycles per page
copy_page function '2.4 MMX version'     took 20422 cycles per page
copy_page function 'faster_copy'         took 10132 cycles per page
copy_page function 'even_faster'         took 9449 cycles per page

Using optimizations with this code actually slows it down for me.  perhaps 
this means something.  When using asm code, perhaps it's better to not use 
any compiler flags in the kernel config.  The patch is still needed of course 
to stop user programs from crashing the system, but maybe in the kernel for 
asm sources you shouldn't try any compiler flags and see if that increases 
performance.  this could all be a gcc 3.x'ism though.  
