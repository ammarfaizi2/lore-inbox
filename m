Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVANA2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVANA2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVANAVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:21:38 -0500
Received: from gprs214-120.eurotel.cz ([160.218.214.120]:11136 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261773AbVANATO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:19:14 -0500
Date: Fri, 14 Jan 2005 01:11:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: george@mvista.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VST patches ported to 2.6.11-rc1
Message-ID: <20050114001118.GA1367@elf.ucw.cz>
References: <20050113132641.GA4380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113132641.GA4380@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I really hate sf download system... Here are those patches (only
> common+i386) ported to 2.6.11-rc1.

Good news is it booted. But I could not measure any powersavings by
turning it on. (I could measure difference between HZ=100 and
HZ=1000).

Hmm, it does not want to do anything. threshold used to be 1000, does
it mean that it would not use vst unless there was one second of quiet
state? I tried to lower it to 10 ("get me HZ=100 power consumption")
but it does not seem to be used, anyway:

root@amd:/proc/sys/kernel/vst# cat successful_vst_exit
0
root@amd:/proc/sys/kernel/vst# cat external_intr_exit
0
root@amd:/proc/sys/kernel/vst#

> +config HIGH_RES_RESOLUTION
> +	int "High Resolution Timer resolution (nanoseconds)"
> +	depends on HIGH_RES_TIMERS
> +	default 1000
> +	help
> +	  This sets the resolution in nanoseconds of the CLOCK_REALTIME_HR and
> +	  CLOCK_MONOTONIC_HR timers.  Too fine a resolution (small a number)
> +	  will usually not be observable due to normal system latencies.  For an
> +          800 MHz processor about 10,000 (10 microseconds) is recommended as a
> +	  finest resolution.  If you don't need that sort of resolution,
> +	  larger values may generate less overhead.

Ugh, if minimum recomended value is 10K, why does it have 1K as a
default?

> +          The system boots with VST enabled and it can be disabled by:
> +	  "echo 0 > /proc/sys/kernel/vst/enable".

It definitely booted with vst disabled here... echo 1 did the trick
through.

>short_timer_fns         This is an array of 5 entries of the form
> ...
>                        0xc110ea80 when the timer expires.
>Both of these arrays are kept as circular lists and read back such
>that
>the latest entry is presented to the reader first.  The entries are
>cleared when read.

...it is bad idea to have them world-readable, then.
								Pavel


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
