Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVFTU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVFTU4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFTUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:55:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46766 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262776AbVFTUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:42:50 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200506202042.j5KKgXKl4801437@clink.americas.sgi.com>
Subject: Re: [RFC] Linux memory error handling
To: haveblue@us.ibm.com (Dave Hansen)
Date: Mon, 20 Jun 2005 15:42:32 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson), rmk+lkml@arm.linux.org.uk (Russell King),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1118871234.6620.41.camel@localhost> from "Dave Hansen" at Jun 15, 2005 02:33:54 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2005-06-15 at 16:27 -0500, Russ Anderson wrote:
> > How about /sys/devices/system/memory/dimmX with links in
> > /sys/devices/system/node/nodeX/ ?  Does that sound better?
> 
> Much better than /proc :)
> 
> However, we're already using /sys/devices/system/memory/ for memory
> hotplug to represent Linux's view of memory, and which physical
> addresses it is currently using.  I've thought about this before, and I
> think that we may want to have /sys/.../memory/hardware for the DIMM
> information and memory/logical for the memory hotplug controls.

Is there a standard for how to name hardware entries in 
/sys/devices/system (or sysfs in general)?  Seems like this
same general issue would apply to other hardware components,
cpus, nodes, etc.  
 
> One other minor thing.  You might want to think about referring to the
> pieces of memory as things other than DIMMs.  On ppc64, for instance,
> the hypervisor hands off memory in sections called LMBs (logical memory
> blocks), and they're not directly related to any hardware DIMM.  The
> same things will show up in other virtualized environments.

If we're talking about specific hardware entries, it seems like they
should be called what they are.  If we're talking about abstractions,
a more abstract name seems in order.  One of my concerns is mapping 
failures back to hardware components, hence my bias for component names.
Would having /sys/.../memory/LMB on ppc64 to correspond to 
/sys/.../memory/DIMM be a problem?  RAM would be an alternative,
but that could be confused with /sys/block/ram.  :-)

In general, I'm more concerned with getting the necessary functionality
in than what the specific entries are called, so I'll go along with
the consensus.

-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
