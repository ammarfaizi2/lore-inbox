Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUHFQDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUHFQDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUHFQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:02:47 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:6613 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268153AbUHFP5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:57:52 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 6 Aug 2004 17:55:40 +0200
User-Agent: KMail/1.6.2
Cc: lse-tech@lists.sourceforge.net, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408061730.06175.efocht@hpce.nec.com> <267050000.1091806507@[10.10.2.4]>
In-Reply-To: <267050000.1091806507@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061755.41016.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 17:35, Martin J. Bligh wrote:
> > I'd vote for cpusets going in soon. CKRM could be extended by
> > a cpusets controller which should be pretty trivial when using the
> > infrastructure of this patch. It simply needs to create classes
> > (cpusets) and attach processes to them. The enforcement of resources
> > happens automatically. When CKRM is mature to enter the kernel, one
> > could drop /dev/cpusets in favor of the CKRM way of doing it.
> 
> But I think that's dangerous. It's very hard to get rid of existing user
> interfaces ... I'd much rather we sorted out what we're doing BEFORE
> putting either in the kernel.

So the user interfaces should be adapted before? I think this is
simple and then the elimination of /dev/cpusets in favor of /rcfs is
just deletion of code plus a simbolic link. The classes and cpusets
are both directories. The files in cpusets are: 
 - cpus: list of CPUs in that cpuset
 - mems: list of Memory Nodes in that cpuset
 - cpu_exclusive flag: is cpu placement exclusive?
 - mem_exclusive flag: is memory placement exclusive?
 - tasks: list of tasks (by pid) attached to that cpuset
The files in a CKRM class directory:
 - stats   : statistics (not needed for cpusets)
 - shares  : could contain cpus, mems, cpu_exclusive, mem_exclusive
 - members : same as reading /dev/cpusets/.../tasks
 - target  : same as writing /dev/cpusets/.../tasks

Changing the "shares" would mean something like
  echo "cpus +6-10" > .../shares

Just an idea...

Regards,
Erich

