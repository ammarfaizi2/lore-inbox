Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286421AbRLTWaI>; Thu, 20 Dec 2001 17:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286422AbRLTW35>; Thu, 20 Dec 2001 17:29:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:24972 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286421AbRLTW3p>; Thu, 20 Dec 2001 17:29:45 -0500
Message-Id: <200112202229.fBKMTXq06694@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Date: Thu, 20 Dec 2001 14:29:32 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0112192154190.19321-100000@penguin.transmeta.com> <Pine.LNX.4.33.0112201405550.6212-100000@localhost.localdomain> <m3y9jxesd3.fsf@averell.firstfloor.org>
In-Reply-To: <m3y9jxesd3.fsf@averell.firstfloor.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, <mingo@elte.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 09:03 am, you wrote:
> mingo@elte.hu (Ingo Molnar) writes:
> > On Wed, 19 Dec 2001, Linus Torvalds wrote:
> > > > Marcello and Linus, please apply.
> > >
> > > Can you give a rough description of what kinds of arrays this will
> > > impact, just out of curiosity. Ie do we talk about "5kB more memory in
> > > order to avoid problems", or are we talking about something
> > > noticeable..
> > >
> > > 		Linus "too lazy to grep" Torvalds
> >
> > the change is OK, it's about +3K RAM used, on SMP kernels.
>
> hmm, I come more to 11K (most of it in mp_irqs)
> ... which could be easily allocated with the bootmem allocator at parse
> time.
>
> -Andi

Thanks to all who replied.  My rationale for simply increasing the size of 
static arrays was to have a minimum impact on 2.4, as well as to make 
something that Cannot Fail(TM).  If you like, I could make one for 2.5 that 
would do an initial scan of the MPS table, allocate the arrays using the 
bootmem allocator, then go about its business as usual.  (Special offer for a 
limited time only!  mpc_* array overflow checking added at NO EXTRA CHARGE!!  
;^)

The catch with bootmem allocation is that it only allocates in pages (unless 
wli's new bootmem allocator is adopted).  So, expect some extra memory to be 
lost to internal fragmentation anyway.

Another suggestion through private mail was to make MAX_MP_BUSSES a tunable 
config parameter.  I didn't know about that.  Early boot stuff should work 
without fuss, not rely on config tweaks.  At the very least, I'd have to add 
array overflow checking, because this crashes before the console is opened or 
kdb is initialized.  Silent crashes like that are bad news.

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

