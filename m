Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUEWCuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUEWCuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 22:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEWCuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 22:50:04 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:16141 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262138AbUEWCtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 22:49:49 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <brettspamacct@fastclick.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "linux-kernel mailing list" <linux-kernel@vger.kernel.org>,
       <jbarnes@engr.sgi.com>
Subject: RE: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Date: Sat, 22 May 2004 19:49:37 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAENNMCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <40AE3BF5.5080804@fastclick.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 22 May 2004 19:27:39 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 22 May 2004 19:27:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let's say I have a 2 way opteron and want to run 4 long-lived processes.
>   I fork and exec to create 1 of the processes, it chooses to run on
> processor 0 since processor 1 is overloaded at that time, so its
> homenode is processor 0.  I fork and exec another, it chooses processor
> 0 since processors 1 is overloaded at that time. .. Let's say an uneven
> distribution is chosen for all 4 processes, with all processes mapped to
> processor 0. So they allocate on node 0 yet the scheduler will map these
> to both processors since CPU should be balanced. In this case, you will
> have a situation where the second processor will have to fetch memory
> from the other processor's memory.
>
> So a better solution would be to use numactl to set the homenodes
> explicitly, choosing processor 0 for 2 processes, processor 1 for the 2
> other processes.
>
> Is this incorrect?

	Generally, yes, it is. Surprisingly so. If you assume everything is
perfect, then this seems true. But in the real world, it almost never works
that way.

	Consider, for example, if process 1 is responsible for most of the memory
load at any particular time. If it's on CPU #1 and all its memory is on CPU
#1, then the memory controller on CPU #2 is underused and memory bandwidth
suffers. This is why most BIOSes interlave the memory pages across the CPUs.
This gives you the best chance of being able to use both memory controllers
under load.

	I don't think we've reached the point yet where treating x86-64 systems as
NUMA machines makes very much sense.

	DS


