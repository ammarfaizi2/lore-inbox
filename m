Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWFAGNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWFAGNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWFAGNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:13:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27792 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751375AbWFAGNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:13:08 -0400
Date: Thu, 1 Jun 2006 10:12:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601061234.GB28087@2ka.mipt.ru>
References: <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net> <20060531020009.A1868@openss7.org> <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531110459.GA20551@2ka.mipt.ru> <20060531130615.GA32362@2ka.mipt.ru> <20060531122955.B10147@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060531122955.B10147@openss7.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 01 Jun 2006 10:12:40 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 12:29:55PM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> Evgeniy,
> 
> On Wed, 31 May 2006, Evgeniy Polyakov wrote:
> > > > >   Worse: he folded the jenkins algorith result with
> > > > > 
> > > > >    h ^= h >> 16;
> > > > >    h ^= h >> 8;
> > > > > 
> > > > >   Destroying the coverage of the function.
> > > > 
> > > > It was done to simulate socket code which uses the same folding.
> > > > Leaving 32bit space is just wrong, consider hash table size with that
> > > > index.
> > 
> > Btw, that probably requires some clarification.
> > Since hash table size is definitely less than returned hash value, so
> > higher bits are removed, for that case above folding is done both in
> > XOR hash and my test case. 
> > It is possible to just remove higher bits, but fairly ditributed parts
> > being xored produce still fairly distributed value.
> 
> > > > >    h ^= h >> 16;
> > > > >    h ^= h >> 8;
> 
> This does not remove high order bits in either function.
> Your comparison results are simply invalid with these two lines in place.

It is hash function, but not function which creates index inside hash
table. Index is created by removing high order bits with (& 0xffff).

I've present the new simple code and test results which show
that folded and not folded Jenkins hashes _do_ produce _exactly_ the
same distribution.

I think I've already said that fairly distributed values being xored
produce still fairly distributed value, so parts of 32bit fairly
distributed hash after being xored with each other still produce fairly
distributed 32bit space.

> --brian

-- 
	Evgeniy Polyakov
