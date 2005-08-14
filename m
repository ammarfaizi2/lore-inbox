Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVHNCF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVHNCF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 22:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVHNCF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 22:05:29 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:18633 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932396AbVHNCF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 22:05:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Sun, 14 Aug 2005 10:18:28 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       ak@muc.de, schwidefsky@de.ibm.com, george@mvista.com
References: <20050812201946.GA5327@in.ibm.com> <200508140053.21056.kernel@kolivas.org> <20050813164618.GA4659@in.ibm.com>
In-Reply-To: <20050813164618.GA4659@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508141018.29668.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 02:46, Srivatsa Vaddagiri wrote:
> On Sun, Aug 14, 2005 at 12:53:20AM +1000, Con Kolivas wrote:
> > Indeed this fixes it on my P4 so that it does skip ticks. However
> > presumably due to the code change I am having the reverse behaviour from
> > previously - it pauses for ages when using PIT - worse so than previously
> > in that if I dont generate interrupts with my mouse or keyboard it just
> > sits there indefinitely. Having said that, it seems to work fine in APIC
> > mode.
>
> Can you explain what you mean by "pauses for ages when using PIT"? Is it
> while running pmstat? What command line options did you use? 

I use vmstat as that is good enough to tell me how many interrupts/s are 
occurring. When running 'vmstat 2' for example with PIT mode, vmstat makes 
absolutely no progress if I don't move the mouse, even though it's supposed 
to update every 2 seconds. Then when I move the mouse it will show something 
like 13 tasks running presumably because all of these tasks were waiting on 
timers that made no progress until interrupts drove the timers on again. I 
built in both PIT and APIC dyntick mode into the kernel and the default in 
the way I modified the patch is for APIC mode to be used if it's built in. 
After that I modified the values using the sysfs interface at
/sys/devices/system/dyn_tick/dyn_tick0/. In APIC mode it seems to run close to 
what it did on the pre-smp version of the dynticks patch but the timers do 
seem to be off still with vmstat updating at intervals not consistent with 
what parameter is passed to it. It does seems there are some timing issues 
with this patch, although it is also quite stable (up for 10 hours now).
I've had a few interesting messages in my syslog suggesting problems:
Hangcheck: hangcheck value past margin!

and then later on a few of:
set_rtc_mmss: can't update from 0 to 59

Cheers,
Con
