Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSEMXFx>; Mon, 13 May 2002 19:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314583AbSEMXFw>; Mon, 13 May 2002 19:05:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61693 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314514AbSEMXFv>; Mon, 13 May 2002 19:05:51 -0400
Subject: Re: set_cpus_allowed() optimization
From: Robert Love <rml@tech9.net>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020510130903.B1544@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 May 2002 16:05:46 -0700
Message-Id: <1021331147.18799.2997.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n Fri, 2002-05-10 at 13:09, Mike Kravetz wrote: 
> Please consider the following optimization to set_cpus_allowed().
> In the case where the task does not reside on a runqueue, is it
> not safe/sufficient to simply set the task's cpu field?  This
> would avoid scheduling the migration thread to perform the task.
> 
> Previously, set_cpus_allowed() was always called for a task that
> resides on a runqueue.  With the introduction of the 'cpu affinity'
> system calls, this is no longer the case.

I like!  I agree, if the task is not runnable then it should be
sufficient to just set task->cpu as when it is activated it will be put
into the runqueue based on ->cpu.

There was a chance even without the CPU affinity runqueues a process
would dequeue before set_cpus_allowed returned.  Look at the case in
migration_thread where exactly what your patch does is done.  If !array,
then the code just sets task->cpu and returns.

Ingo?  Good?

	Robert Love

