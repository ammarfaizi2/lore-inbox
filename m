Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271792AbRIHSEr>; Sat, 8 Sep 2001 14:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271797AbRIHSEh>; Sat, 8 Sep 2001 14:04:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25393 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271792AbRIHSEe>; Sat, 8 Sep 2001 14:04:34 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andrew.grover@intel.com (Grover, Andrew),
        russell@coker.com.au ('Russell Coker'),
        acpi@phobos.fachschaften.tu-muenchen.de ("Acpi-linux (E-mail)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
In-Reply-To: <E15cx6w-00049f-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Sep 2001 11:55:23 -0600
In-Reply-To: <E15cx6w-00049f-00@the-village.bc.nu>
Message-ID: <m1iteth8j8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > So of course I realize this wouldn't happen any time soon, but has any
> > discussion taken place regarding enhancing the bootloader (grub? Steal
> > FreeBSD's?) to load modular drivers very early, and possibly abstracting
> > SMP/UP from the kernel proper? Wouldn't this be a better solution than
> > initrd?
> 
> All the discussion we have has been based on seriously enhancing and
> expanding the use of the initrd/ramfs layer. Remember we can begin running
> from ramfs without interrupts, pci bus scans or the like. The things it cant
> do are - pick a kernel by processor type, pick SMP/non SMP.
> 
> As it happens both of those are things that are deeply buried in the whole
> compile choices and how we generate the code itself - so they do need to
> be boot loader driven (or user driven)
> 
> So the path for ACPI could indeed go
> 
> load kernel
> load initial ramfs
> Discover we have ACPI
> load acpi core
> load acpi irq router
> load acpi timers
> [init hardware]
> load ide disk
> load ext3
> mount /

Sounds about right.  

If we really need to do weird things like pick a kernel by processor
type, or pick SMP/non SMP.  You can even do those from an initramfs
with a linux  booting linux kernel patch.

Eric
