Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVBDKNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVBDKNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVBDKNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:13:07 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:45219 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263159AbVBDKMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:12:34 -0500
Date: Fri, 04 Feb 2005 19:05:09 +0900 (JST)
Message-Id: <20050204.190509.112624049.taka@valinux.co.jp>
To: ebiederm@xmission.com
Cc: vgoyal@in.ibm.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
 crashdumps.
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <m18y666i6u.fsf@ebiederm.dsl.xmission.com>
References: <m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
	<20050203.191039.39155205.taka@valinux.co.jp>
	<m18y666i6u.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Hi Eric,
> > 
> > > > Hi Vivek and Eric,
> > > > 
> > > > IMHO, why don't we swap not only the contents of the top 640K
> > > > but also kernel working memory for kdump kernel?
> > > > 
> > > > I guess this approach has some good points.
> > > > 
> > > >  1.Preallocating reserved area is not mandatory at boot time.
> > > >    And the reserved area can be distributed in small pieces
> > > >    like original kexec does.
> > > > 
> > > >  2.Special linking is not required for kdump kernel.
> > > >    Each kdump kernel can be linked in the same way,
> > > >    where the original kernel exists.
> > > > 
> > > > Am I missing something?
> > > 
> > > Preallocating the reserved area is largely to keep it from
> > > being the target of DMA accesses.  Since we are not able
> > > to shutdown any of the drivers in the primary kernel running
> > > in a normal swath of memory sounds like a good way to get
> > > yourself stomped at the worst possible time.
> > 
> > So what do you think my another idea?
> 
> I have proposed it.  I think ia64 already does that.
> It has been pointed that the PowerPC kernel occasionally runs
> with the mmu turned off. So it is not a technique the is 100%
> portable.

I see you have.
And MIPS CPUs doesn't allow kernel pages to be remapped either.

> > I think we can always make a kdump kernel mapped to the same virtual
> > address. So we will be free from caring about the physical address
> > where the kdump kernel is loaded.
> > 
> > I believe the memsection functionality which LHMS project is working
> > on would help this.
> 
> You don't need anything fancy except to build the page tables
> during bootup.  However there are a few potential gotchas
> with respect to using large pages, that can give 4MiB or
> greater alignment restrictions on the kernel.  Code wise
> the gotcha is moving the kernel's .text section into what
> is essentially the vmalloc portion of the address space.
> For x86_64 the kernels virtual address is already decoupled from the
> physical addresses, so it is probably easier.

I know we can place the kernel in any address though there
exist some exceptions.

I know mapping kernel pages to the same virtual address only helps
to avoid caring about physical addresses or vmalloc'ed addresses
when linking the kernel. I think it wouldn't be bad idea in many
architectures. I prefer it rather than linking the kernel for each
system.

> Most of this just results in easier management between the pieces.
> Which is a good thing.  However at the moment I don't think it
> simplifies any of the core problems.  I still need to reserve
> a large hunk of physical address space early on before any
> DMA transactions are setup to hold the new kernel.

I agree that my idea is not essential at the moment.

> So while I am happy to see patches that improve this I don't
> actually care right now.

ok.

> Eric
> 

Thanks,
Hirokazu Takahashi.
