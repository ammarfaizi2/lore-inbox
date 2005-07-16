Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVGPQp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVGPQp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 12:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVGPQp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 12:45:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41365 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261686AbVGPQov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 12:44:51 -0400
Date: Sat, 16 Jul 2005 09:44:47 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>, benh@kernel.crashing.org
Subject: Re: [RFC][PATCH 1/6] new timeofday core subsystem
Message-ID: <20050716164447.GA5865@us.ibm.com>
References: <1121484326.28999.3.camel@cog.beaverton.ibm.com> <42D8C60E.8040807@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D8C60E.8040807@tuxrocks.com>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.2005 [02:32:14 -0600], Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> > +extern nsec_t do_monotonic_clock(void);
> This looks okay ...
> 
> > +/**
> > + * do_monotonic_clock - Returns monotonically increasing nanoseconds
> > + *
> > + * Returns the monotonically increasing number of nanoseconds
> > + * since the system booted via __monotonic_clock()
> > + */
> > +nsec_t do_monotonic_clock(void)
> > +{
> > +	nsec_t ret;
> > +	unsigned long seq;
> > +
> > +	/* atomically read __monotonic_clock() */
> > +	do {
> > +		seq = read_seqbegin(&system_time_lock);
> > +
> > +		ret = __monotonic_clock();
> > +
> > +	} while (read_seqretry(&system_time_lock, seq));
> > +
> > +	return ret;
> > +}
> 
> ... but this conflicts with Nish's softtimer patches, which is
> implemented slightly differently.  For those of us who are real gluttons
> for punishment, and want both sets of patches, are there problems just
> removing one of the do_monotonic_clock definitions?

No, in fact, that would be expected. If you are going to apply John's
patches and mine, then you can remove the definition I put in time.c
(technically, I probably should have put that definition in a #ifndef
CONFIG_NEWTOD/#endif block).

My version is basically a non-NEWTOD attempt to get nanosecond uptime.
But, if you have John's timesources, then use them :)

Thanks,
Nish
