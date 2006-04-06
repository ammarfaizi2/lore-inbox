Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWDFCOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWDFCOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWDFCOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:14:41 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:20323 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932073AbWDFCOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:14:40 -0400
Message-ID: <4434798D.8080202@bigpond.net.au>
Date: Thu, 06 Apr 2006 12:14:37 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice loadbalancing with high priority tasks
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060403172408.A31895@unix-os.sc.intel.com> <4431CA4F.3020304@bigpond.net.au> <20060403191122.B31895@unix-os.sc.intel.com> <4431E6D7.2060604@bigpond.net.au>
In-Reply-To: <4431E6D7.2060604@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 6 Apr 2006 02:14:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Siddha, Suresh B wrote:
>> do we then really need smpnice complexity?
> 
> Most people who express unhappiness with SMP and nice are looking at the 
> other end of the problem i.e. they nice 19 a process to make it run in 
> the background but it gets a CPU to itself while a couple nice 0 tasks 
> have to share the other CPU.  The high priority case has to be 
> considered as well (e.g. one high priority task and one normal priority 
> task running on a 2 CPU machine with a CPU each when another task wakes 
> -- you'd like that to end up on the CPU of the normal priority task not 
> the one with the high priority task, etc.) but its effects are more 
> likely to be transitory and high priority tasks would not be expected to 
> have a long term effect on balancing.

Another advantage of smpnice load balancing that I failed to point out 
is that it increases the chances that the tasks at the head of the 
queues within a HT package are approximately the same priority.  This, 
in turn, reduces the probability that it will be necessary to force one 
of the channels to idle and this will tend to increase the overall 
system throughput.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
