Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVBAWGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVBAWGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVBAWGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:06:21 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:58579 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262136AbVBAWGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:06:11 -0500
Message-ID: <41FFFD4F.9050900@am.sony.com>
Date: Tue, 01 Feb 2005 14:06:07 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
In-Reply-To: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor spelling fix, and a question.

john stultz wrote:
> linux-2.6.11-rc2_timeofday-core_A2.patch
> ========================================
> diff -Nru a/drivers/Makefile b/drivers/Makefile
> --- a/drivers/Makefile	2005-01-24 13:30:06 -08:00
> +++ b/drivers/Makefile	2005-01-24 13:30:06 -08:00
...

> + * all systems. It has the same course resolution as
should be "coarse"

Do you replace get_cmos_time() - it doesn't look like it.

You use it in your patch here...

> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c	2005-01-24 13:33:59 -08:00
> +++ b/arch/i386/kernel/time.c	2005-01-24 13:33:59 -08:00
...

> +/* arch specific timeofday hooks */
> +nsec_t read_persistent_clock(void)
> +{
> +	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
> +}
> +

I didn't scan for all uses of read_persistent_clock, but
in my experience get_cmos_time() has a latency of up to
1 second on x86 because it synchronizes with the rollover
of the RTC seconds.

This comment in timeofday.c:timeofday_suspend_hook
worries me:

> +	/* First off, save suspend start time
> +	 * then quickly read the time source.
> +	 * These two calls hopefully occur quickly
> +	 * because the difference will accumulate as
> +	 * time drift on resume.
> +	 */
> +	suspend_start = read_persistent_clock();

Do you know if the sync problem is an issue here?

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
