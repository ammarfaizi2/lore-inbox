Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSFTScZ>; Thu, 20 Jun 2002 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSFTScY>; Thu, 20 Jun 2002 14:32:24 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:60053 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315417AbSFTScT>; Thu, 20 Jun 2002 14:32:19 -0400
Date: Thu, 20 Jun 2002 13:32:20 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206201832.NAA87254@tomcat.admin.navo.hpc.mil>
To: nleroy@cs.wisc.edu, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
       pashley@storm.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
In-Reply-To: <200206201743.g5KHhPu31957@schroeder.cs.wisc.edu>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick LeRoy <nleroy@cs.wisc.edu>:
> 
> On Thursday 20 June 2002 12:23 pm, Jesse Pollard wrote:
> <snip>
> > You don't use compute servers much? The problems we are currently running
> > require the cluster (IBM SP) to have 100% uptime for a single job. that
> > job may run for several days. If a detected problem is reported (not yet
> > catastrophic) it is desired/demanded to checkpoint the users process.
> >
> > Currently, we can't - but should be able to by this fall.
> >
> > Having the users job checkpoint midway in it's computations will allow us
> > to remove a node from active service, substitute a different node, and
> > resume the users process without losing many hours of computation (we have
> > a maximum of 300 nodes for computation, another 30 for I/O and front end).
> 
> Have you tried Condor?  Condor is a "high throughput computing" package, 
> specifically targetted at such applications, with the ability to checkpoint & 
> migrate jobs, etc.  Condor is free as in beer, but currently not as in speech 
> (sorry), and is developed by the University of Wisconsin.  
> http://www.condorproject.org is the URL to learn more.  Version 6.4.0 is in 
> the process of being released and should be available within the next couple 
> of days.
> 
> Condor runs on Linux (x86 & Alpha), Solaris, IRIX, HPUX, Digital Unix, and 
> NT, although the NT usually lags the Unix releases.

Condor is designed for a relatively low performance network (10-100Mbit) and
not for things like an IBM SP switch which can carry Gbit data. It needs
availablility on SP-3/4 and Cray SV systems (not that we have problems
with checkpoint there). Also note:

	Cannot use IPC (pipes shared memory), which also leave out PVM/MPI
	job cannot use threads
	cannot use forks

In many of our cases, the jobs are split across many nodes, then spread
across multiple processors in a single node (SP 3 has 4 cpus per node,
SP 4 will have 8-32). The current scientific library uses PVM/MPI to determine
whether it is using shared memory or node/node RPC.

Tightly integrated models wouldn't work well with Condor (disclaimer:
based on a fast look by me, and I don't work on the current jobs).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
