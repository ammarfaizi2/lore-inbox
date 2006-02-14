Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWBNRod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWBNRod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWBNRod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:44:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:14041 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422702AbWBNRoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:44:32 -0500
Message-ID: <43F216FE.7050101@suse.de>
Date: Tue, 14 Feb 2006 18:44:30 +0100
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Seyfried <seife@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de> <20060210121913.GA4974@elf.ucw.cz>
In-Reply-To: <20060210121913.GA4974@elf.ucw.cz>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Pá 10-02-06 09:06:43, Stefan Seyfried wrote:
>> On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
>>> The included patch adds support for power management methods to register 
>>> callbacks in order to allow drivers to check if the system is on AC or 
>>> not. Following patches add support to ACPI and APM. Feedback welcome.
>> Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
>> Can't we handles this easily in userspace?
> 
> Some kernel parts need to now: for example powernow-k8: some
> frequencies are not allowed when you are running off battery. [Just
> now it is solved by not allowing those frequencies at all unless ACPI
> is available; quite an ugly solution.]
> 
Allowed CPUfreqs are exported via _PPC.
This is why a lot hardware sends an ac_adapter and a processor event
when (un)plugging ac adapter.
Limiting cpufreq already works nice that way.

AMD64 laptops are booting with lower freqs per default until they are
pushed up, so there shouldn't be anything critical?

For the brightness part, I don't see any "laptop is going to explode"
issue.
I always hated the brightness going down when I unplugged ac on M$
and had to push ten times the brightness "up button" before I could
go on working...

Shouldn't it be:

               
ac Event   ---> userspace <--- user config
                   |
                   | 
brightness <-------|

Whether the ac brightness will be set when going to ac, or
whatever brightness, should be configurable in userspace IMO.
This is a one liner in the acpid config?

However, I also like the general /sys/../brightness file very much!


     Thomas
