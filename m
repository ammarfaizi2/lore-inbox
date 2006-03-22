Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWCVRQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWCVRQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWCVRQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:16:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17641 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750824AbWCVRQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:16:17 -0500
Message-ID: <4421863C.4070403@us.ibm.com>
Date: Wed, 22 Mar 2006 11:15:40 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
References: <20060322063040.960068000@sorel.sous-sol.org>
In-Reply-To: <20060322063040.960068000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> Xen also provides support for running directly on native hardware.
>   

Can someone elaborate on this?  Does this mean a Xen guest can run on 
bare metal?

Is there code available to make this work (it doesn't seem contained in 
this patchset)?  Has any performance analysis been done?

The numbers that have been posted with the VMI patches suggest that some 
rather tricky stuff is required to achieve native performance when 
running a guest on bare metal.  If this is not the case, it would be 
very interesting to know because it seems to be the hairiest part of the 
VMI patches.

Otherwise, if we want to support Xen guests on bare metal, it seems we 
would have to change things in the subarch code a bit to do something 
similar to VMI.

Regards,

Anthony Liguori

> The following patch series provides the minimal support required to
> launch Xen paravirtual guests on standard x86 hardware running the Xen
> hypervisor.  These patches effectively port the Linux kernel to run on the
> platform interface provided by Xen.  This port is done as an i386 subarch.
>
> With these patches you will be able to launch an unprivileged guest
> running the modified Linux kernel and unmodified userspace.  This guest
> is x86, UP only, runs in shadow translated mode, and has no direct access
> to hardware.  This simplifies the patchset to the minimum functionality
> needed to support a paravirtualized guest.  It's worth noting that
> a fair amount of this patchset deals with paravirtualizing I/O, not
> just CPU-only.  The additional missing functionality is primarily about
> full SMP support, optimizations such as direct writable page tables,
> and the management interface.  Those refinements will be posted later.
>
> At a high-level, the patches provide the following:
>
> - Kconfig and Makefile changes required to support Xen
> - subarch changes to allow more platform functionality to be
>   implemented by an i386 subarch
> - Xen subarch implementation
> - start of day code for running in the hypervisor provided environment (paging
>   enabled)
> - basic Xen drivers to provide a fully functional guest
>
> The Xen platform API encapsulates the following types of requirements:
>
> - idt, gdt, ldt (descriptor table handling)
> - cr2, fpu_taskswitch, debug registers (privileged register handling)
> - mmu (page table, tlb, and cache handling)
> - memory reservations
> - time and timer
> - vcpu (init, up/down vcpu)
> - schedule (processor yield, shutdown, etc)
> - event channel (generalized virtual interrupt handling)
> - grant table (shared memory interface for high speed interdomain communication)
> - block device I/O
> - network device I/O
> - console device I/O
> - Xen feature map
> - Xen version info
>
> Thanks to those who provided early feedback to this patchset: Andi Kleen,
> Gerd Hoffmann, Jan Beulich, Rik van Riel, Stephen Tweedie, and the Xen team.
> And thanks to the Xen community: AMD, HP, IBM, Intel, Novell, Red Hat,
> Virtual Iron, XenSource -- see Xen changelog for full details.
>
> Known issues:
>
> 	CodingStyle conformance is still in progress
> 	/proc interface needs to be replaced with something more appropriate
> 	entry.S cleanups are possible
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization
>   

