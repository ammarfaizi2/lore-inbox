Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161521AbWHDWCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161521AbWHDWCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161522AbWHDWCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:02:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161521AbWHDWC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:02:29 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 00:01:52 +0200
User-Agent: KMail/1.9.3
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru
References: <44D1CC7D.4010600@vmware.com> <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com>
In-Reply-To: <44D3B0F0.2010409@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608050001.52535.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the Xen case, 
> they may want to run a dom-0 hypervisor which is compiled for an actual 
> hardware sub-arch, such as Summit or ES7000. 

There is no reason Summit or es7000 or any other subarchitecture 
would need to do different  virtualization. In fact these subarchitectures 
are pretty much obsolete by the generic subarchitecture and could be fully
done by runtime switching.

I don't disagree with your general point that some kind of PAL
code between kernels and hypervisors might be a good idea
(in fact I think Xen already uses vsyscall pages in some cases for this),
but this particular example is no good.

> I would expect to see these new sub-architectures 
> begin to grow like a rash. 

I hope not. The i386 subarchitecture setup is pretty bad already
and mostly obsolete for modern systems.

> The same approach can be used on x86_64 for paravirtualization, but also 
> to abstract out vendor differences between platforms.  Opteron and EMT64 
> hardware are quite different, and the plethora of non-standard 
> motherboards and uses have already intruded into the kernel.  Having a 
> clean interface to encapsulate these changes is also desirable here, and 
> once we've nailed down a final approach to achieving this for i386, it 
> makes sense to do x86_64 as well.

Possible.

> 
> I'm now talking lightyears into the future

tststs - please watch your units.

>, but when the i386 and x86_64  
> trees merge together,

I don't think that will happen in the way you imagine. I certainly
don't plan to ever merge legacy stuff like Voyager or Visual Workstation
or even 586 multiprocessor support.

It might be that x86-64 grows 32bit support at some point, but certainly
only for modern systems and without the heavyweight subarchitecture setup
that i386 uses.

> this layer will be almost identical for the two,  
> allowing sharing of tricky pieces of code, like the APIC and IO-APIC, 

No, one of the strong points of the x86-64 port is that APIC/IO-APIC support
doesn't carry all the legacy i386 has to carry.

> NMI handling, system profiling, and power management.  It the interface 
> evolves in a nicely packaged and compartmentalized way from that, then 
> perhaps someday it can grow to become a true cross-architecture way to 
> handle machine abstraction and virtualization. 

I don't fully agree to move everything into paravirt ops. IMHO
it should be only done for stuff which is performance critical
or cannot be virtualized.

For most other stuff a Hypervisor can always trap or not bother.

> (N-tiered cache coloring, 
> multiway hardware page tables, hypercubic interrupt routing, dynamically 
> morphed GPUs, quantum hypervisor isolation).  

I have my doubts paravirt ops will ever support any of this @)
If we tried that then it would be so messy that it would turn into
a bad idea.

> Of course, it will still  
> require a PCI bus.

And it's unlikely PCI will be ever a good fit for a Quantum computer @)

>  I too would like to push for an interface 
> in 2.6.19, and we can't have confusion on this issue be a last minute 
> stopper.

For 2.6.19 it's too late already. Freeze for its merge 
window has already nearly begun and this stuff is not ready yet.
 
> Maybe someday Xen and VMware can share the same ABI interface and both 
> use a VMI like layer. 

The problem with VMI is that while it allows hypervisor side evolution
it doesn't really allow Linux side evolution with its fixed spec.

But having it a bit isolated is probably ok.

-Andi
