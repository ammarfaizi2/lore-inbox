Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278214AbRKAHqY>; Thu, 1 Nov 2001 02:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278216AbRKAHqP>; Thu, 1 Nov 2001 02:46:15 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:59040 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S278214AbRKAHqJ>; Thu, 1 Nov 2001 02:46:09 -0500
Date: Thu, 1 Nov 2001 09:45:49 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Gerhard Mack <gmack@innerfire.net>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011101094549.B26218@niksula.cs.hut.fi>
In-Reply-To: <20011031135215.O16554@lynx.no> <Pine.LNX.3.95.1011031161340.21906B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1011031161340.21906B-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Oct 31, 2001 at 04:17:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 04:17:36PM -0500, you [Richard B. Johnson] claimed:
> > u64 get_jiffies64(void)
> > {
> > 	static unsigned long jiffies_hi = 0;
> > 	static unsigned long jiffies_last = INITIAL_JIFFIES;
> > 
> > 	/* probably need locking for this part */
> > 	if (jiffies < jiffies_last) {	/* We have a wrap */
> > 		jiffies_hi++;
> > 		jiffies_last = jiffies;
> > 	}
> > 
> > 	return (jiffies | ((u64)jiffies_hi) << LONG_SHIFT));
> > }
> 
> Ah, yes. It's perfect. It could be put right in the 'uptime' code.
> It has zero overhead otherwise. 

Just my two cents... I would prefer that to be in kernel (it has what, 8
byte overhead), so that /proc/uptime is correct, not just uptime(1) output.
There are other programs that access /proc/uptime as well, so it would be
good to fix it in one place.

I was thinking, could there be a elegant(ish) place in the kernel where one
could drop a dummy call to get_jiffies64 so that it would always be called
at least once a 497 days (I'm not sure wher the 1.3 years value comes from)?

Other than that this seems a good alternative.


-- v --

v@iki.fi
