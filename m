Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUHFPdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUHFPdC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUHFPdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:33:00 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:58577 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268145AbUHFPcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:32:15 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 6 Aug 2004 17:30:06 +0200
User-Agent: KMail/1.6.2
Cc: lse-tech@lists.sourceforge.net, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]>
In-Reply-To: <247790000.1091762644@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061730.06175.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The existing cpu and memory placement facilities, added in 2.6,
> > set_schedaffinity (for cpus) and mbind/set_mempolicy (for memory) are
> > just the right thing for an individual task to manage in detail its
> > placement across the resources available to it (the online cpus and
> > nodes if CONFIG_CPUSET is disabled, or within the cpuset if cpusets
> > are enabled).
> 
> I agree that the current mechanisms are not wholly sufficient - the
> most obvious failing being that whilst you can bind a process to a
> resource, there's very little support for making a resource exclusively
> available to a process or set thereof.

For the record, we (NEC) are also a potential user of this patch on
the TX-7 NUMA machines. For our 2.4 kernels we are currently using
something with similar functionality but only two hierarchy levels. 
I would very much welcome the inclusion of cpusets. The patch got much
leaner compared to the early days, big part of it consists of
documentation (good!) and the user interface (also very nice, although
it duplicates some code). The rest is just needed. Besides: it's
encapsulated enough and doesn't hurt others. (BTW: I could imagine
using this on quad-opterons, too...)

> Right ... but I'm kind of shocked by the size of the patch to fix what
> seems like a fairly simple problem. The other thing that seems to glare
> at me is the overlap between what you have here and PAGG/CKRM. Does
> either cpusets depend on PAGG/CKRM or vice versa? They seem to have 
> similar goals, and it'd be strange to have two independant mechanisms.

There's no relation to PAGG but I think cpusets and CKRM should be
made to come together. One of CKRM's user interfaces is a filesystem
with the file-tree representing the class hierarchy. It's the same for
cpusets. I'd vote for cpusets going in soon. CKRM could be extended by
a cpusets controller which should be pretty trivial when using the
infrastructure of this patch. It simply needs to create classes
(cpusets) and attach processes to them. The enforcement of resources
happens automatically. When CKRM is mature to enter the kernel, one
could drop /dev/cpusets in favor of the CKRM way of doing it.

Regards,
Erich


