Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWBKEEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWBKEEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBKEEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 23:04:16 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:20169 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932179AbWBKEEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 23:04:15 -0500
Message-ID: <43ED623D.90401@bigpond.net.au>
Date: Sat, 11 Feb 2006 15:04:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, kernel@kolivas.org,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org>	<20060207141525.19d2b1be.akpm@osdl.org>	<200602081011.09749.kernel@kolivas.org>	<20060207153617.6520f126.akpm@osdl.org>	<20060209230145.A17405@unix-os.sc.intel.com> <20060209231703.4bd796bf.akpm@osdl.org> <43ED3D6A.8010300@bigpond.net.au>
In-Reply-To: <43ED3D6A.8010300@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 11 Feb 2006 04:04:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
> 
>> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>>
>>> b) On a lightly loaded system, this can result in HT scheduler 
>>> optimizations
>>> being disabled in presence of low priority tasks... in this case, 
>>> they(low
>>> priority ones) can end up running on the same package, even in the 
>>> presence of other idle packages.. Though this is not as serious as 
>>> "a" above...
>>>
> 
> I think that this issue comes under the heading of "Result of better 
> nice enforcement" which is the purpose of the patch :-).

On the assumption that this enforcement is considered to be too 
vigorous,  I think that it is also amenable to a fix based on a new 
biased_load() function by replacing the (*imbalance < SCHED_LOAD_SCALE) 
test with (biased_load(*imbalance, busiest) == 0) and (possibly) some 
modifications within the if statement's body (most notably replacing the 
NICE_TO_BIAS_PRIO(0) expressions with (busiest->prio_bias / 
busiest->nr_running) or something similar).

This change would cause no change in functionality in the case where all 
tasks are nice==0.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
