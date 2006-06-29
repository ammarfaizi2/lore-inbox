Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWF2AZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWF2AZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWF2AZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:25:17 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:47749 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751841AbWF2AZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:25:15 -0400
Message-ID: <44A31DE8.20100@bigpond.net.au>
Date: Thu, 29 Jun 2006 10:25:12 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Incorrect CPU process accounting using         CONFIG_HZ=100
References: <200606211716.01472.a1426z@gawab.com> <200606272302.16950.kernel@kolivas.org> <44A1C4D4.3080805@bigpond.net.au> <200606282306.14498.a1426z@gawab.com> <44A30F60.6070001@bigpond.net.au> <cone.1151538362.930767.14982.501@kolivas.org>
In-Reply-To: <cone.1151538362.930767.14982.501@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 29 Jun 2006 00:25:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Peter Williams writes:
> 
>> Al Boldi wrote:
>>> Peter Williams wrote:
> 
>>> twice:
>>>     1. for external proc monitoring, using a probed approach
>>>     2. for scheduling, using an inlined approach
>>
>> Not exactly (e.g. there's no separation between user and sys time 
>> available in line) but the possibilities are there.
>>
>>>
>>> Wouldn't merging the two approaches be in the interest of conserving 
>>> cpu resources, while at the same time reflecting an accurate view of 
>>> cpu utilization?
>>
>> I think that this would be a worthwhile endeavour once/if 
>> sched_clock() is fixed.  This is especially the case as CPUs get 
>> faster as many tasks may run to completion in less than a tick.
> 
> That may not be as simple as it seems. To properly account system v user 
> time using the sched_clock we'd have to hook into arch dependant asm 
> code to know when entering and exiting kernel context. That is far more 
> invasive than the simple on/off runqueue timing we currently do for 
> scheduling accounting.

Yes, it is a problem and we may have to do something approximate like 
counting ticks for sys time and subtracting that from the total to get 
user time when reporting the times to user space (only a bit more 
complex to make sure we don't end up with negative times).

How is it intended to handle this problem in the tickless kernel?

Peter
PS It's all moot until sched_clock() is fixed anyway.
PPS Recent kernels (-mm ones at least) keep a sched_time in nsecs for 
each task but I've no idea what it's used for.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
