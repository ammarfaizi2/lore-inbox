Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUIXBVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUIXBVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUIXBVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:21:35 -0400
Received: from ozlabs.org ([203.10.76.45]:24462 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267661AbUIXBUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:20:25 -0400
Date: Fri, 24 Sep 2004 11:17:51 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Paul Jackson <pj@sgi.com>, simon.derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
Message-ID: <20040924011751.GA20592@krispykreme>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr> <20040911010808.2b283c9a.pj@sgi.com> <Pine.LNX.4.58.0409231238350.11694@server.home> <20040923164139.506d65d3.pj@sgi.com> <Pine.LNX.4.58.0409231651550.17168@server.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409231651550.17168@server.home>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> > But the jist of the matter is simple.  Just as we (SGI) did with
> > cpumemsets and perfmon on 2.4 kernels, so should we do with cpusets and
> > perfmon on 2.6 kernels.  And that is to perform this translation in
> > perfmon code.  Is it only SGI's dplace that requires the cpuset-relative
> > numbering?
> 
> pfmon, sched_setaffinity, dplace. And this is only what I saw today.
> Might develop into a longer list. The 2.4 solutions were rather
> complicated.

Are pfmon and dplace SGI specific? sched_affinity users already have to
deal with potentially discontiguous cpu maps. Ive been teaching IBM
applications about this fact as I find problems.

> > The kernel-user boundary should stick to a single, system-wide, numbering
> > of CPUs.
> 
> That leads to lots of complicated scripts doing logical -> physical
> translation with the danger of access or attempting accesses to not
> allowed CPUs. It may be easier to contain tasks into a range of cpus if
> the CPUs in use are easily enumerable.

I would think you could write this in your userspace library.

> The patch would allow the use of the existing tools as if the machine
> only had N cpus (as you said a soft partitioning of the machine). If
> scripts are to be used with the current approach then they need to know
> about all the CPUs in the system and perform the mapping. Its going to be
> a nightmare to develop scripts that partition off a 512 cpu cluster
> appropriately and that track the physical cpu numbers instead of the cpu
> number within the cpuset.

What happens when an application (or user) looks in /proc/cpuinfo?
And how does /sys/.../cpus match? Also what happens when you hotplug out 
a cpu and your memory map becomes discontiguous? 

Anton
