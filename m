Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319093AbSIDICk>; Wed, 4 Sep 2002 04:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSIDICj>; Wed, 4 Sep 2002 04:02:39 -0400
Received: from [62.40.73.125] ([62.40.73.125]:30634 "HELO Router")
	by vger.kernel.org with SMTP id <S319093AbSIDICi>;
	Wed, 4 Sep 2002 04:02:38 -0400
Date: Tue, 3 Sep 2002 00:24:05 +0200
From: Jan Hudec <bulb@cimice.maxinet.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020902222405.GA30964@vagabond>
Mail-Followup-To: Jan Hudec <bulb@cimice.maxinet.cz>,
	linux-kernel@vger.kernel.org
References: <20020901105643.GH32122@louise.pinerecords.com> <20020901.035749.37156689.davem@redhat.com> <20020901112856.GL32122@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901112856.GL32122@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 01:28:56PM +0200, Tomas Szepe wrote:
> >    From: Tomas Szepe <szepe@pinerecords.com>
> >    Date: Sun, 1 Sep 2002 12:56:43 +0200
> > 
> >    2.4.20-pre5: prevent sparc32's atomic_read() from possibly discarding
> >    const qualifiers from pointers passed as its argument.
> >    
> >    -static __inline__ int atomic_read(atomic_t *v)
> >    +static __inline__ int atomic_read(const atomic_t *v)
> > 
> > So the atomic_t is const is it?  That's news to me.
> > 
> > I think you mean something like "atomic_t const * v" which means the
> > pointer is constant, not the value.
> 
> Precisely.
> 

No, you don't. Having the pointer constant means the symbolic argument
can't be changed inside the function. But it means nothing at all to the
caller, because the caller's variable itself is never changed by the
call. 

> 
> diff -u linux-2.4.20-pre5/include/asm-sparc/atomic.h linux-2.4.20-pre5.n/include/asm-sparc/atomic.h
> --- linux-2.4.20-pre5/include/asm-sparc/atomic.h	2001-11-08 17:42:19.000000000 +0100
> +++ linux-2.4.20-pre5.n/include/asm-sparc/atomic.h	2002-09-01 12:29:36.000000000 +0200
> @@ -35,7 +35,7 @@
>  
>  #define ATOMIC_INIT(i)	{ (i << 8) }
>  
> -static __inline__ int atomic_read(atomic_t *v)
> +static __inline__ int atomic_read(atomic_t const *v)
>  {
>  	int ret = v->counter;
-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
