Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262077AbSJNROn>; Mon, 14 Oct 2002 13:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbSJNROn>; Mon, 14 Oct 2002 13:14:43 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:32678 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262077AbSJNROl> convert rfc822-to-8bit; Mon, 14 Oct 2002 13:14:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [RFC] Simple NUMA scheduler patch
Date: Mon, 14 Oct 2002 19:19:03 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200210021954.39358.efocht@ess.nec.de> <200210051834.31031.efocht@ess.nec.de> <1034033845.1280.514.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1034033845.1280.514.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210141919.03812.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tuesday 08 October 2002 01:37, Michael Hohnbaum wrote:
> > I'll post some numbers comparing O(1), pooling scheduler, node affine
> > scheduler and RSS based affinity in a separate email. That should help
> > to decide on the direction we should move.
>
> One other piece to factor in is the workload characteristics - I'm
> guessing that Azusa is beng used more for scientific workloads which
> tend to be a bit more static and consumes large memory bandwidth.

Yes, I agree. We're trying to keep HPC tasks on their nodes because we
KNOW that they are memory bandwidth and latency hungry. Therefore I
believe HPC like jobs are good benchmarks. And easier to set up than
database tests (which can also demand very high bandwidths).

> > machine. For me that means the maximum memory bandwidth available for
> > each task, which you only get if you distribute the tasks equally among
> > the nodes.
>
> Depends on the type of job.  Some actually benefit from being on the
> same node as other tasks as locality is more important than bandwidth.
> I am seeing some of this - when I get better distribution of load across
> nodes, performance goes down for sdet and kernbench.

This is a difficult issue. Because we're trying to get higher
performance out of a multitude of benchmarks (ever tried AIM7? It never
execs... so good bye initial balancing). But we also try to find a
solution which is good for any kind of NUMA machine. Currently we
experiment on the very different architectures:
 - Azusa : remote/local latency ratio 1.6, but no node level cache
 - NUMAQ : remote/local latency ratio 20, additional node level cache.

My current approach to the tuning parameters for adapting to the
machine is over the steal delays. Yours is over the load imbalance
needed to trigger a steal from a remote node. Maybe we'll even need more
buttons to be able to make these fit to any NUMA machine...

Regards,
Erich


