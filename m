Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266915AbSK2ABl>; Thu, 28 Nov 2002 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266916AbSK2ABl>; Thu, 28 Nov 2002 19:01:41 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:16565 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S266915AbSK2ABj>;
	Thu, 28 Nov 2002 19:01:39 -0500
Date: Fri, 29 Nov 2002 01:08:59 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19/20, 2.5 missing P4 ifdef ?
Message-ID: <20021129000859.GA2027@werewolf.able.es>
References: <4.3.2.7.2.20021128151157.00b522c0@pop.t-online.de> <20021128142437.GA23664@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021128142437.GA23664@suse.de>; from davej@codemonkey.org.uk on Thu, Nov 28, 2002 at 15:24:37 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.28 Dave Jones wrote:
>On Thu, Nov 28, 2002 at 03:17:53PM +0100, Margit Schubert-While wrote:
> > Just noticed this in "include/asm-i386/processor.h" :
> > 
> > --- snip ---
> > /* Prefetch instructions for Pentium III and AMD Athlon */
> > #ifdef  CONFIG_MPENTIUMIII
> > #define ARCH_HAS_PREFETCH
> > extern inline void prefetch(const void *x)
> > {
> >         __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
> > }
> > #elif CONFIG_X86_USE_3DNOW
> > --- end snip ---
> > 
> > The P4 has SSE and prefetch or no ?
>
>It does. You seem to have found a bug.
>

Two questions:
- I am trying to use gcc's __builtin_prefetch, and it is able to
  spit different prefetch instructions depending on 'temporal
  locality' of the data:
	prefetchnta, prefetcht2, prefetcht1, prefetcht0
temp-loc:    0           1         2           3
  0 means you can just discard after r or w, and 3 means you
  are really interested in data lasting in cache.
  Do not know if the use of prefetch in kernel is extensive,
  but perhaps this is something to investigate...

- PII also supports the prefetches. Is it worth to add it ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc4-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
