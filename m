Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWHDHgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWHDHgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWHDHgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:36:37 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5249 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161094AbWHDHgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:36:37 -0400
Date: Fri, 4 Aug 2006 00:37:54 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Antonio Vargas <windenntw@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, rusty@rustcorp.com.au, jlo@vmware.com,
       xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-ID: <20060804073754.GY2654@sequoia.sous-sol.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org> <20060804054002.GC11244@sequoia.sous-sol.org> <69304d110608032328r36bc0a6ase0a2dbf36d8cc519@mail.gmail.com> <20060804070142.GW2654@sequoia.sous-sol.org> <69304d110608040019i2f68518dq4e84a96a8787b0eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69304d110608040019i2f68518dq4e84a96a8787b0eb@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Antonio Vargas (windenntw@gmail.com) wrote:
> What I was refering with "native hardware virtualization" is just the
> VT or Pacitifica -provided trapping into the hypervisor upon executing
> "dangerous" instructions such as tlb-flushes, reading/setting the
> current ring-level, cli/sti...

We are not talking about VMX or AMDV.  Just plain ol' x86 hardware.

> Yes, maybe just providing a switch to force paravirtops to use the
> native hardware implementation would be enough, or just in case,
> making the default the native hardware and allowing the kernel
> commandline to select another one (just like on io-schedulers)

In this case native hardware == running on bare metal w/out VMX/AMDV
support and w/out any hypervisor.  So, while this would let you actually
boot the machine, it's probably not really useful for the case you cited
(security update to hypervisor causes ABI breakage) because you'd be
booting a normal kernel w/out any virtualization.  IOW, all the virtual
machines that were running on that physical machine would not be running.

> Yes. What I propose is allowing the systems to continue running (only
> with degraded performance) when the hv-interface between the running
> kernel and the running hypervisor doesn't match.

This is non-trivial.  If the hv-interface breaks the ABI, then you'd
need to update the pv-glue layer in the kernel.

> >> BTW, what is the recommended distro or kernel setup to help testing
> >> the latest paravirt patches? I've got a spare machine (with no needed
> >> data) at hand which could be put to good use.
> >
> >Distro of choice.  Current kernel with the pv patches[1], but be
> >forewarned, they are very early, and not fully booting.
> 
> Thanks, will be setting it up :)

Thanks for helping.
-chris
