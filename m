Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVCBWJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVCBWJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVCBWIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:08:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25081 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262440AbVCBV6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:58:54 -0500
Message-ID: <42263719.7030004@mvista.com>
Date: Wed, 02 Mar 2005 13:58:49 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <20050302085619.GA1364@elf.ucw.cz>
In-Reply-To: <20050302085619.GA1364@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>Advertise custom sets of system power states for non-ACPI systems.
>>Currently, /sys/power/state shows and accepts a static set of choices
>>that are not necessarily meaningful on all platforms (for example,
>>suspend-to-disk is an option even on diskless embedded systems, and the
>>meaning of standby vs. suspend-to-mem is not well-defined on
>>non-ACPI-systems).  This patch allows the platform to register power
>>states with meaningful names that correspond to the platform's
>>conventions (for example, "big sleep" and "deep sleep" on TI OMAP), and
>>only those states that make sense for the platform.
> 
> 
> Maybe this is a bit overdone?
> 
> Of course you can have suspend-to-disk on most embedded systems; CF
> flash card looks just like disk, and you should be able to suspend to
> it.

It's possible (on those with CF/PCMCIA etc.), although due to various 
problems with things like flash size, write speed, and wear leveling 
it's not very common to do so (I've seen two vendors abandon plans for 
this, but no doubt somebody does do it) -- that's why I'd like to have 
the particular platform register the capability if it happens to have 
it, but no, not a big deal.

> If OMAP has "big sleep" and "deep sleep", why not simply map them to
> "standby" and "suspend-to-ram"?

In fact that's more or less what happens (or will happen once drivers 
like USB stop looking for PM_SUSPEND_MEM, etc.).  There are other 
platforms with more than 2 sleep states (say, XScale PXA27x), so this 
will start to get a bit problematic.  And it seens so easy to truly 
handle the platform's states instead of pretending ACPI S1/S3/S4 are the 
only methods to suspend any system.

If it's preferable, how about replacing the /sys/power/state "standby" 
and "mem" values  to "sleep", and have a /sys/power/sleep attribute that 
tells the methods of sleep available for the platform, much like 
suspend-to-disk methods are handled today?  So the sleep attribute would 
handle "standby" and "mem" for ACPI systems, and other values for 
non-ACPI systems.  Thanks,


-- 
Todd
