Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280417AbRJaSzx>; Wed, 31 Oct 2001 13:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280418AbRJaSzn>; Wed, 31 Oct 2001 13:55:43 -0500
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:54024 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S280417AbRJaSzd>;
	Wed, 31 Oct 2001 13:55:33 -0500
Date: Wed, 31 Oct 2001 10:58:32 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <20011031114002.H16554@lynx.no>
Message-ID: <Pine.LNX.4.10.10110311056430.6571-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why exactly do we use the jiffie count for calculating uptime?  Why not
just record the startup time and compare when needed?


	Gerhard



On Wed, 31 Oct 2001, Andreas Dilger wrote:

> On Oct 31, 2001  19:16 +0100, Tim Schmielau wrote:
> > The idea was that all drivers that use the 32 bit jiffies counter have to
> > be aware of the wraparound anyways, and won't see a difference.
> 
> Agreed.  I also like the change that you initialize jiffies to a pre-wrap
> value, so the jiffies wrap bugs can more easily be found/fixed.
> 
> > The race only happens for 64 bit accesses to jiffies, but hey, without
> > the patch these values come out wrong _every_ time, so I believed a
> > tiny window for a single wrong display of uptime every 497.1 days to be
> > acceptable.
> 
> I would say that the race is so rare that it should not be handled, especially
> since it adds extra code in the timer interrupt.
> 
> > +	/* We need to make sure jiffies_high does not change while
> > +	 * reading jiffies and jiffies_high */
> > +	do {
> > +		jiffies_high_tmp = jiffies_high_shadow;
> > +		barrier();
> > +		jiffies_tmp = jiffies;
> > +		barrier();
> > +	} while (jiffies_high != jiffies_high_tmp);
> 
> Maybe this could be condensed into a macro/inline, so that people don't
> screw it up (and it looks cleaner).  Like get_jiffies64() or so, for
> those few places that really care about the full value and can't stand
> a miniscule chance of a race (i.e. uptime output is not a candidate).
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

