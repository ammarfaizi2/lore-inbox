Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272753AbRILLXD>; Wed, 12 Sep 2001 07:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272763AbRILLWx>; Wed, 12 Sep 2001 07:22:53 -0400
Received: from t2.redhat.com ([199.183.24.243]:3322 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272753AbRILLWq>; Wed, 12 Sep 2001 07:22:46 -0400
Message-ID: <3B9F4597.B10E428E@redhat.com>
Date: Wed, 12 Sep 2001 12:23:03 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6.4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
In-Reply-To: <E15goos-0002le-00@the-village.bc.nu>
	 <9184118686.20010912095919@port.imtp.ilyichevsk.odessa.ua>
	 <3B9F3E4B.AB5E1D12@scali.no> <1715812347.20010912140853@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA wrote:

> SP> Well, not necessarily. It might be that data just hasn't "arrived" yet because
> SP> of the movntq instruction.

this is wrong; the CPU _internal_ view of the data is always consistent,
regardless of movntq vs movq.
It's only the EXTERNAL view that is slightly different. "sfence" takes
care of syncing that.

 
> So why it is oopses then?
> Also, we don't want this data to arrive late or whatever.
> fast_copy_page must copy page (make it so that memcpy()==0).
> If it does not, it is too much "optimized".

It does; but if you read it back from memory and is corrupted, your
chipset corrupted it.
 
> SP> One thing that also puzzels me is that my is the fast_copy_page() routine laid
> SP> out like this :

[snip]

A better way to do it is to bencmark several routines at
> startup time and pick the best one. It is done now
> for RAID xor'ing routine.

I benchmarked several versions, see the testprogram at
http://www.fenrus.demon.nl/athlon.c

The interleaved one is faster on athlons because it seems to help AMD's
register aliasing logic
to operate better....

Anyway, since this code works for like 99% of the machines, and only 1%
seems to be affected, it really really really looks like a hardware bug.
This is also more or less proven by the reports that certain
biosversions "break" working setups by doing things to the via chipset
that make it break....

Greetings,
   Arjan van de Ven
