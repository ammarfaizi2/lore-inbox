Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWEVFi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWEVFi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWEVFi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:38:26 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:5445 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932453AbWEVFiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:38:25 -0400
Message-ID: <44714E4F.8000801@bigpond.net.au>
Date: Mon, 22 May 2006 15:38:23 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl>	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>	 <200605221243.54100.kernel@kolivas.org> <1148267426.21765.15.camel@homer>	 <4471305F.40105@bigpond.net.au> <1148273580.9914.3.camel@homer>
In-Reply-To: <1148273580.9914.3.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 22 May 2006 05:38:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Mon, 2006-05-22 at 13:30 +1000, Peter Williams wrote:
>> What about the batch tasks?  How do you ensure that they don't get 
>> starved?  Remember they're "batch" tasks not "background" tasks.
>>
> 
> Here, batch means background.  To make them batch as in only static
> priority, I'd just do away with the second array.  Batch as background
> makes more sense to me, and since it's my ball and my playground... ;-)
> 

In reality, both batch and background are useful distinct concepts.  I 
think of a batch task as one that needs to be treated fairly (in 
accordance with its nice value) but for which fairness shouldn't be 
broken to give it a boost as you might for an interactive task or media 
streamer.  I.e. doing useful work but not interactive or a media 
streamer and the occasional long latency isn't a disaster.

Background tasks are ones where you don't care if they ever get any cpu 
:-) except as necessary to prevent priority inversion.

In my schedulers I generalize background to "soft cpu rate caps" with a 
cap of zero being the same as background.  I have patches to add both 
soft and hard cpu rate caps to the standard scheduler but I'm sitting on 
them until things settle down a bit.

Anyway, schedulers based on single priority arrays (such as staircase) 
are looking more attractive every day.  :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
