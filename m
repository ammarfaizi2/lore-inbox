Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVLaNoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVLaNoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 08:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVLaNoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 08:44:18 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:57809 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751333AbVLaNoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 08:44:18 -0500
Message-ID: <43B68B2A.7080208@bigpond.net.au>
Date: Sun, 01 Jan 2006 00:44:10 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<200512281027.00252.kernel@kolivas.org>	<20051230145221.301faa40@localhost>	<43B5E78C.9000509@bigpond.net.au>	<20051231113446.3ad19dbc@localhost> <20051231115213.4a2e01ba@localhost>
In-Reply-To: <20051231115213.4a2e01ba@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 31 Dec 2005 13:44:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Sat, 31 Dec 2005 11:34:46 +0100
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
> 
>>>It is a patch against the 2.6.15-rc7 kernel and includes some other 
>>>scheduling patches from the -mm kernels.
>>
>>Yes, this fixes both my test-case (transcode & little program), they
>>get priority 25 instead of ~16.
>>
>>But the priority of DD is now ~23 and so it still suffers a bit:
> 
> 
> I forgot to mention that even the others "interactive" processes
> don't get a good priority too.
> 
> Xorg for example, while only moving the cursor around, gets priority
> 23/24. And when cpu-eaters are running (at priority 25) it isn't happy
> at all, the cursor begins to move in jerks and so on...
> 

OK.  This probably means that the parameters that control the mechanism 
need tweaking.

There should be a file /sys/cpusched/attrs/unacceptable_ia_latency which 
contains the latency (in nanoseconds) that the scheduler considers 
unacceptable for interactive programs.  Try changing that value and see 
if things improve?  Making it smaller should help but if you make it too 
small all the interactive tasks will end up with the same priority and 
this could cause them to get in each other's way.

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
