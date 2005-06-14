Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVFNAxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVFNAxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVFNAxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:53:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12961 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261221AbVFNAxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:53:11 -0400
Subject: Re: [PATCH 1/4] new timeofday core subsystem (v. B2)
From: john stultz <johnstul@us.ibm.com>
To: Pekka Enberg <penberg@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f020506090615f6d67fc@mail.gmail.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
	 <84144f020506090615f6d67fc@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 17:53:00 -0700
Message-Id: <1118710380.27071.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 16:15 +0300, Pekka Enberg wrote:
> Hi John,
> 
> Some coding style comments below.

[snip]
> Please drop this redundant comment.
> 
> > +	interval_sum += interval;
> > +
> > +	write_seqlock_irqsave(&ntp_lock, flags);
> > +
> > +	/* decrement singleshot offset interval */
> 
> Ditto.
> 
> > +	ss_offset_len -= interval;
> > +	if(ss_offset_len < 0) /* make sure it doesn't go negative */
> 
> Ditto.
> 
> > +		ss_offset_len = 0;
> > +
> > +	/* Do second overflow code */
> 
> Drop redundant comment.
> 
> > +		ntp_maxerror += shiftR(ntp_tolerance, SHIFT_USEC);
> > +		if (ntp_maxerror > NTP_PHASE_LIMIT) {
> > +			ntp_maxerror = NTP_PHASE_LIMIT;
> > +			ntp_status |= STA_UNSYNC;
> > +		}
> > +
> > +		/* Calculate offset_adj for the next second */
> 
> Ditto.
> 
> > +		tmp = ntp_offset;
> 
> tmp could use a more descriptive name.
> 
> > +		if (!(ntp_status & STA_FLL))
> > +		    tmp = shiftR(tmp, SHIFT_KG + ntp_constant);
> > +
> > +		/* bound the adjustment to MAXPHASE/MINSEC */
> 
> Redundant comment.


Thanks for the uh, redundant redundant-comment comments ;)

Much is from the transition from psudo-code to actual code, so I
appreciate you pointing it out. There are a few spots where I feel there
is still value in the comments, so I've left them, but overall I think
you'll see an improvement.

thanks again for the feedback!
-john



