Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSFUF0n>; Fri, 21 Jun 2002 01:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSFUF0n>; Fri, 21 Jun 2002 01:26:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7790 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316243AbSFUF0m>; Fri, 21 Jun 2002 01:26:42 -0400
To: Sandy Harris <pashley@storm.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
	<m1d6umtxe8.fsf@frodo.biederman.org>
	<20020619222444.A26194@work.bitmover.com> <3D11F7B9.27C74922@storm.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jun 2002 23:16:32 -0600
In-Reply-To: <3D11F7B9.27C74922@storm.ca>
Message-ID: <m1znxprz2n.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris <pashley@storm.ca> writes:

> [ I removed half a dozen cc's on this, and am just sending to the
>   list. Do people actually want the cc's?]
> 
> Larry McVoy wrote:
> 
> > > Checkpointing buys three things.  The ability to preempt jobs, the
> > > ability to migrate processes,

 
> For large multi-processor systems, it isn't clear that those matter
> much. 

The systems that are built because there is no machine that can
run your compute intensive application fast enough they matter quite
a bit.
 
> What combination of resources and loads do you think preemption
> and migration are need for?

Good answers have already been given.
The problem domain I am looking at are compute clusters.  The
solutions are useful elsewhere but in compute clusters they are
extremely valuable.

> > > and the ability to recover from failed nodes, (assuming the 
> > > failed hardware didn't corrupt your jobs checkpoint).
> 
> That matters, but it isn't entirely clear that it needs to be done
> in the kernel. 

I agree, glibc would be fine, but it must be below the level of
the application.   Generally it is a pretty onerous task to checkpoint 
a random program.  For a proof attempt to checkpoint your X desktop,
the infrastructure is there to do it.  

Every application must be capable of checkpointing it for the cluster
batch scheduler to take advantage of it.

Example case.
[Preemption]
You start job 1, a compute intensive application that runs for 4 days,
on 100 cpus.  Your job is low priority.

In comes job2, a high priority job that runs for 4 hours and needs 256
cpus.

job1 is preempted.  With checkpoint support it can be saved and
restarted later.  Without checkpointing support it is simply killed.

[Migration]
Migration is needed for failing hardware or to get low priority jobs
out of the way onto less capable nodes that are going unused.

Or to restart a job that failed on other hardware.

Eric
