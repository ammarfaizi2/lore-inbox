Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVACPQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVACPQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVACPQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:16:00 -0500
Received: from ns.suse.de ([195.135.220.2]:50828 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261470AbVACPPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:15:35 -0500
Date: Mon, 3 Jan 2005 16:15:33 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, greg@kroah.com, miltonm@bga.com
Subject: Re: 3 ways to represent cpu affinity in /sys and counting
Message-ID: <20050103151533.GD4963@wotan.suse.de>
References: <20041226002744.GC21710@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226002744.GC21710@krispykreme.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 11:27:44AM +1100, Anton Blanchard wrote:
> 
> A pci device has a local_cpus property:
> 
> /sys/devices/pci000a:00/000a:00:02.6/local_cpus

We should have both node and cpus here because both
are needed in user space (one for CPU affinity, the other
for memory affinity). While it's possible to convert
in user space it's quite cumbersome. 

I plan to add functions to libnuma to make this easy,
but I'm not sure everybody will want to use libnuma just
for this.

> 
> A pci_bus has a cpuaffinity property:
> 
> /sys/class/pci_bus/000d:d8/cpuaffinity

I'm not sure what that is anyways. I don't think x86-64 sets it up
and does anybody really use it?
> 
> A node has a cpumap property:
> 
> /sys/devices/system/node/node3/cpumap
> 
> Can we standardize on a single property name for this? :)

I suspect it's already too late. 

> 
> Furthermore, looking at node linkages:
> 
> A node has symlinks to cpus:
> 
> /sys/devices/system/node/node0/cpu0 -> /sys/devices/system/cpu/cpu0
> 
> But doesnt have symlinks to pci devices.

I'm not sure how useful that would be anyways.

> 
> A cpu doesnt have a cpumask of its node, but a pci device and pci bus
> both do. Is there some way we can stardardize this too? 

You mean a nodemask?

> 
> Ideally we want to be able to lookup a device -> node -> cpumask
> relationship in a consistent way. Assuming we fix up the 3 different
> names for cpu affinity properties, we still have 2 methods of looking
> that up, and no easy way of going from pci devices to nodes.

You mean the user space interface?

Getting it from sysfs will be always a mess, best is to have a standard
library that offers this in nice functions and a command whose output
can be parsed by shell scripts. I plan to add this eventually to 
numactl/libnuma.

-Andi
