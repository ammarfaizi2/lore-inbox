Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264965AbSJ3X7L>; Wed, 30 Oct 2002 18:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJ3X5h>; Wed, 30 Oct 2002 18:57:37 -0500
Received: from rj.sgi.com ([192.82.208.96]:52354 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S264976AbSJ3X5F>;
	Wed, 30 Oct 2002 18:57:05 -0500
Date: Wed, 30 Oct 2002 16:03:26 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pcibus_to_node() addition to topology infrastructure
Message-ID: <20021031000326.GA3049@sgi.com>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DC06E75.6010003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC06E75.6010003@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a nice addition, but just FYI there are SGI systems that have
PCI busses attached to more than one node.  I guess for now we can just
round-robin through the attached nodes for the return value.

Thanks,
Jesse

On Wed, Oct 30, 2002 at 03:42:45PM -0800, Matthew Dobson wrote:
> Linus,
> 	Here's a patch that adds PCI busses to the list of basic topology 
> elements (incl. CPUs, MemBlks, & Nodes).
> 
> pcibus_to_node-2.5.44.patch
> 
> This patch adds a new topology macro: pcibus_to_node().  This will be 
> useful to allow I/O bound processes to bind themselves to CPUs/Nodes 
> close to the PCI busses they are communicating over.
> 
> 1) Adds pcibus_to_node() macro to asm-generic/topology.h
> 2) Makes small modifications to NUMA-Q PCI code, mostly modifying macros.
> 3) Uses the macros from #2 to implement pcibus_to_node() in 
> asm-i386/topology.h
> 
> [mcd@arrakis patches]$ diffstat api_patches/pcibus_to_node-2.5.44.patch
>  arch/i386/pci/numa.c           |   33 +++++++++++++++------------------
>  include/asm-generic/topology.h |    3 +++
>  include/asm-i386/topology.h    |    3 +++
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> Cheers!
> 
> -Matt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
