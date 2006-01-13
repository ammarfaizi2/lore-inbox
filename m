Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422983AbWAMVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbWAMVWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWAMVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:22:55 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:29149 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1422983AbWAMVWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:22:54 -0500
Date: Fri, 13 Jan 2006 13:18:35 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Sven-Thorsten Dietrich <sven@mvista.com>, thockin@hockin.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137178855.15108.42.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz>
References: <1137104260.2370.85.camel@mindpipe><20060113180620.GA14382@hockin.org>
 <1137175117.15108.18.camel@mindpipe><20060113181631.GA15366@hockin.org>
 <1137175792.15108.26.camel@mindpipe><20060113185533.GA18301@hockin.org><1137178574.2536.13.camel@localhost.localdomain>
 <1137178855.15108.42.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Lee Revell wrote:

> On Fri, 2006-01-13 at 10:56 -0800, Sven-Thorsten Dietrich wrote:
>> On Fri, 2006-01-13 at 10:55 -0800, thockin@hockin.org wrote:
>>> On Fri, Jan 13, 2006 at 01:09:51PM -0500, Lee Revell wrote:
>>>>> Some apps/users need higher resolution and lower overhead that only rdtsc
>>>>> can offer currently.
>>>>
>>>> But obviously if the TSC gives wildly inaccurate results, it cannot be
>>>> used no matter how low the overhead.
>>>
>>> unless we can re-sync the TSCs often enough that apps don't notice.
>>>
>>
>> You'd have to quantify that somehow, in terms of the max drift rate
>> (ppm), and the max resolution available (< tsc frequency).
>>
>> Either that, or track an offset, and use one TSC as truth, and update
>> the correction factor for the other TSCs as often as needed, maybe?
>>
>> This is kind of analogous to the "drift" NTP calculates against a
>> free-running oscillator.
>>
>> So you'd be pushing that functionality deeper into the OS-core.
>>
>> Dave Mills had that "hardpps" stuff in there for a while, it might be a
>> starting point.
>>
>> Just some thoughts for now...
>>
>
> It kind of makes you wonder what in the heck AMD were thinking, whether
> they realized that this design decision would cause so many problems at
> the OS level (it's broken at least Linux and Solaris).  Maybe Windows
> keeps time in a way that was unaffected by this?

Lee, the last time I saw this discussion I thought it was identified that 
the multiple cores (or IIRC the multiple chips in a SMP motherboard) would 
only get out of sync when power management calls were made (hlt or 
switching the c-state). IIRC the workaround that was posted then was to 
just disable these in the kernel build.

if this is the case then I could easily see the hardware engineers 
thinking that if the software did a sleep thing then it was up to the 
software to re-sync the TSC clocks when the wakeup takes place.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

