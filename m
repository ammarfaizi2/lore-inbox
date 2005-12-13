Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVLMXaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVLMXaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVLMXaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:30:52 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:32884 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030291AbVLMXav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:30:51 -0500
Message-ID: <439F59A9.6020400@bigpond.net.au>
Date: Wed, 14 Dec 2005 10:30:49 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm2 :-)
References: <20051211041308.7bb19454.akpm@osdl.org> <200512131652.10117.kernel@kolivas.org> <1916802326.20051213121330@dns.toxicfilms.tv> <200512132316.14118.kernel@kolivas.org>
In-Reply-To: <200512132316.14118.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 13 Dec 2005 23:30:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tuesday 13 December 2005 22:13, Maciej Soltysiak wrote:
> 
>>Hello Con,
>>
>>Tuesday, December 13, 2005, 6:52:09 AM, you wrote:
>>
>>>I missed this announcement (been on leave for a while). This SCHED_BATCH
>>>implementation is by Ingo and it it is not "idle" scheduling as I have
>>>implemented in the staircase scheduler. This is just to restrict a task
>>>to not having any interactive bonus at any stage and to have predictable
>>>scheduling behaviour I guess.
>>
>>Thanks a lot. That's good anyway.
>>
>>If I understand correctly, if Ingo's version gets merged with linus' tree
>>your implementions of SCHED_BATCH in -ck will be replacing the one from
>>Ingo.
> 
> 
> Yes. SCHED_BATCH in Ingo's implementation is more like turning off the 
> interactive setting in staircase, and the idle scheduling staircase offers is 
> extremely useful.
> 
> 
>>A silly question. Is SCHED_BATCH-kind-of-thing a standard in Unices or
>>general operating system engineering know-how? Or is this concept only
>>available for Linux?
> 
> 
> Fairly standard in Unices but prone to all sorts of priority inversion 
> starvation scenarios so very few implement it. In freebsd for example you can 
> use their idle scheduling only if you are root to prevent this starvation - 
> which kind of makes it useless in practice. My implementation is fairly 
> robust at avoiding the priority inversion problem - at least I haven't seen a 
> bug report about it for years since I address it :)
> 

FYI, the 6.1.6 version of PlugSched for 2.6.15-rc5-mm2 that I announced 
yesterday applies the same SCHED_BATCH semantics as Ingo's patch to the 
ingosched, nicksched, zaphod and spa_ws schedulers (i.e. it suppresses 
interactive bonuses for tasks in the SCHED_BATCH policy class).  As 
spa_no_frills and spa_svr do not have interactive bonuses there is no 
change to their semantics.  The staircase scheduler in PlugSched will be 
updated to the same SCHED_BATCH as the stand alone version in due course.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
