Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVI0QhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVI0QhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVI0QhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:37:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16094 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965001AbVI0QhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:37:21 -0400
Date: Tue, 27 Sep 2005 18:37:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
In-Reply-To: <1127419198.8195.10.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0509271809460.3728@scrub.home>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
 <1127419198.8195.10.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Sep 2005, john stultz wrote:

> +
> +	/* calculate the total continuous ppm adjustment */
> +	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
> +	total_sppm += offset_adj_ppm << SHIFT_USEC;
> +	total_sppm += tick_adj_ppm << SHIFT_USEC;
> +	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
>  }

I'm not sure, why you still need this.
As I already said, I don't think you need to change the kernel NTP model. 
This means in particular that the NTP time is still incremented in fixed 
intervals (although it's not necessary to do it at HZ frequency).
I showed you how to do most of the calculation, so I'm a little confused, 
why the above is still used.

In general I would prefer to see the introduction of the timesource 
abstraction, which will first replace the arch callbacks do_gettimeofday/ 
do_settimeofday.

bye, Roman
