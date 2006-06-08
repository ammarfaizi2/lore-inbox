Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWFHGtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWFHGtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWFHGtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:49:03 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:59656 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP id S932528AbWFHGtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:49:02 -0400
Subject: Re: [PATCH[ RTC: Add rtc_year_days() to calculate tm_yday
From: Andrew Victor <andrew@sanpeople.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it, akpm@osdl.org
In-Reply-To: <20060607193311.GH13165@flint.arm.linux.org.uk>
References: <1149704768.20154.95.camel@fuzzie.sanpeople.com>
	 <20060607193311.GH13165@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1149749016.2114.26.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Jun 2006 08:43:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Russell,

> > RTC: Add exported function rtc_year_days() to calculate the tm_yday
> > value.
> 
> Is there a good reason for this?  I ask the question because the x86
> /dev/rtc driver says:
> 
>          * Only the values that we read from the RTC are set. We leave
>          * tm_wday, tm_yday and tm_isdst untouched. Note that while the
>          * RTC has RTC_DAY_OF_WEEK, we should usually ignore it, as it is
>          * only updated by the RTC when initially set to a non-zero value.
> 
> So it seems the established modus operandi for RTC interfaces is "don't
> trust wday, yday and isdst".

wday and yday are already being calculated by rtc_time_to_tm() in
drivers/rtc/rtc-lib.c, and this function is used by about half of the
RTC class drivers.

Since yday can also be easily calculated from dd/mm/yyyy, I don't see
why those drivers who don't use rtc_time_to_tm() can't also return a
valid yday value.


Regards,
  Andrew Victor


