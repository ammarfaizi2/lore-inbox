Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVBOQsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVBOQsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVBOQsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:48:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:7078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261783AbVBOQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:48:42 -0500
Message-ID: <421227DF.8060209@osdl.org>
Date: Tue, 15 Feb 2005 08:48:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Aur=E9lien_G=C9R=D4ME?= <ag@roxor.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: RTC Inappropriate ioctl for device
References: <20050213214145.GN12421@roxor.cx> <42117047.6020209@osdl.org> <20050215111636.GO12421@roxor.cx>
In-Reply-To: <20050215111636.GO12421@roxor.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurélien GÉRÔME wrote:
> On Mon, Feb 14, 2005 at 07:45:11PM -0800, Randy.Dunlap wrote:
> 
>>Aurélien GÉRÔME wrote:
>>
>>>Hi,
>>>
>>>Having CONFIG_RTC=y, I tried on x86 the rtctest program found in
>>>linux-2.6.10/Documentation/rtc.txt. However, it failed at:
>>>
>>>ioctl(fd, RTC_UIE_ON, 0);
>>>
>>>with:
>>>
>>>ioctl: Inappropriate ioctl for device
>>>
>>>Did I miss something? Maybe something else conflicts with CONFIG_RTC?
>>>
>>>Cheers.
>>
>>Do you have an HPET timer enabled?  That could cause a conflict.
> 
> 
> I have HPET timer enabled.

Please add/enable the second line here:
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set

and try it again.


>>Does /proc/interrupts report rtc interrupts increasing when you
>>run rtctest?
>>I.e., does the number of this line increase like this?
>>
>>  8:        131    IO-APIC-edge  rtc
> 
> 
> I have no lines with rtc at the end, maybe due to HPET.
> 
> Is it a known behaviour of RTC with HPET?

Apparently that's why a config option was added for it.

>>rtctest works for me (2.6.11-rc4).  Maybe send me the strace
>>output when you run rtctest and your .config file.
> 
> 
> See attachment for strace and .config.
> 
> 
>>Oh, and your kernel boot log, maybe there are some rtc driver
>>messages in it.
> 
> 
> See attachment for kern.log.
> 
> I have bzip2'ed kern.log and .config, since they were rather large.


-- 
~Randy
