Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUJCOPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUJCOPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUJCOPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 10:15:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62897 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267953AbUJCOP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 10:15:28 -0400
Date: Sun, 3 Oct 2004 07:11:45 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, frankeh@watson.ibm.com, mef@CS.Princeton.EDU,
       nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041003071145.62fbf4a3.pj@sgi.com>
In-Reply-To: <20041002192603.5a580a44.pj@sgi.com>
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
	<415ED4A4.1090001@watson.ibm.com>
	<20041002134059.65b45e29.akpm@osdl.org>
	<20041002192603.5a580a44.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> It's a requirement, I say.  It's a requirement.  Let the slapping begin ;).

Granted, to give Andrew his due (begrudgingly ;), the requirement
to pin processes on CPUs is a requirement of the _implementation_,
which follows, for someone familiar with the art, from the two
items:
  1) The requirement of the _user_ that runtimes be repeatable
     within perhaps 1% to 5% for a certain class of job, plus
  2) The cantankerous properties of big honkin NUMA boxes.

Clearly, Andrew was looking for _user_ requirements, to which I
managed somewhat unwittingly to back up in my user case scenario.


I suspect that there is a second user case scenario, with which the Bull
or NEC folks might be more familiar with than I, that can seemingly lead
to the same implementation requirement to pin jobs.  This scenario would
involve a customer who has paid good money for some compute capacity
(CPU cycles and Memory pages) with a certain guaranteed Quality of
Service, and who would prefer to see this capacity go to waste when
underutilized rather than risk it being unavailable in times of need.

However in this case, as Andrew is likely already chomping at the bit to
tell me, CKRM could provide such guaranteed compute capacities without
pinning.

Whether or not a CKRM class would sell to the customers of Bull and
NEC in lieu of a set of pinned nodes, I have no clue.

  Erich, Simon - Can you introduce a note of reality into my
		 speculations above?


The third user case scenario that commonly leads us to pinning is
support of the batch or workload managers, PBS and LSF, which are fond
of dividing the compute resources up into identifiable subsets of CPUs
and Memory Nodes that are near to each other (in terms of the NUMA
topology) and that have the size (compute capacity as measured in free
cycles and freely available ram) requested by a job, then attaching that
job to that subset and running it.

In this third case, batch or workload managers have a long history with
big honkin SMP and NUMA boxes, and this remains an important market for
them.  Consistent runtimes are valued by their customers and are a key
selling point of these products in the HPC market.  So this third case
reduces to the first, with its implementation requirement for pinning
the tasks of an active job to specific CPUs and Memory Nodes.

For example from Platform's web site (the vendor of LSF) at:
    http://www.platform.com/products/HPC
the benefits for their LSF HPC product include:
  * Guaranteed consistent and reliable parallel workload processing with
    high performance interconnect support
  * Maximized application performance with topology-aware scheduling
  * Ensures application runtime consistency by automatically allocating
    similar processors 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
