Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUALSdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUALSdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:33:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31112 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266234AbUALSdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:33:36 -0500
Subject: Re: suspend/resume support for PIT (time.c)
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040110200332.GA1327@elf.ucw.cz>
References: <20040110200332.GA1327@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1073932405.28098.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 10:33:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-10 at 12:03, Pavel Machek wrote:
> +static int pit_suspend(struct sys_device *dev, u32 state)
[snip]
> +static int pit_resume(struct sys_device *dev)
> +{
> +	write_seqlock_irq(&xtime_lock);
> +	xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
> +	xtime.tv_nsec = 0; 
> +	write_sequnlock_irq(&xtime_lock);
> +	return 0;
> +}
[snip]
>  static struct sysdev_class pit_sysclass = {
> +	.resume = pit_resume,
> +	.suspend = pit_suspend,
>  	set_kset_name("pit"),
>  };

As none of this really has anything to do w/ the PIT, and to avoid
confusion w/ the PIT timesource code, could we rename this to
"time_suspend" and "time_resume"?

thanks
-john



