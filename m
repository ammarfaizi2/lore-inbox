Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbUCYWbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUCYWbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:31:18 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:27370 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263683AbUCYWaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:30:39 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Thu, 25 Mar 2004 16:30:16 -0600
User-Agent: KMail/1.5
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325215908.GA19313@elte.hu>
In-Reply-To: <20040325215908.GA19313@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403251630.16485.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 March 2004 15:59, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> > It doesn't do load balance in wake_up_forked_process() and is
> > relatively non aggressive in balancing later. This leads to the
> > multithreaded OpenMP STREAM running its childs first on the same node
> > as the original process and allocating memory there. Then later they
> > run on a different node when the balancing finally happens, but
> > generate cross traffic to the old node, instead of using the memory
> > bandwidth of their local nodes.
> >
> > The difference is very visible, even the 4 thread STREAM only sees the
> > bandwidth of a single node. With a more aggressive scheduler you get 4
> > times as much.
> >
> > Admittedly it's a bit of a stupid benchmark, but seems to
> > representative for a lot of HPC codes.
>
> There's no way the scheduler can figure out the scheduling and memory
> use patterns of the new tasks in advance.
>
> but userspace could give hints - e.g. a syscall that triggers a
> rebalancing: sys_sched_load_balance(). This way userspace notifies the
> scheduler that it is on 'zero ground' and that the scheduler can move it
> to the least loaded cpu/node.
>
> a variant of this is already possible, userspace can use setaffinity to
> load-balance manually - but sched_load_balance() would be automatic.

For Opteron simply placing all cpus in the same sched domain may solve all of 
this, since we will have balancing frequency of the default scheduler.  Is 
there any reason this cannot be done for Opteron?

Also, I think Erich Focht had another patch which would allow much more 
frequent node balancing is the nr_cpus_node was 1.
