Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUHKAqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUHKAqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267858AbUHKAqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:46:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267856AbUHKAqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:46:02 -0400
Date: Tue, 10 Aug 2004 17:43:29 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: efocht@hpce.nec.com, pj@sgi.com, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040810174329.78cb519f.pj@sgi.com>
In-Reply-To: <2447730000.1091976606@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<200408071722.36705.efocht@hpce.nec.com>
	<2447730000.1091976606@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding ckrm-tech to the cc list, as per Hubertus' request
  yesterday to include ckrm-tech on replies to this cpuset
  thread on lkml when the reply raises CKRM issues. - pj]

Martin wrote:
> both [CKRM and cpusets] are mechanisms for controlling the amount
> of CPU time and memory that processes get to use.  They have fundamentally
> the same objective ... having 2 mechanisms to do the same thing with
> different interfaces doesn't seem like a good plan.

No.

See further my long reply on this thread about 12 hours ago.

Cpusets and CKRM are profoundly different, in purpose, approach
and applicability.

  * The purpose of CKRM is to better manage sharing resources.
    The purpose of cpusets is to isolate resources.

  * The approach of CKRM is to classify, measure and meter the
    use of shared cycles, bits and bandwidth.  The approach of
    cpusets is to setup isolation areas so as to avoid sharing.

  * Their respective areas of useful application have no overlap
    whatsoever that I have yet found.


My understanding (such as it is) of CKRM agrees with what you suggest,
that it measures and meters the use of such shared commodity resources
as cycles, bits and bandwidth.  I understand that it does this in order
to provide for explicitly managed Quality of Service levels or
"classes", to various distinguished system uses or users.

The essential purpose of CKRM is to manage the ** sharing ** of such
resources in a more controlled fashion on a shared resource system.

Cpusets defines compute (cpu and memory) subsets of large SMP and NUMA
systems.  These subsets are first-class, named objects wth vfs-style
access control.

The essential purpose of cpusets is to provide ** isolated ** compute
resources for dedicated jobs.  The existing sched_setaffinity (for CPUs)
and mbind/set_mempolicy (for Memory) calls provide some of the
mechanisms needed.  The cpuset patch completes the kernel support
required for this.

One could make good use of CKRM on a uni-processor system, to better
manage the prioritization of transactions flowing through a complex
service application.  Cpusets are utterly useless on uni-processor
systems.

On the other hand, one could imagine (_easily_ so, if you had my
customer base ;) running a couple of big computational jobs, each on a
dedicated cpuset of dozens or hundreds of CPUs and Nodes, where CKRM
would provide no value (less than zero value - a waste of critical
cycles ;).

Please do not confuse CKRM with cpusets.

They are polar opposite approaches to some of the problems of shared
resource systems - one refines the sharing, the other avoids it.

By now, I trust you know which is which.

Thank-you.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
