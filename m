Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVBDLT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVBDLT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVBDLTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:19:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35462 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261640AbVBDLTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:19:24 -0500
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
	<20050203.191039.39155205.taka@valinux.co.jp>
	<m18y666i6u.fsf@ebiederm.dsl.xmission.com>
	<20050204.190509.112624049.taka@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Feb 2005 04:17:08 -0700
In-Reply-To: <20050204.190509.112624049.taka@valinux.co.jp>
Message-ID: <m1hdks60cr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi <taka@valinux.co.jp> writes:

> Hi,
> 
> > > Hi Eric,
> > > 

> I see you have.
> And MIPS CPUs doesn't allow kernel pages to be remapped either.

I guess I should add to be relocatable in the general case most
likely requires running a PIC dynamic linker at kernel startup.
If none of the rest of the kernel is built PIC and the relocation
table is not too big we might be able to convince people to implement
it generally.

At least that is one technique for generating a PIC kernel that I
have not explored fully.
 
> > You don't need anything fancy except to build the page tables
> > during bootup.  However there are a few potential gotchas
> > with respect to using large pages, that can give 4MiB or
> > greater alignment restrictions on the kernel.  Code wise
> > the gotcha is moving the kernel's .text section into what
> > is essentially the vmalloc portion of the address space.
> > For x86_64 the kernels virtual address is already decoupled from the
> > physical addresses, so it is probably easier.
> 
> I know we can place the kernel in any address though there
> exist some exceptions.
> 
> I know mapping kernel pages to the same virtual address only helps
> to avoid caring about physical addresses or vmalloc'ed addresses
> when linking the kernel. I think it wouldn't be bad idea in many
> architectures. I prefer it rather than linking the kernel for each
> system.

Agreed.  Although I suspect most architectures will have a region
that will work for most users.
 
> > Most of this just results in easier management between the pieces.
> > Which is a good thing.  However at the moment I don't think it
> > simplifies any of the core problems.  I still need to reserve
> > a large hunk of physical address space early on before any
> > DMA transactions are setup to hold the new kernel.
> 
> I agree that my idea is not essential at the moment.
> 
> > So while I am happy to see patches that improve this I don't
> > actually care right now.
> 
> ok.

The one part I do request is that if you build such a kernel that
you figure a way to get it's ELF header of type ET_DYN.   So it
does not require a magic loader to load it.

I have recently patched both etherboot and /sbin/kexec to accept
that kind of binary :)

Eric
