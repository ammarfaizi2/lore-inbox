Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUHKJme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUHKJme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUHKJme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:42:34 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:38311 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268013AbUHKJmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:42:31 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Wed, 11 Aug 2004 11:40:13 +0200
User-Agent: KMail/1.6.2
Cc: Paul Jackson <pj@sgi.com>, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408071722.36705.efocht@hpce.nec.com> <2447730000.1091976606@[10.10.2.4]>
In-Reply-To: <2447730000.1091976606@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111140.14466.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 August 2004 16:50, Martin J. Bligh wrote:
> > If I understand correctly, CKRM is fine for simple resources like
> > amount of memory or cputime and designed to control flexible sharing
> > of these resources and ensure some degree of fairness. Cpusets is a
> > complex NUMA specific compound resource which actually only allows for
> > a rather static distribution across processes (especially with the
> > exclusive bits set). Including cpusets control into CKRM will be
> > trivial, because you already provide all that's needed.
> 
> I'd disagree with this - both are mechanisms for controlling the amount
> of CPU time and memory that processes get to use. They have fundamentally
> the same objective ... having 2 mechanisms to do the same thing with
> different interfaces doesn't seem like a good plan.

My turn to disagree ;-) CKRMs CPU and memory controller are not
NUMA-specific, they are usefull on non-NUMA machines as well. Their
aim is to share cpu cycles and memory pages among processes in a fair
way. The amount of cycles and memory pages you get is flexible. If
noone else is on the machine, you get the full machine. If someone
else comes with another job, your stuff gets pushed away. Cpusets
guarantee that you get exclusive use of exactly the piece of machine
which you want. This way your run times will be reproducible and other
users just won't disturb you. With the current CKRM cpu/mem
controllers you can say: this set of processes should get 25% of the
cycles and memory. This is a soft limit (can be violated) and doesn't
imply where the CPUs are and which memory blocks (cells/nodes) in the
machine you use. It's of no use for a customer who wants reproducible
compute times (and I don't mean minimal, or guaranteed. I mean same
time for each run, within minimal error margins) and no interference
between users. I'm sure many might question these objectives. I assure
you that they are taken from real life and are very important.

As Paul explained in a previous email: the scope of cpusets is
orthogonal to that of the current CKRM CPU/mem controllers. I see
benefit in combining the two, within one cpuset one can run several
processes and protect them from starving.

The implementation of CKRM cpu/mem and cpusets is as different as
their scope. I doubt CKRM can be just easilly extended to replicate
cpusets functionality. Just adding cpus_allowed will not be enough. In
the end CKRM will need to rebuild all code in the cpusets patch.

> I don't think CKRM is anything like as far away from being ready as
> you seem to be implying - we're talking about a month or two, I
> think.

Shailab's email shows that we're talking about several months. He also
agreed with pushing cpusets towards the -mm tree.

Best regards,
Erich

