Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUHDQ1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUHDQ1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267347AbUHDQ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:27:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45510 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267345AbUHDQ0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:26:37 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman), khalid.aziz@hp.com
Subject: Re: [BROKEN PATCH] kexec for ia64
Date: Wed, 4 Aug 2004 09:24:12 -0700
User-Agent: KMail/1.6.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-ia64@vger.kernel.org,
       fastboot@osdl.org, <linux-kernel@vger.kernel.org>
References: <200407261524.40804.jbarnes@engr.sgi.com> <20040730155504.2a51b1fa.rddunlap@osdl.org> <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040924.12407.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2004 6:07 am, Eric W. Biederman wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> writes:
> > On Mon, 26 Jul 2004 15:36:05 -0700 Jesse Barnes wrote:
> > | On Monday, July 26, 2004 3:24 pm, Jesse Barnes wrote:
> > | >   o userspace tools need ia64 support
>
> Correct.  But all they need are the ia64 bits of the ELF loader,
> plus ia64 specific goo.  The generic part of the ELF loader is already
> written.

I think Khalid might already have these bits done.

> Sort of fundamentally they are arch dependent.
>
> I believe that DMA FIXME is a red hearing.  Initially that patch
> was targeted for a kernel without device_shutdown(), so I was
> likely considering the old trick of running through all of the PCI
> devices and disabling their bus master bit.

Yeah, I added that bit to remind me to think about it.

> 1) What is the kernel's argument passing format, what arguments

Right, and that should be pretty straightforward.

> 2) The code itself in machine_kexec.c and relocate_kernel.S needs
>    to place the machine in a state where virtual and physical addresses
>    are identity mapped.  And the arch specific registers are in some
>    well defined state.  Usually the least setup you can guarantee to make
>    it work the better.
>
> (This is the kernel side)
>
> We should probably start capturing these pieces of information in
> a kexec.3 man page.  Volunteers?
>
> For ia64 in particular I believe the binary arguments are the
> FPSWA and EFI memory map, and the firmware entry points (PAL and SAL
> and EFI).

With the addition of some ACPI tables and such.  I don't think those are freed 
by the kernel right now though, so it should be pretty easy to point at the 
originals from the newly kexec'd kernel, or make copies.

Jesse
