Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWGXTon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWGXTon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWGXTon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:44:43 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:6065 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751145AbWGXTom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:44:42 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.18-rc1-git] rtc-acpi, with wakeup support
Date: Mon, 24 Jul 2006 12:44:35 -0700
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, len.brown@intel.com
References: <200607151240.51192.david-b@pacbell.net>
In-Reply-To: <200607151240.51192.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607241244.36574.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, so -- any comments?  This applies just fine to RC2 of course
(it came out minutes before RC2 "shipped").  Seems to me this would
be appropriate for the next MM release.

Also, given some mechanism to tell whether this alarm woke the system,
this would seem to be the kind of infrastructure needed to make the
"deepening suspend" work correctly.  That is, idle system enters the
light weight "standby" powersave mode, then if it stays idle for long
enough for the timer to wake it could enter suspend-to-RAM (or that
new "suspend-to-both" mode).  There's certainly enough idle time on
most laptops for such mechanisms to help save significant amounts of
battery power, and it's best if such things don't explicitly depend
on features like ACPI.

- Dave


On Saturday 15 July 2006 12:40 pm, David Brownell wrote:
> The new RTC framework hasn't been very usable on most x86 desktop
> PCs ... so here's a driver using the ACPI RTC and PNPACPI.  AFAICT
> it could mostly replace drivers/char/rtc.c on ACPI systems.
> 
> One of the goals here was to expose this RTC as a normal wakeup
> event source ... no /proc/acpi/alarm thing, just the same userspace
> interfaces as on non-ACPI RTCs, and non-RTC devices.  That works
> somewhat ... for the very first time, I've seen ACPI wakeup behave!
> 
> But ACPI doesn't always behave after hardware wakeup events, so
> 
> 	echo disabled > /sys/class/rtc/rtc0/device/power/wakeup
> 
> may be appropriate on the systems where it doesn't yet work.
> 
> - Dave
> 
> p.s. A followup message will include a userspace program which
>      makes it easier to try the RTC wakeup mechanism.
> 
> 
> 
> 
