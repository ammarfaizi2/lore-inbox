Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUH0Tmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUH0Tmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUH0Tgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:36:45 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:48102 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267601AbUH0TfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:35:06 -0400
Date: Fri, 27 Aug 2004 14:31:34 -0500
From: John Hesterberg <jh@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Ragnar Kj?rstad <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040827193134.GA3706@sgi.com>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de> <20040827054218.GA4142@frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827054218.GA4142@frec.bull.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 07:42:18AM +0200, Guillaume Thouvenin wrote:
> On Thu, Aug 26, 2004 at 10:05:37PM +0200, Tim Schmielau wrote:
> > 
> > It should be easy to combine the data collection enhancements from
> > CSA and ELSA to provide a common superset of information.
> 
> ELSA uses current BSD accounting. The only difference with BSD is that
> accounting is done for a group of processes. I didn't use PAGG and
> rewrite something because I thought (I was wrong) that PAGG project
> wasn't maintained. I continue to maintain ELSA just because there is, 
> until today, no solution for doing job accounting. 
> So, the data collection enhancements from ELSA is not very useful.
> 
> > With the new BSD acct v3 format, it should be possible to do per job
> > accounting entirely from userspace, using pid and ppid information to
> > reconstruct the process tree and some userland database for the
> > pid -> job mapping. It would, however, be greatly simplified if the
> > accounting records provided some kind of job id, and some indicator
> > whether or not this process was the last of a job (group).
> 
> I like this solution.
> In fact what I proposed was to have PAGG and a modified BSD accounting
> that can be used with PAGG as both are already in the -mm tree. But
> manage group of processes from userspace is, IMHO, a better solution as
> modifications in the kernel will be minimal. 

The kernel part of linux-job is a module that uses PAGG, and 
isn't difficult.  We've been running it in production for a
couple years.

I don't think a kernel-based job is a requirement, though,
so I'd like to hear more about how you'd do it otherwise.

The other comments about only one acct record per job vs one
per process might be important, and that might mean the kernel
has to know about the job.

>   Therefore the solution could be to enhance BSD accounting with data
> collection from CSA and provide per job accounting with a userspace
> mechanism. Sounds great to me... 
> 
> Best,
> Guillaume

How does the BSD accounting define jobs?
What determines the job that a process is part of?

An important aspect of linux-job (ie the job part of the pagg/job/csa
stack) is that it is inescapable.  The user doesn't get to determine or
change their job (unlike process groups).  For true accounting, that
determines the real $$$ chargebacks on shared machines, this is
necessary.

Another aspect of jobs that isn't directly related to accounting
is that it gives users and admins a way to query, and kill :-),
all the processes that are part of the job.  The inescapable part
is again important...you can't fork off a process and detach it from
the job to hide it.  In fact, I've heard that some sites use pagg/job
without CSA for this reason.  It might have been an ISP or ASP, and
they liked the containment linux-job provided.

John
