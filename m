Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWBXAh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWBXAh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWBXAh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:37:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:46824 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751067AbWBXAhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:37:55 -0500
Subject: Re: [PATCH] Fix next_timer_interrupt() for hrtimer
From: john stultz <johnstul@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Russell King <linux@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20060224002653.GC4578@atomide.com>
References: <20060224002653.GC4578@atomide.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 16:37:52 -0800
Message-Id: <1140741472.1271.64.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 16:26 -0800, Tony Lindgren wrote:
> +	tv = ktime_to_timespec(event);
> +
> +	/* Assume read xtime_lock is held, so we can't use getnstimeofday() */
> +	sec = xtime.tv_sec;
> +	nsec = xtime.tv_nsec;
> +	while (unlikely(nsec >= NSEC_PER_SEC)) {
> +		nsec -= NSEC_PER_SEC;
> +		++sec;
> +	}
> +	tv.tv_sec = sec;
> +	tv.tv_nsec = nsec;

Er, I think you should be able to nest readers. Thus getnstimeofday()
should be safe to call. Or is the comment wrong and you are assuming a
write lock is held?

thanks
-john


