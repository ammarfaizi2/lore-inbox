Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSLYByx>; Tue, 24 Dec 2002 20:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbSLYByx>; Tue, 24 Dec 2002 20:54:53 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:21256 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S266038AbSLYByw>; Tue, 24 Dec 2002 20:54:52 -0500
Date: Tue, 24 Dec 2002 18:02:58 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Message-ID: <20021225020258.GC30929@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <000d01c2a8b6$3d102e20$941e1c43@joe> <B7CC2AA8-1720-11D7-8DC6-000393950CC2@karlsbakk.net> <20021224172122.GB30929@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021224172122.GB30929@pegasys.ws>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 09:21:23AM -0800, jw schultz wrote:
> On Tue, Dec 24, 2002 at 10:18:52AM +0100, Roy Sigurd Karlsbakk wrote:
> > keep in mind that only around half of the seek time is because of the 
> > partition! Taking an IBM 120GXP as an example:
> > 
> > Average seek:				8.5ms
> > Full stroke seek:			15.0ms
> > Time to rotate disk one round:	1/(7200/60)*1000 = 8.3ms
> 
> I'm afraid your math is off.
> 
> The rotational frequency should be 7200*60/sec which makes
> for 2.31 us which would produce an average rotational
> latency of 1.16us if such a condition even still applies.
> My expectation is that the whole track is buffered starting
> from the first sector that syncs thereby making the time
> rotfreq + rotfreq/nsect or something similar.  In any case
> the rotational latency or frequency is orders of magnitude
> smaller than the seek time, even between adjacent
> tracks/cylinders.
> 
> If the the stated average seek is 50% of full stroke and not
> based on reality then 76% of the cost of an average seek is
> attributed to distance and likewise 87% of the cost of a
> full.  Based on that i'd say the seek distance is a much
> bigger player than you are assuming.  If it weren't the
> value of elevators would be much less.

No. Your math is correct.  Mine is upside down.  Don't know
where that came from.  Apologies for the bad smell.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
