Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUCaVZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUCaVZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:25:52 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:51627 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262541AbUCaVXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:23:17 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Wed, 31 Mar 2004 23:23:00 +0200
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <1750000.1080658863@[10.10.2.4]>
In-Reply-To: <1750000.1080658863@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403312323.00944.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 17:01, Martin J. Bligh wrote:
> > I don't think it's worth to wait and hope that somebody shows up with
> > a magic algorithm which balances every kind of job optimally.
>
> Especially as I don't believe that exists ;-) It's not deterministic.

Right, so let's choose the initial balancing policy on a per process
basis.

> > Benchmarks simulating "user work" like SPECsdet, kernel compile, AIM7
> > are not relevant for HPC. In a compute center it actually doesn't
> > matter much whether some shell command returns 10% faster, it just
> > shouldn't disturb my super simulation code for which I bought an
> > expensive NUMA box.
>
> OK, but the scheduler can't know the difference automatically, I don't
> think ... and whether we should tune the scheduler for "user work" or
> HPC is going to be a hotly contested point ;-) We need to try to find
> something that works for both. And suppose you have a 4 node system,
> with 4 HPC apps running? Surely you want each app to have one node to
> itself?

If the machine is 100% full all the time and all apps demand the same
amount of bandwidth, yes, I want 1 job per node. If the average load is
less than 100% (sometimes only 2-3 jobs are running) then I'd prefer to
spread the processes of a job across the machine. The average bandwidth
per process will be higher. Modern NUMA machines have big bandwidth to
neighboring nodes and not too bad latency penalties for remote accesses.

Regards,
Erich

