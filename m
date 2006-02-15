Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945921AbWBOMhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945921AbWBOMhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945920AbWBOMhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:37:06 -0500
Received: from ns1.suse.de ([195.135.220.2]:52973 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1945918AbWBOMhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:37:04 -0500
Message-ID: <43F3206B.6090902@suse.de>
Date: Wed, 15 Feb 2006 13:36:59 +0100
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de> <200602142117.31232.rjw@sisk.pl>
In-Reply-To: <200602142117.31232.rjw@sisk.pl>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday 14 February 2006 18:44, Thomas Renninger wrote:
>> Pavel Machek wrote:
>>> On Pá 10-02-06 09:06:43, Stefan Seyfried wrote:
>>>> On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
>>>>> The included patch adds support for power management methods to register 
>>>>> callbacks in order to allow drivers to check if the system is on AC or 
>>>>> not. Following patches add support to ACPI and APM. Feedback welcome.
>>>> Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
>>>> Can't we handles this easily in userspace?
>>> Some kernel parts need to now: for example powernow-k8: some
>>> frequencies are not allowed when you are running off battery. [Just
>>> now it is solved by not allowing those frequencies at all unless ACPI
>>> is available; quite an ugly solution.]
>>>
>> Allowed CPUfreqs are exported via _PPC.
>> This is why a lot hardware sends an ac_adapter and a processor event
>> when (un)plugging ac adapter.
>> Limiting cpufreq already works nice that way.
>>
>> AMD64 laptops are booting with lower freqs per default until they are
>> pushed up, so there shouldn't be anything critical?
> 
> This is not true as far as my box is concerned (Asus L5D).  It starts with
> the _highest_ clock available.
Hmm, but then there shouldn't be any critical overheat problems and if,
the hardware has to switch off the machine hard. OS always could freeze,
but the battery must not start to burn...
> 
>> For the brightness part, I don't see any "laptop is going to explode"
>> issue.
>> I always hated the brightness going down when I unplugged ac on M$
> 
> Currently I have the same problem on Linux, but I don't know the solution
> (yet).  Any hints? :-)
Hmm, this is probably done by ACPI in some ac connected function?
Seems as some machines already adjust brightness in ACPI context to the
ac/battery brightness value and some leave it to the OS to adjust.
Override it in /sys/../brightness (as soon as it exists) or the current
vendor specific solution file.
Connect the acpid to a battery ACPI event rule and let override it there.


IMO, the /sys/.../brightness patch should go in as soon as possible, I think
all everybody agrees here?

Maybe I oversaw an issue, but I really don't see a reason for connecting
the brightness to ac in kernel space.
Some weeks later someone likes to have a /sys/../brightness_ignore_ac switch ...

    Thomas
