Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280513AbRJaVGb>; Wed, 31 Oct 2001 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280512AbRJaVGW>; Wed, 31 Oct 2001 16:06:22 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:29963 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280511AbRJaVGI>; Wed, 31 Oct 2001 16:06:08 -0500
Date: Wed, 31 Oct 2001 22:05:17 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Gerhard Mack <gmack@innerfire.net>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <20011031135215.O16554@lynx.no>
Message-ID: <Pine.LNX.4.30.0110312157060.30141-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Andreas Dilger wrote:

> What about the following.  Since jiffies wraps are extremely rare, it
> should be enough to have something along the lines of the following
> in the uptime code only (or globally accessible for any code that
> needs to use a full 64-bit jiffies value):
>
> u64 get_jiffies64(void)
> {
> 	static unsigned long jiffies_hi = 0;
> 	static unsigned long jiffies_last = INITIAL_JIFFIES;
>
> 	/* probably need locking for this part */
> 	if (jiffies < jiffies_last) {	/* We have a wrap */
> 		jiffies_hi++;
> 		jiffies_last = jiffies;
> 	}
>
> 	return (jiffies | ((u64)jiffies_hi) << LONG_SHIFT));
> }
>
> This means you need to call something that _checks_ the uptime
> (or needs the 64-bit jiffies value) at least once every 1.3 years.
> If you don't do it at least that often, you probably don't care
> about the uptime anyways.
>
> This only impacts anything that really needs a 64-bit jiffies count,
> and has zero impact everywhere else.
>

I initially thought of that too. My objection was that boxes with long
uptimes typically get forgotten in a corner until years later someone
checks uptime again.

However, I fully agree with your importance argument and believe this
proposal to be the best one.

Tim

