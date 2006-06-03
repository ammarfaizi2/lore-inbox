Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWFCADO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWFCADO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWFCADO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:03:14 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:37560 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751572AbWFCADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:03:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Sat, 3 Jun 2006 10:02:50 +1000
User-Agent: KMail/1.9.3
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000501c68698$06378290$df34030a@amr.corp.intel.com>
In-Reply-To: <000501c68698$06378290$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031002.51199.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 08:58, Chen, Kenneth W wrote:
> You haven't answered my question either.  What is the benefit of special
> casing the initial stage of cpu resource competition?  Is it quantitatively
> measurable?  If so, how much and with what workload?

Ah you mean what the whole point of smt nice is? Yes it's simple enough to do. 
Take the single hyperthreaded cpu with two cpu bound workloads. Let's say I 
run a cpu bound task nice 0 by itself and it completes in time X. If I boot 
it with hyperthread disabled and run a nice 0 and nice 19 task, the nice 0 
task gets 95% of the cpu and completes in time X*0.95. If I boot with 
hyperthread enabled and run the nice 0 and nice 19 tasks, the nice 0 task 
gets 100% of one sibling and the nice 19 task 100% of the other sibling. The 
nice 0 task completes in X*0.6. With the smt nice code added it completed in 
X*0.95. The ratios here are dependent on the workload but that was the 
average I could determine from comparing mprime workloads at differing nice 
and kernel compiles. There is no explicit way on the Intel smt cpus to tell 
it which sibling is running lower priority tasks (sprinkling mwaits around at 
regular intervals is not a realistic option for example).

-- 
-ck
