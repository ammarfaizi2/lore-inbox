Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSGSQGY>; Fri, 19 Jul 2002 12:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316864AbSGSQGY>; Fri, 19 Jul 2002 12:06:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28899 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316860AbSGSQGX>;
	Fri, 19 Jul 2002 12:06:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Ingo Molnar <mingo@elte.hu>, shreenivasa H V <shreenihv@usa.net>
Subject: Re: Gang Scheduling in linux
Date: Fri, 19 Jul 2002 11:05:57 -0400
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207191105.57814.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 01:40 pm, Ingo Molnar wrote:
> you are right in that the Linux scheduler does not enable classic
> gang-scheduling: where multiple processes are scheduled 'at once' on
> multiple CPUs. Can you point out specific (real-life) workloads where this
> would be advantegous? Some testcode would be the best form of expressing
> this. Pretty much any job that uses sane (kernel-based or kernel-helped)
> synchronization should see good throughput.
>
> 	Ingo
>
> -

Go to any of the national labs. 
I was involved in the gangscheduler implementation for the IBM 340 node SP2 
cluster at Lawrence Livermore National Lab.
Implementation aside, one can show that the total system utilization can be 
raised from ~60% to a ~90% when doing gang scheduling rather than FIFO 
scheduling, which one would otherwise do to get a dedicated machine.
We got tons of papers on this. 

For this it seems sufficient to simply STOP apps on a larger granularity and 
have that done through a user level daemon. The kernel scheduler simply 
schedules the runnable threads that given the U-Sched would always amount
to a limited number of threads/tasks.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
