Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUL3TlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUL3TlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUL3TlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 14:41:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50115 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261703AbUL3Tkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 14:40:52 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: 3 ways to represent cpu affinity in /sys and counting
Date: Thu, 30 Dec 2004 11:40:19 -0800
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, ak@suse.de, greg@kroah.com, miltonm@bga.com
References: <20041226002744.GC21710@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20041226002744.GC21710@krispykreme.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412301140.20366.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 25, 2004 4:27 pm, Anton Blanchard wrote:
> Hi,
>
> We have a patch to change pcibus_to_cpumask to pcibus_to_node. This makes
> it more consistent with cpu_to_node, and when you want a cpumask you
> use node_to_cpumask.

Great!  I think Matt Dobson said he was going to do something similar, but he 
got sidetracked (and iirc, ak also didn't like the idea).  FWIW, I like it, 
with the caveat that the node returned from pcibus_to_node may not have any 
memory or CPUs associated with it.

> A pci device has a local_cpus property:
>
> /sys/devices/pci000a:00/000a:00:02.6/local_cpus
>
> A pci_bus has a cpuaffinity property:
>
> /sys/class/pci_bus/000d:d8/cpuaffinity

I don't know how these two got different names...

> A node has a cpumap property:
>
> /sys/devices/system/node/node3/cpumap
>
> Can we standardize on a single property name for this? :)

Seems like nodes should have a cpumap and PCI busses should have a node.

> Furthermore, looking at node linkages:
>
> A node has symlinks to cpus:
>
> /sys/devices/system/node/node0/cpu0 -> /sys/devices/system/cpu/cpu0
>
> But doesnt have symlinks to pci devices.

Yep, this would be nice to have.

Jesse
