Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGBLKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGBLKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUGBLHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:07:49 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:32664 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262114AbUGBLEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 07:04:47 -0400
Date: Fri, 2 Jul 2004 13:04:46 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: perfctr questions
Message-ID: <20040702110446.GA5954@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200407021021.i62ALBD9015819@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407021021.i62ALBD9015819@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 12:21:11PM +0200, Mikael Pettersson wrote:

> Should the kernel driver directly support some user-friendly
> model of the counters? No it should not, for several reasons:

We are in violent agreement - however, I do find that for a product to be
properly evaluated and to receive testing coverage, it is vital that the
learning curve not be this steep.

Right now, PAPI does not build for perfctr 2.7.3 (at least for me), nor do
Bryan's modifications. Furthermore, I had to reverse engineer a lot of
details to get my own things working.

I also read the AMD documentation and it is worthless and spends all of
three pages on the performance counters.

The good news however is that things do appear to work. What I'll do is whip
up a very small bootstrapping document. I'm sure PAPI is fine but for
many/my purposes it is overkill, I'd like for people to be able to
understand enough of perfctrs so they can start using them. 

Like this:

  CacheMeter cm;
  for(unsigned int n=0;n<iterations;++n) {
    c=area[(n*64)%limit];
    total+=c; // force gcc to actually look at it
  }
  cm.print();

Will do 100000000 reads over range of 10000000 bytes
Data cache accesses:	100109359
Data cache misses:	99977036
L2 hit, L1 miss:	26395
L2 miss, L1 miss:	1540114

Will do 100000000 reads over range of 1000 bytes
Data cache accesses:	100047618
Data cache misses:	8523
L2 hit, L1 miss:	0
L2 miss, L1 miss:	664

Code on htp://ds9a.nl/tmp/cmeter.cc - will only work on AMD and is in C++.

People with AMD knowledge are kindly invited to elaborate on the meaning of
'cache miss' v 'l2 and l2 miss' :-)

Mikael, thanks, this stuff is powerful and it will enable people to write
better code!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
