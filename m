Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWDLRdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWDLRdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWDLRdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:33:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:25069 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932281AbWDLRdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:33:23 -0400
Date: Wed, 12 Apr 2006 10:32:36 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH 7/7] tpm: Driver for next generation TPM chips
Message-ID: <20060412173236.GA8964@us.ibm.com>
References: <1144679848.4917.15.camel@localhost.localdomain> <20060411230505.GB21210@us.ibm.com> <1144862957.12054.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144862957.12054.59.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.16-i386 (i686)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2006 [12:29:17 -0500], Kylene Jo Hall wrote:
> On Tue, 2006-04-11 at 16:05 -0700, Nishanth Aravamudan wrote:
> > return l;
> > > +
> > > +	} else {
> > > +		/* wait for burstcount */
> > > +		stop = jiffies + (HZ * chip->vendor.timeout_a / 1000);
> > > +		do {
> > > +			if (check_locality(chip, l) >= 0)
> > > +				return l;
> > > +			msleep(TPM_TIMEOUT);
> > > +		}
> > > +		while (time_before(jiffies, stop));
> > > +	}
> > 
> > This looks like it could take the msecs_to_jiffies() conversion as well.
> > Might as well cache it before the if/else, as both clauses use it?
> > Really, it is just wait_event*() without the wait-queue. Well, this is
> > at least one more consumer potentially of the poll_event*() API I had
> > written a while back, I'll dust it off again if I have the time.
> > 
> > <snip>
> > 
> > > +static int get_burstcount(struct tpm_chip *chip)
> > > +{
> > > +	unsigned long stop;
> > > +	int burstcnt;
> > > +
> > > +	/* wait for burstcount */
> > > +	/* which timeout value, spec has 2 answers (c & d) */
> > > +	stop = jiffies + (HZ * chip->vendor.timeout_d / 1000);
> > 
> > msecs_to_jiffies().
> 
> > 
> 
> Since the timeout and duration values are always used in jiffies I
> think I'll just convert them to those values when I store them in the
> chip struct to cut way down on the number of conversions all together.
> Sound reasonable?

Probably, as long as they aren't exposed to userspace in any way. I
don't think userspace should do any calculations in jiffies units.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
