Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWCUPNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWCUPNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWCUPNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:13:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6671 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751763AbWCUPNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:13:11 -0500
Date: Sun, 19 Mar 2006 18:13:36 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14] RTC: Remove RTC UIP synchronization on x86
Message-ID: <20060319181335.GA2389@ucw.cz>
References: <2.132654658@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2.132654658@selenic.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Remove RTC UIP synchronization on x86
> 
> Reading the CMOS clock on x86 and some other arches currently takes up
> to one second because it synchronizes with the CMOS second tick-over.
> This delay shows up at boot time as well a resume time.
> 
> This is the currently the most substantial boot time delay for
> machines that are working towards instant-on capability. Also, a quick
> back of the envelope calculation (.5sec * 2M users * 1 boot a day * 10 years)
> suggests it has cost Linux users in the neighborhood of a million
> man-hours.

Heh, nice manipulation attempt. Note you are also introduced timing
error of about 114 years total.

> In my view, there are basically four cases to consider:
> 
> 1) networked, need precise walltime: use NTP
> 2) networked, don't need precise walltime: use NTP anyway
> 3) not networked, don't need sub-second precision walltime: don't care
> 4) not networked, need sub-second precision walltime:
>    get a network or a radio time source because RTC isn't good enough anyway

Eh, very nice, so I should get radio time source for my notebook?

> So this patch series simply removes the synchronization in favor of a
> simple seqlock-like approach using the seconds value.

What about polling RTC from timer interrupt or something like that, so
that you get error in range of 5 msec instead of 500 msec? You can do
the calibration in parallel, then...
								Pavel
-- 
Thanks, Sharp!
