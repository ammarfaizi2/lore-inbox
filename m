Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUCTE2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 23:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbUCTE2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 23:28:47 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:29588 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263231AbUCTE2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 23:28:41 -0500
Message-ID: <405BC760.9090107@cyberone.com.au>
Date: Sat, 20 Mar 2004 15:24:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: markw@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
References: <20040314172809.31bd72f7.akpm@osdl.org>	<200403181737.i2IHbCE09261@mail.osdl.org>	<20040318100615.7f2943ea.akpm@osdl.org>	<20040318192707.GV22234@suse.de>	<20040318191530.34e04cb2.akpm@osdl.org>	<20040318194150.4de65049.akpm@osdl.org>	<20040319183906.I8594@osdlab.pdx.osdl.net>	<20040319185026.56db3bf7.akpm@osdl.org>	<20040319185345.A4610@osdlab.pdx.osdl.net>	<405BC003.6080507@cyberone.com.au> <20040319201450.5da6847a.akpm@osdl.org>
In-Reply-To: <20040319201450.5da6847a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>> >>>
>> >>Thanks, so it's the CPU scheduler changes.  Is that machine hyperthreaded? 
>> >>And do you have CONFIG_X86_HT enabled?
>> >>
>> >
>> >Yes and CONFIG_X86_HT is enabled but I have hyperthreading disabled with
>> >'acpi=off noht' (whichever one does it.)  
>> >
>>
>>
>> The oprofile for the 01 kernel says
>> CPU: P4 / Xeon, speed 1497.76 MHz (estimated)
>> while the 02 kernel says
>> CPU: P4 / Xeon with 2 hyper-threads, speed 1497.57 MHz (estimated)
>> What's going on there?
>>
>
>Does the sched-domains patch break `acpi=off' or `noht'?
>
>

Shouldnt.

>> Other than that, nothing in the kernel profile jumps out at me:
>> schedule, __copy_from_user_ll and __copy_to_user_ll are all
>> significantly lower *after* the CPU scheduler changes, which
>> is an indicator that cache behaviour is better.
>>
>
>No, it indicates that the kernel is getting less work done.
>
>

If you are measuring the same period of time, yes. If you
are measuring the same amount of work, no. I assumed the
latter. Maybe I'm wrong.


>> Sar says average context switches/second were 9064 and  6567 before
>> and after.
>>
>> The only thing I can see is the CPU utilisation averages show the
>> scheduler patches have more of a tendancy to load up one CPU more
>> before moving to another. This actually should be good behaviour,
>> generally but I wonder if it is hurting at all. I would be really
>> surprised if it was that significant.
>>
>
>This machine is I/O-bound, the CPUs are mostly idle.  It would appear to be
>some interaction between the I/O system and the CPU scheduler.  Haven't we
>seen that with reaim also?
>
>

I can't remember how much CPU reaim uses, I thought it was
quite a lot (ie. not IO bound).

