Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUEXWBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUEXWBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEXWBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:01:46 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:12322 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263831AbUEXWBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:01:30 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Andi Kleen <ak@muc.de>, "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Date: Mon, 24 May 2004 17:00:57 -0500
User-Agent: KMail/1.5
Cc: brettspamacct@fastclick.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <1Y6yr-eM-11@gated-at.bofh.it> <1085272089.25212.6.camel@obsidian.pathscale.com> <20040523142806.GA33866@colin2.muc.de>
In-Reply-To: <20040523142806.GA33866@colin2.muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405241700.57249.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 May 2004 09:28, Andi Kleen wrote:
> On Sat, May 22, 2004 at 05:28:09PM -0700, Bryan O'Sullivan wrote:
> > On Fri, 2004-05-21 at 16:42, Brett E. wrote:
> > > Right now, 5 processes are running taking up a good deal of the CPU
> > > doing memory-intensive work(cacheing) and I notice that none of the
> > > processes seem to have CPU affinity.
> >
> > I don't know what kind of system you're running on, but if it's a
> > multi-CPU Opteron, it is normally a sufficient fudge to just use
> > sched_setaffinity to bind individual processes to specific CPUs.  The
> > mainline kernel memory allocator does the right thing in that case, and
> > allocates memory locally when it can.
> >
> > You can use the taskset command to get at this from the command line, so
> > you may not even need to modify your code.
>
> Linus also merged the NUMA API support into mainline now with 2.6.7rc1, so
> you can use numactl for more finegrained tuning.

FYI Brett, some Opteron systems have a BIOS option to interleave memory.  If 
you are going to make use of NUMA, I think you want to not interleave.

Also, if you have a 25% imbalance within a domain/node, the scheduler can have 
a tendency to bounce around a task for fairness.  That might be why you are 
seeing little/no affinity to a cpu (even top might be causing some of this).   
Not sure what the threshold is between domains/nodes, but I am curious if it 
still happens with CONFIG_NUMA on.  If these are long lived cpu bound 
processes, I would try to have the number of processes be a multiple of the 
number of cpus.

-Andrew Theurer
