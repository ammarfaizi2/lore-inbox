Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWEaLFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWEaLFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 07:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWEaLFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 07:05:21 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:4483 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964962AbWEaLFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 07:05:20 -0400
Date: Wed, 31 May 2006 15:04:59 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531110459.GA20551@2ka.mipt.ru>
References: <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net> <20060531020009.A1868@openss7.org> <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060531105814.GB7806@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 31 May 2006 15:05:02 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 02:58:18PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Wed, May 31, 2006 at 03:51:24AM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> > Evgeniy,
> > 
> > On Wed, 31 May 2006, Evgeniy Polyakov wrote:
> > > 2. Compared Jenkins hash with XOR hash used in TCP socket selection code.
> > > http://tservice.net.ru/~s0mbre/blog/2006/05/14#2006_05_14
> > 
> > Two problems with the comparison:
> > 
> >   Port numbers can be collected into a 32 bit register in network
> >   byte order directly from the TCP packet without taking two 16 bit
> >   values and shifting and or'ing them.
> 
> They are.
> 
> u32 ports;
> 
> ports = lport;
> ports <<= 16;
> ports |= fport;

Using network or host byte order does not affect hash distribution,
that shifting was coded to simulate other types of mixing ports,
which actually never showed different results.

> >   Worse: he folded the jenkins algorith result with
> > 
> >    h ^= h >> 16;
> >    h ^= h >> 8;
> > 
> >   Destroying the coverage of the function.
> 
> It was done to simulate socket code which uses the same folding.
> Leaving 32bit space is just wrong, consider hash table size with that
> index.
> 
> > I, for one, am not suprised that artifacts appeared in the comparison
> > as a result of this destruction of the coverage of the hashing function.
> 
> It is comparison of the approach used in TCP hashing code, it is not full 
> mathematical analysis. And in that case jenkins hash already not good. 
> I'm sure it can be tuned, but it does require a lot of iterations, while
> XOR one "just works".

-- 
	Evgeniy Polyakov
