Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUHKOvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUHKOvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUHKOve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:51:34 -0400
Received: from jade.spiritone.com ([216.99.193.136]:18856 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268074AbUHKOvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:51:04 -0400
Date: Wed, 11 Aug 2004 07:49:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>
cc: Paul Jackson <pj@sgi.com>, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <10920000.1092235770@[10.10.2.4]>
In-Reply-To: <200408111140.14466.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408071722.36705.efocht@hpce.nec.com> <2447730000.1091976606@[10.10.2.4]> <200408111140.14466.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My turn to disagree ;-) CKRMs CPU and memory controller are not
> NUMA-specific, they are usefull on non-NUMA machines as well. Their

Neither is cpusets - doing resource control is pretty much the same
problem on SMP as NUMA. So I don't really see your point.

> aim is to share cpu cycles and memory pages among processes in a fair
> way. The amount of cycles and memory pages you get is flexible. If
> noone else is on the machine, you get the full machine. If someone
> else comes with another job, your stuff gets pushed away. Cpusets
> guarantee that you get exclusive use of exactly the piece of machine
> which you want. This way your run times will be reproducible and other
> users just won't disturb you. With the current CKRM cpu/mem
> controllers you can say: this set of processes should get 25% of the
> cycles and memory. This is a soft limit (can be violated) and doesn't
> imply where the CPUs are and which memory blocks (cells/nodes) in the
> machine you use. It's of no use for a customer who wants reproducible
> compute times (and I don't mean minimal, or guaranteed. I mean same
> time for each run, within minimal error margins) and no interference
> between users. I'm sure many might question these objectives. I assure
> you that they are taken from real life and are very important.
> 
> As Paul explained in a previous email: the scope of cpusets is
> orthogonal to that of the current CKRM CPU/mem controllers. I see
> benefit in combining the two, within one cpuset one can run several
> processes and protect them from starving.

Right ... the problems you're attacking aren't *exactly* the same - but
they're still close enough, that especially when programming them in
combination, it seems silly to have 2 separate interfaces. 

> The implementation of CKRM cpu/mem and cpusets is as different as
> their scope. I doubt CKRM can be just easilly extended to replicate
> cpusets functionality. Just adding cpus_allowed will not be enough. In
> the end CKRM will need to rebuild all code in the cpusets patch.

Perhaps the main thing that ends up shared would be the interface - and
I agree that adding cpus_allowed is wholly insufficient. However, I think
it's foolish to go ahead and press one resource control method interface
into the kernel without carefully considering the possibilities for a
unified interface first - this is important to get right ... interfaces
are too hard to change afterwards (see current discussion re libnuma
for a perfect example).
 
>> I don't think CKRM is anything like as far away from being ready as
>> you seem to be implying - we're talking about a month or two, I
>> think.
> 
> Shailab's email shows that we're talking about several months. He also
> agreed with pushing cpusets towards the -mm tree.

That's up to Andrew ... but personally I'd rather see the interface issues
thrashed out first. My real concern is that it doesn't go into mainline or
a distro yet, but quite frankly, another couple of weeks isn't going to 
kill anyone, so I don't see the point.

M.
