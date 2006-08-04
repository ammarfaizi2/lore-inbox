Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWHDHAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWHDHAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWHDHAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:00:33 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55168 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751059AbWHDHAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:00:32 -0400
Date: Fri, 4 Aug 2006 00:01:42 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Antonio Vargas <windenntw@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, rusty@rustcorp.com.au, jlo@vmware.com,
       xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-ID: <20060804070142.GW2654@sequoia.sous-sol.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org> <20060804054002.GC11244@sequoia.sous-sol.org> <69304d110608032328r36bc0a6ase0a2dbf36d8cc519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69304d110608032328r36bc0a6ase0a2dbf36d8cc519@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Antonio Vargas (windenntw@gmail.com) wrote:
> One feature I found missing at the paravirt patches is to allow the
> user to forbid the use of paravirtualization of certain features (via
> a bitmask on the kernel commandline for example) so that the execution
> drops into the native hardware virtualization system. Such a feature

There is no native harware virtualization system in this picture.  Maybe
I'm just misunderstanding you.

> would provide a big upwards compatibility for the kernel<->hypervisor
> system. The case for this would be needing to forcefully upgrade the
> hypervisor due to security issues and finding out that the hypervisor
> is  incompatible at the paravirtualizatrion level, then the user would
> be at least capable of continuing to run the old kernel with the new
> hypervisor until the compatibility is reached again.

This seems a bit like a trumped up example, as randomly disabling a part
of the pv interface is likely to cause correctness issues, not just
performance degradation.

Hypervisor compatibility is a slightly separate issue here.  There's two
interfaces.  The linux paravirt interface is internal to the kernel.
The hypervisor interface is external to the kernel.

kernel <--pv interface--> paravirt glue layer <--hv interface--> hypervisor

So changes to the hypervisor must remain ABI compatible to continue
working with the same kernel.  This is the same requirement the kernel
has with the syscall interface it provides to userspace.

> BTW, what is the recommended distro or kernel setup to help testing
> the latest paravirt patches? I've got a spare machine (with no needed
> data) at hand which could be put to good use.

Distro of choice.  Current kernel with the pv patches[1], but be
forewarned, they are very early, and not fully booting.

thanks,
-chris

[1] mercurial patchqueue http://ozlabs.org/~rusty/paravirt/
