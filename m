Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750789AbWFEXNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWFEXNh (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFEXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:13:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6818 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750789AbWFEXNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:13:36 -0400
Subject: Re: [patch-rt 1/2] Remove existing time code from ARM architecture
From: john stultz <johnstul@us.ibm.com>
To: dsaxena@plexity.net
Cc: mingo@elte.hu, tglx@linutronix.de, dwalker@mvista.com,
        james.perkins@windriver.com, linux-kernel@vger.kernel.org,
        rmk@arm.linux.org.uk, khilman@mvista.com
In-Reply-To: <20060605224438.054796000@localhost.localdomain>
References: <20060605222956.608067000@localhost.localdomain>
	 <20060605224438.054796000@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 16:13:32 -0700
Message-Id: <1149549212.11470.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 15:29 -0700, dsaxena@plexity.net wrote:
> plain text document attachment (arm-generic-timeofday.patch)
> This patch removes do_gettimeofday(), do_setttimeofday() and associated
> time functions from ARM so that it can use the generic time-of-day code.
> Each sub-arch must explicitly enable CONFIG_IS_TICK_BASED if it does
> not have continous timer source.

It might be good to define CONFIG_IS_TICK_BASED for the other ARM arches
so they continue to build after your changes. Otherwise it looks good to
me.

Another aside: CONFIG_IS_TICK_BASED also goes away w/ the Cx series. So
there you will want to conditionally enable GENERIC_TIME if you have a
clocksources defined and just wrap the old get/set_timeofday() w/ ifndef
CONFIG_GENERIC_TIME until all the sub-arches have been converted. Don't
worry too much, I'll lend a hand here when the time comes to update -rt,
so it shouldn't be much of an issue.

thanks
-john

