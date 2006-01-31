Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWAaEJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWAaEJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 23:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWAaEJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 23:09:16 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:1773 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1030219AbWAaEJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 23:09:15 -0500
From: Dave Peterson <dsp@llnl.gov>
To: doug thompson <dthompson@linuxnetworx.com>,
       Gunther Mayer <gunther.mayer@gmx.net>
Subject: Re: noisy edac
Date: Mon, 30 Jan 2006 20:09:04 -0800
User-Agent: KMail/1.5.3
Cc: "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com> <43DEA922.3030602@gmx.net> <1138667549.8251.90.camel@logos.linuxnetworx.com>
In-Reply-To: <1138667549.8251.90.camel@logos.linuxnetworx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601302009.04772.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 16:32, doug thompson wrote:
> Currently each of the MC drivers some of their output error messages in
> their own pattern of output, while also funnelling common info to the
> core module.  We don't want to lose that device specific information,
> but it would be a better pattern to funnel that device specific output
> to the EDAC Core module for presentation in a more uniforum manner,
> through the new sysfs interface, such as:

I think the kinds of error information that different chipsets report
will be diverse enough that it will be hard or impossible to identify
enough commonality to justify pushing chipset-specific error info to
the core EDAC module.

> /sys/drivers/system/edac/mc/mc_driver_error_report
>
> or some such.

In general, I think having this info go to the console or the system
log would fit better relative to the way other subsystems report
their error information.

However, one thing I can think of that may be fairly common is a
desire to keep track of the # of occurrences of a particular kind of
error (as is currently done for correctible ECC memory errors).  For
errors for which this is desired, sysfs can provide an entry that
gives the number of occurrences of a particular type of error.  However,
I would prefer to see that info provided under the part of the sysfs
hierarchy for the particular chipset that detects a given type of error.

For errors for which we track the # of occurrences, it may be desirable
to perform some action (perhaps emailing a sysadmin or halting the
machine) when the error count reaches a certain threshold.  I think it
would be good to have the logic for determining when the threshold is
reached (and the action to take when the threshold is reached) reside
out in user space as much as possible.

For some chipsets (such as the Intel e7525), the hardware has a
built-in "leaky bucket" mechanism for tracking counts of correctible
ECC memory errors.  For chipsets that support this, we will probably
eventually want to provide a means for the user to enable this
functionality.  For chipsets that do not support it, the leaky bucket
algorithm (or perhaps some other algorithm) can be done by user space
code provided that there is some means of pushing the relevant info
out to user space.

Dave
