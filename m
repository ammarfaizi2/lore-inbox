Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWDLR22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWDLR22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWDLR21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:28:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:15761 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932274AbWDLR21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:28:27 -0400
Subject: Re: [PATCH 7/7] tpm: Driver for next generation TPM chips
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060411230505.GB21210@us.ibm.com>
References: <1144679848.4917.15.camel@localhost.localdomain>
	 <20060411230505.GB21210@us.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 12:29:17 -0500
Message-Id: <1144862957.12054.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 16:05 -0700, Nishanth Aravamudan wrote:
> return l;
> > +
> > +	} else {
> > +		/* wait for burstcount */
> > +		stop = jiffies + (HZ * chip->vendor.timeout_a / 1000);
> > +		do {
> > +			if (check_locality(chip, l) >= 0)
> > +				return l;
> > +			msleep(TPM_TIMEOUT);
> > +		}
> > +		while (time_before(jiffies, stop));
> > +	}
> 
> This looks like it could take the msecs_to_jiffies() conversion as well.
> Might as well cache it before the if/else, as both clauses use it?
> Really, it is just wait_event*() without the wait-queue. Well, this is
> at least one more consumer potentially of the poll_event*() API I had
> written a while back, I'll dust it off again if I have the time.
> 
> <snip>
> 
> > +static int get_burstcount(struct tpm_chip *chip)
> > +{
> > +	unsigned long stop;
> > +	int burstcnt;
> > +
> > +	/* wait for burstcount */
> > +	/* which timeout value, spec has 2 answers (c & d) */
> > +	stop = jiffies + (HZ * chip->vendor.timeout_d / 1000);
> 
> msecs_to_jiffies().

> 

Since the timeout and duration values are always used in jiffies I think
I'll just convert them to those values when I store them in the chip
struct to cut way down on the number of conversions all together. Sound
reasonable?

Thanks,
Kylie




