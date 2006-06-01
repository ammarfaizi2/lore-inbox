Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWFALGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWFALGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWFALGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:06:51 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36328 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965074AbWFALGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:06:50 -0400
Date: Thu, 1 Jun 2006 15:06:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601110625.GA15069@2ka.mipt.ru>
References: <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <20060601001825.A21730@openss7.org> <20060601063012.GC28087@2ka.mipt.ru> <20060601004608.C21730@openss7.org> <20060601070136.GA754@2ka.mipt.ru> <20060601011125.C22283@openss7.org> <20060601083805.GB754@2ka.mipt.ru> <20060601042457.B25584@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060601042457.B25584@openss7.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 01 Jun 2006 15:06:28 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 04:24:57AM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> For purely random numbers you could amplify thermal noise off an
> open transitor junction (the audiofile's white noise generator)
> and feed it into an analog to digital converter.

It is also possible to look into window and count how many times sun
hides and shines... It is quite cloudy in Moscow though.

As Acrypto asynchronous crypto layer author I can use different hardware
crypto accelerators, but it is a topic for another discussion.

> > 
> > I've run it with following source ip/port selection algo:
> > 	if (++sport == 0) {
> > 		saddr++;
> > 		sport++;
> > 	}
> > 
> > Starting IP was 1.1.1.1 and sport was 1.
> > Destination IP and port are the same 192.168.0.1:80
> > 
> > Jenkins hash started to show different behaviour:
> > it does not have previous artefacts, but instead it's dispersion is
> > _much_ wider than in XOR case.
> 
> Aha!  But perhaps this is too easy a data set.  HTTP clients typically
> dynamically allocate port numbers within a range and source address
> are typically not less than a certain value.  That is why I suggested
> something like:
> 
>        sport = 10000;
>        saddr = 0x0a000000;  /* 10.0.0.0 */
> 
>        ...
> 
>        if (++sport == 16000) {
> 	       sport = 10000;
> 	       saddr++;
>        }
> 
> If this shows artifacts worse than XOR then more realistic gaps in the
> input values will cause artifacts.

Specially for you :)
It does not have artifacts, but it's dispersion is wider than XOR one.
_Much_ wider, which tends to creation of some specially crafted source
distribution which ends up in totally broken fairness.
As usual folded and not folded versions behave exactly the same.

> > With following ip/port selection algo:
> > 	if (++sport == 0) {
> > 		//saddr++;
> > 		sport += 123;
> > 	}
> > 
> > I see yet another jenkins artefacts, but again different from previous
> > two.
> 
> Adding primes.  Again, the arithmetic series of primes might auto-correlate
> with the Jenkins function.  Or it plain might not like gaps.
>

I want to confirm three things and one state:
1. Jenkins hash has some unacceptible artefacts in some source
address/port distributions, no matter if it has some law embedded or it
is (pseudo)-random set. 

If there are bugs, bugs exist.

2. If it does not have artifacts it has unacceptible dispersion.

3. It is 3 times slower than XOR one (28 seconds for XOR for 2^29
iterations vs. 101 seconds jhash nonfolded and 109 jhash folded on my AMD64
3500+ 2.2 Ghz desktop).

4. I believe it can be tuned or has some gaps inside refactoring logic,
which can be fixed, but as is it can not be used for fair hash creation.

-- 
	Evgeniy Polyakov
