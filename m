Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWFASkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWFASkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWFASkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:40:14 -0400
Received: from gw.openss7.com ([142.179.199.224]:52401 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S965112AbWFASkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:40:11 -0400
Date: Thu, 1 Jun 2006 12:40:10 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601124010.C554@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <20060601001825.A21730@openss7.org> <20060601063012.GC28087@2ka.mipt.ru> <20060601004608.C21730@openss7.org> <20060601070136.GA754@2ka.mipt.ru> <20060601011125.C22283@openss7.org> <20060601083805.GB754@2ka.mipt.ru> <20060601042457.B25584@openss7.org> <20060601110625.GA15069@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601110625.GA15069@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Thu, Jun 01, 2006 at 03:06:26PM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Thu, 01 Jun 2006, Evgeniy Polyakov wrote:

I think the sun shines more in Moscow than in Edmonton, so it is not
so random. ;)

> 
> Specially for you :)

Thank you for being so gracious and patient with me.

> It does not have artifacts, but it's dispersion is wider than XOR one.
> _Much_ wider, which tends to creation of some specially crafted source
> distribution which ends up in totally broken fairness.
> As usual folded and not folded versions behave exactly the same.
> 
> > > With following ip/port selection algo:
> > > 	if (++sport == 0) {
> > > 		//saddr++;
> > > 		sport += 123;
> > > 	}
> > > 
> > > I see yet another jenkins artefacts, but again different from previous
> > > two.
> > 
> > Adding primes.  Again, the arithmetic series of primes might auto-correlate
> > with the Jenkins function.  Or it plain might not like gaps.
> >
> 
> I want to confirm three things and one state:
> 1. Jenkins hash has some unacceptible artefacts in some source
> address/port distributions, no matter if it has some law embedded or it
> is (pseudo)-random set. 
> 
> If there are bugs, bugs exist.

True, artifacts appeared even in the basic arithmetic sequence of
primes.  It is quite possible that a large set of natural sequences
might cause artifacts.

> 
> 2. If it does not have artifacts it has unacceptible dispersion.

This is likely due to the relatively small sample sets; however, real
experienced data sets would be very small compared to the widest
possible set and might also contain structured gaps.

> 
> 3. It is 3 times slower than XOR one (28 seconds for XOR for 2^29
> iterations vs. 101 seconds jhash nonfolded and 109 jhash folded on my AMD64
> 3500+ 2.2 Ghz desktop).

Yes, it is slower by inspection.

> 
> 4. I believe it can be tuned or has some gaps inside refactoring logic,
> which can be fixed, but as is it can not be used for fair hash creation.

Yes, I now agree.  And, for the purpose of dynamic hash sizing, high
dispersion is worse than artifacts.

For some realistic TCP data sets it appears that XOR is superior.

Thank you again for your efforts in resolving my doubts.

So what are your thoughts about my sequence number approach (for
connected sockets)?
