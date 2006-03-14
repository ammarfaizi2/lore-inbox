Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWCNENn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWCNENn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWCNENn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:13:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:61318 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751826AbWCNENm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:13:42 -0500
Message-ID: <441642EE.80900@us.ibm.com>
Date: Mon, 13 Mar 2006 22:13:34 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
In-Reply-To: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zach,

A number of the files you posted (including the vmi_spec.txt) have the 
phrase 'All rights reserved'.  That seems incompatible with the GPL.  In 
particular, it makes it unclear about how one can use the actual vmi spec.

In your next round of patches, could you clarify the actual licensing of 
the files?

Regards,

Anthony Liguori

Zachary Amsden wrote:
> In OLS 2005, we described the work that we have been doing in VMware
> with respect a common interface for paravirtualization of Linux. We
> shared the general vision in Rik's virtualization BoF.
>
> This note is an update on our further work on the Virtual Machine
> Interface, VMI.  The patches provided have been tested on 2.6.16-rc6.
> We are currently recollecting performance information for the new -rc6
> kernel, but expect our numbers to match previous results, which showed
> no impact whatsoever on macro benchmarks, and nearly neglible impact
> on microbenchmarks.
>
> Unlike the full-virtualization techniques used in the traditional VMware
> products, paravirtualization is a technique where the operating system
> is modified to enlighten the hypervisor with timely knowledge about the
> operating system's activities. Since the hypervisor now depends on the
> kernel to tell it about common idioms etc, it does not need to write
> protect OS objects such as page and descriptor tables as a solution
> based on full-virtualization needs. This has two important effects (a)
> it shortens the critical path, since faulting is expensive on modern
> processors (b) by eliminating complex heuristics the hypervisor is
> simplified. While the former delivers performance, the latter is quite
> important too. 
>
> Not surprisingly, paravirtualization's strength, ie that it encourages
> tighter communication between the kernel and the hypervisor, is also its
> weakness. Unless the changes to the operating system are moderated, you
> can very quickly find yourself with a kernel that (a) looks and feels
> like a brand new kernel or (b) cannot run on native machines or on newer
> versions of the hypervisor without a full recompile. The former can
> impede innovation in the Linux kernel, and the latter can be a problem
> for software vendors. 
>
> VMware proposes VMI as a paravirtualization interface for Linux that
> solves these problems. 
>   - A VMI'fied Linux kernel runs unmodified on native hardware, and on
>     many hypervisors, while simultaneously delivering on the performance
>     promise of paravirtualization. 
>   - VMI has a rich and low level interface, which allows the kernel to
>     cope with future hardware evolution by querying for hardware
>     capability. It is our expectation that a single kernel will run
>     unmodified on both today's processors with limited hardware
>     virtualization support and also keep up with any evolution on the
>     processor front 
>   - VMI Linux is a fairly clean interface, with distinct name spaces
>     for objects from the kernel and the hypervisor. Nowhere do we mingle
>     names from the hypervisor with that of the kernel. This separation
>     allows innovation in the kernel to proceed at the same speed as
>     always. For most kernel developers, a VMI kernel looks and feels like
>     a regular Linux kernel.  
>   - VMI Linux still supports "native" hypervisor device drivers, for
>     example a hypervisor vendor's own private network or block device
>     drivers which are free to use any interface desired to communicate
>     with the hypervisor.
>
> At present, we are sharing a working implementation of the VMI for
> 2.6.16-rc6 version of Linux. We have verified that VMI Linux does indeed
> run well on native machines (both P4 and Opterons), and on VMware style
> hypervisors. VMI Linux has negligible overheads on native machines, so
> much so, that we are confident that VMI Linux can, in the long run, be
> the default Linux for i386.  We believe that this interface is both
> cleaner and more powerful than other proposals that have been made
> towards virtualization of Linux, and can easily be adapted to work with
> other hypervisors.
>
> This is by no means finished work. A few of the areas that need more
> attention and exploration are (a) 64bit support is still lacking, but we
> feel a port of VMI to the 64 bit Linux can be done without too much
> trouble (b) the Xen compatibility layer needs some work to bring it
> up to the Xen 3.0 interfaces.  Work is underway on this already, and
> no major issues are expected at this time. 
>
> Two final notes.  This is not an attempt to force a proprietary interface
> into the Linux kernel.  This is an attempt to find a common interface
> that can be used by many hypervisors by isolating hypervisor specific
> idioms into a neutral layer.  This new layer is just what is claims to
> be - a virtual machine interface, which allows hypervisor dependent code
> to be abstracted in a way that benefits both Linux and hypervisor
> development.
>
> This is also not an attempt to define an exact and final specification
> of how virtualization should be done in Linux.  This is very much a work
> in progress, and it is understood that the interfaces proposed here will
> change in time to accommodate the needs of all interested parties.  We 
> hope to find a common solution that can eventually become part of the
> Linux kernel and serve as a model for other operating systems as well.
>
> We appreciate your feedback on this design and the patches to Linux, and
> welcome working with anyone who is interested in making virtualization
> in Linux a friendly environment to innovate in.  If you find the ideas
> here interesting, please volunteer to help improve them.
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization
>   

