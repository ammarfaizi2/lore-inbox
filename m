Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVANBWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVANBWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVANBFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:05:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5872 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261853AbVANBDy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:03:54 -0500
Message-ID: <41E71A78.8050507@mvista.com>
Date: Thu, 13 Jan 2005 17:03:52 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VST patches ported to 2.6.11-rc1
References: <20050113132641.GA4380@elf.ucw.cz> <20050114001118.GA1367@elf.ucw.cz>
In-Reply-To: <20050114001118.GA1367@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>I really hate sf download system... Here are those patches (only
>>common+i386) ported to 2.6.11-rc1.
> 
> 
> Good news is it booted. But I could not measure any powersavings by
> turning it on. (I could measure difference between HZ=100 and
> HZ=1000).
> 
> Hmm, it does not want to do anything. threshold used to be 1000, does
> it mean that it would not use vst unless there was one second of quiet
> state? I tried to lower it to 10 ("get me HZ=100 power consumption")
> but it does not seem to be used, anyway:
> 
> root@amd:/proc/sys/kernel/vst# cat successful_vst_exit
> 0
> root@amd:/proc/sys/kernel/vst# cat external_intr_exit
> 0
> root@amd:/proc/sys/kernel/vst#

Hm.. and this after you lowered the threshold?  The skipped interrupts should 
also be of interest...
> 
> 
>>+config HIGH_RES_RESOLUTION
>>+	int "High Resolution Timer resolution (nanoseconds)"
>>+	depends on HIGH_RES_TIMERS
>>+	default 1000
>>+	help
>>+	  This sets the resolution in nanoseconds of the CLOCK_REALTIME_HR and
>>+	  CLOCK_MONOTONIC_HR timers.  Too fine a resolution (small a number)
>>+	  will usually not be observable due to normal system latencies.  For an
>>+          800 MHz processor about 10,000 (10 microseconds) is recommended as a
>>+	  finest resolution.  If you don't need that sort of resolution,
>>+	  larger values may generate less overhead.
> 
> 
> Ugh, if minimum recomended value is 10K, why does it have 1K as a
> default?

I think I have this wrong.  I usually set it to 10 for my testing.  I need to 
look over the conversion code and such to see just what the units are...

> 
> 
>>+          The system boots with VST enabled and it can be disabled by:
>>+	  "echo 0 > /proc/sys/kernel/vst/enable".
> 
> 
> It definitely booted with vst disabled here... echo 1 did the trick
> through.

I missed that.  Yes we want to boot with it disabled.  It can upset some of the 
boot up code otherwise.
> 
> 
>>short_timer_fns         This is an array of 5 entries of the form
>>...
>>                       0xc110ea80 when the timer expires.
>>Both of these arrays are kept as circular lists and read back such
>>that
>>the latest entry is presented to the reader first.  The entries are
>>cleared when read.
> 
> 
> ...it is bad idea to have them world-readable, then.

This is diagnostic code for the kernel dude who wants to know why he is not 
getting the VST sleeps he wants.  Seems a bit harsh to make him be root to see 
it....

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

