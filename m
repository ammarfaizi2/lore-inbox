Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWBOAJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWBOAJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWBOAJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:09:38 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:1001 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750844AbWBOAJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:09:37 -0500
Message-ID: <43F2713E.3080204@bigpond.net.au>
Date: Wed, 15 Feb 2006 11:09:34 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: suresh.b.siddha@intel.com, akpm@osdl.org, kernel@kolivas.org,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <43ED3D6A.8010300@bigpond.net.au>	<20060214010712.B20191@unix-os.sc.intel.com>	<43F25C60.4080603@bigpond.net.au> <20060214154432.9a4f8a0c.pj@sgi.com>
In-Reply-To: <20060214154432.9a4f8a0c.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 15 Feb 2006 00:09:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Peter wrote:
> 
>>In these circumstances, moving the task 
>>to an idle CPU should be a "good thing" unless the time taken for the 
>>move is longer than the time that will pass before the task becomes the 
>>running task on its current CPU.
> 
> 
> Even then, it's not always a "good thing".
> 
> The less of the cache-memory hierarchy the two CPUs share, the greater
> the penalty to the task for memory accesses after the move.
> 
> At one extreme, two hyperthreads on the same core share essentially all
> the memory hierarchy, so have no such penalty.
> 
> At the other extreme, two CPUs at opposite ends of a big NUMA box have,
> so far as performance is concerned, quite different views of the memory
> hierarchy.  A task moved to a far away CPU will be cache cold for
> several layers of core, package, board, and perhaps router hierarchy,
> and have slower access to its main memory pages.

This will complicate things IF we end up having to introduce an "is it 
worth moving this particular task" test to move_tasks() in addition to 
the "cache hot" test.  E.g. "will it take longer for this task to do 
something useful on its new CPU than if we leave it here?" would 
obviously have to take into account any delay in accessing memory as a 
result of the move.  Hopefully it won't come to that :-).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
