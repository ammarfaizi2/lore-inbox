Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUAaWFU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUAaWFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:05:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41805 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265125AbUAaWFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:05:13 -0500
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com>
	<20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk>
	<20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401290802370.689@home.osdl.org>
	<20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jan 2004 14:57:29 -0700
In-Reply-To: <20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m1hdybwzli.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On Thu, Jan 29, 2004 at 08:05:52AM -0800, Linus Torvalds wrote:
> > The compiler _should_ entirely compile away "fix_to_virt(xxx)", so by 
> > creating a variable for the value, you're actually making code generation 
> > worse. You might as well have
> > 
> > 	#define mmcfg_virt_addr (fix_to_virt(FIX_PCIE_MCFG))
> > 
> > instead.
> 
> Ahh, I missed the comment towards the top of fixmap.h that this is a
> constant address.  You're so smart sometimes ;-)
> 
> > That said, this patch looks perfectly acceptable to me. With some testing, 
> > I'd take it through Greg or -mm.
> 
> Cool.  Here's the final version for testing then.

Is it really safe to treat the base address as a u32?  I know
if I was doing the BIOS and that address was tied to a 32bit BAR I
would be extremely tempted to put those 256M of address space above
4G.  Putting something like that below 4G leads to 1/2 Gig of memory
missing. 

You can also put the memory above 4G on most intel chipsets but I'd
rather have my memory down low where my legacy OS could get to it
rather than have my PCI extended configuration space down low where
nothing really needs it. 

Point being I don't think it is safe to assume the BIOS always puts
the extended PCI configuration space below 4G.

Eric
