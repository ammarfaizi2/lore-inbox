Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSGSU0O>; Fri, 19 Jul 2002 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSGSU0O>; Fri, 19 Jul 2002 16:26:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3737 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317017AbSGSU0N>;
	Fri, 19 Jul 2002 16:26:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Gang Scheduling in linux
Date: Fri, 19 Jul 2002 15:25:40 -0400
User-Agent: KMail/1.4.1
Cc: shreenivasa H V <shreenihv@usa.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201858180.17247-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207201858180.17247-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207191525.40633.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 July 2002 12:59 pm, Ingo Molnar wrote:
> On Fri, 19 Jul 2002, Hubertus Franke wrote:
> > For this it seems sufficient to simply STOP apps on a larger granularity
> > and have that done through a user level daemon. The kernel scheduler
> > simply schedules the runnable threads that given the U-Sched would
> > always amount to a limited number of threads/tasks.
>
> yep, this is my suggestion as well. Any reason to do gang scheduling in
> the scheduler and not via a userspace daemon that stops/resumes (and
> binds) managed tasks explicitly?
>
> 	Ingo

Not from our experience from a cluster based application. Each node was 
a SMP in that case.

On a single SMP I could imagine for instance for parallel reendering
or similar tightly integrated parallel programs that need data 
synchronization.  Most of these apps assume a tightly coupled non-virtual
resource, i.e., scheduling of tasks is aligned.

SGI used to have that stuff in their base kernel. Read a paper about this some 
years ago.
Again, at the beginning I'd go with a user level scheduler approach that 
certainly would satisfy national labs etc. Most of the cluster schedulers, 
like PBS and LoadLeveler etc., already provide that functionality.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
