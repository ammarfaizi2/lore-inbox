Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTAQVOP>; Fri, 17 Jan 2003 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTAQVOP>; Fri, 17 Jan 2003 16:14:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261353AbTAQVON>;
	Fri, 17 Jan 2003 16:14:13 -0500
Message-Id: <200301172123.h0HLNBd19275@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: [OSDL][BENCHMARK] Database results 2.4 versus 2.5 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Fri, 17 Jan 2003 13:00:46 PST." <20030117130046.0f73d6d6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 13:23:11 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> > 
> > We have found some very nice database performance improvements in the
> > OSDL-DBT-2 database workload comparing the latest 2.4 kernel with 2.5.49
> > on a 8-way Profusion Xeon 700MHz Pentium III system with 4GB of memory.
> > We suspect there will be I/O improvements after moving to the latest
> > 2.5 releases.  We would like to optimize our memory utilization before
> > moving on to those experiments.
> 
> So it sounds like DBT2 is stabilised now, and producing repeatable results? 
> That's excellent.
Thanks. the kit's available off Sourceforge now, and we'll have STP version 
up Mondayish. 
> 
> > ...
> > We did several runs of each variant (cached and non-cached) on each of
> > the two OS versions (2.4.21-pre3 and 2.5.49*).  Run variances were low
> > compared to the differences we saw between OS versions.  Results are as
> > follows (numbers represent average over the runs):
> 
> I notice you're using an extremeraid 2000?  I have one of those, and
> immediately shelved it when I saw how slow it is ;)

We'll take that one up with our ops people ;) This is one of the many
reasons we did a 'cached' version of the load. Us database people just
can't get enough IO right now. :)
> 
> > 
> > Linux       DBT2      Metric  Wrkld %memused            iostats
> > Version     Workload (bigger Speedup on4GB   %user %sys  total
> >                       better)                            iops
> > ___________________________________________________________________
> > 2.4.21-pre3 cached     4479          99.73    74.24 3.64  **     
> > 2.5.49 (*)  cached     5040          99.73    85.37 2.85  381   
> >             cached            12.5%     
> > ___________________________________________________________________     
> > 2.4.21-pre3 noncached  1407.8        95.11    25.75 9.68   **
> > 2.5.49 (*)  noncached  1667.5        99.68    49.12 7.2   1461          
> >            non-cached        18.4%      
> > ___________________________________________________________________
> > ** iostats is broken at 2.4 due to driver problems.  
> 
> Interesting.  All the gains here are due to reduced idle time.
> 
> So either the I/O scheduler is doing a better job, or the VM page
> replacement decisions are agreeable for this load.

Okay. Is there something we could do that would point at one or the other?

> 
> > The %sys drops going from 2.4 to 2.5 in both cases.  We suspect this is
> > due to lack of paging in the 2.5 runs.
> 
> Yup.  Do you have all the vmstat traces and all the other goodies?  The
> pgpgin/pgpgout numbers, etc seem to be wrong there.

We didn't have a working vmstat for those runs. We just grabbed the latest 
procps,
so we should have that data for the next set. What looks wrong to you on the 
pgpgin/pgpgout?
> 
> 
> This could easily be a complete fluke, and you may find that with
> smaller/larger working sets or smaller/larger physical memory, the difference
> goes away.
> 
We're doing a series of runs with some slightly different memory sizes. STP 
will allow
you to do the same. We normally try to tune the run so as to use all of the 
physical
memory we can get our little hands on (it's a DBA thang) - would a smaller 
memory
database (say 2GB instead of 4GB ) really show you anything interesting on a 
4GB system,
since there's so little pressure? 

cliffw
> 


