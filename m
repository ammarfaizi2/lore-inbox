Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUKIToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUKIToU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKIToC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:44:02 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51934 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261649AbUKITnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:43:08 -0500
Subject: Re: Externalize SLIT table
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Erich Focht <efocht@hpce.nec.com>
Cc: Jack Steiner <steiner@sgi.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>,
       linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200411041631.42627.efocht@hpce.nec.com>
References: <20041103205655.GA5084@sgi.com>
	 <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
	 <20041104141337.GA18445@sgi.com>  <200411041631.42627.efocht@hpce.nec.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100029381.3980.12.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Nov 2004 11:43:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 07:31, Erich Focht wrote:
> On Thursday 04 November 2004 15:13, Jack Steiner wrote:
> > I think it would also be useful to have a similar cpu-to-cpu distance
> > metric:
> >         % cat /sys/devices/system/cpu/cpu0/distance
> >         10 20 40 60 
> > 
> > This gives the same information but is cpu-centric rather than
> > node centric.
> 
> I don't see the use of that once you have some way to find the logical
> CPU to node number mapping. The "node distances" are meant to be
> proportional to the memory access latency ratios (20 means 2 times
> larger than local (intra-node) access, which is by definition 10). 
> If the cpu_to_cpu distance is necessary because there is a hierarchy
> in the memory blocks inside one node, then maybe the definition of a
> node should be changed...
> 
> We currently have (at least in -mm kernels):
>        % ls /sys/devices/system/node/node0/cpu*
> for finding out which CPUs belong to which nodes. Together with
>        /sys/devices/system/node/node0/distances
> this should be enough for user space NUMA tools.
> 
> Regards,
> Erich

I have to agree with Erich here.  Node distances make sense, but adding
'cpu distances' which are just re-exporting the node distances in each
cpu's directory in sysfs doesn't make much sense to me.  Especially
because it is so trivial to get a list of which CPUs are on which node. 
If you're looking for groups of CPUs which are close, simply look for
groups of nodes that are close, then use the CPUs on those nodes.  If we
came up with some sort of different notion of 'distance' for CPUs and
exported that, I'd be OK with it, because it'd be new information.  I
don't think we should export the *exact same* node distance information
through the CPUs, though.

-Matt

