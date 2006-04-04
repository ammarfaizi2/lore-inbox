Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWDDXRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWDDXRf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 19:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWDDXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 19:17:35 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:20324 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750909AbWDDXRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 19:17:34 -0400
Message-ID: <4432FE8C.7010900@bigpond.net.au>
Date: Wed, 05 Apr 2006 09:17:32 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com> <4431A9E7.40406@bigpond.net.au> <200604041627.25359.a1426z@gawab.com>
In-Reply-To: <200604041627.25359.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 23:17:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>>>>> Control parameters for the scheduler can be read/set via files in:
>>>>>>
>>>>>> /sys/cpusched/<scheduler>/
>>> The default values for spa make it really easy to lock up the system.
>> Which one of the SPA schedulers and under what conditions?  I've been
>> mucking around with these and may have broken something.  If so I'd like
>> to fix it.
> 
> spa_no_frills, with a malloc-hog less than timeslice.  Setting 
> promotion_floor to max unlocks the console.

OK, you could also try increasing the promotion interval.

It should be noted that spa_no_frills isn't really expected to behave 
very well as it's a pure round robin scheduler.  It's intended purpose 
is as a basis for more sophisticated schedulers.  I've been thinking 
about removing it as a bootable scheduler and only making its children 
available but I find it useful to compare benchmark and other test 
results from it with that from the other schedulers to get an idea of 
the extra costs involved.

Similarly, zaphod is really just a vehicle for trying different ideas 
and the spa_ws, spa_svr and spa_ebs are the ones intended for use on 
real systems.  Of these, spa_svr isn't very good for interactive systems 
as it is designed to maximize throughput on a server (it actually beats 
spa_no_frills by about 1% on kernbench) which isn't always compatible 
with good interactive response.

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
