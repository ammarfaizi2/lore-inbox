Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTAaWih>; Fri, 31 Jan 2003 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbTAaWih>; Fri, 31 Jan 2003 17:38:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262821AbTAaWif>;
	Fri, 31 Jan 2003 17:38:35 -0500
Message-Id: <200301312247.h0VMlxB09932@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] OSDL-DBT-2 - 2.4 vs 2.5 4-way/8-way with vmstat 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Fri, 31 Jan 2003 14:13:50 PST." <20030131141350.370c287a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Jan 2003 14:47:59 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> > http://www.osdl.org/projects/dbt2dev/results/8way/LKML2/data/296/vmstat.out
> 
> That's progress, thanks.
> 
> It is useful to show the collection interval of vmstat in the reports.  Is
> that `vmstat 1' or `vmstat 1000'?

vmstat interval is 60 seconds, you are right, we'll fix the report. 
> 
> This workload appears to be performing concurrent disk reads and writes.  If
> these are _really_ happening at the same time (ie: if vmstat hasn't confused
> me) then it could well be the case that the throughput improvement comes from
> the I/O scheduler's tendency to service reads more promptly when there is a
> lot of writeback happening.

Re concurrent IO:
The offical answer from the dba's: "Well, it tries" 
There are multiple user proccessess doing queries and commits. 
There should be a difference between the cached and non-cached runs, as 
the cached runs should not be doing much writing, except to the log device.

Every 10 minutes in all workloads, the database flushes cache to the 
datafiles,
which should produce a noticeable peak in activity. 

These loads suck up all the memory they can, so anything that gives us more 
free memory should
be goodness. We think we are also seeing improvements in 2.5 in free memory, 
but
we don't know for sure where is best to look and how best to prove it. 
Any advice?
> 
> If so then you can expect to see wild swings in results as you wend your way
> through recent 2.5 kernels :(.  I'm working on settling that all down. 
> 2.5.59-mm7 should do well.
> 
Hopefully we can get some results for you on that kernel. 
cliffw

