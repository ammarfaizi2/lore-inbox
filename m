Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRHaWrC>; Fri, 31 Aug 2001 18:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRHaWqy>; Fri, 31 Aug 2001 18:46:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19982 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269673AbRHaWqX>; Fri, 31 Aug 2001 18:46:23 -0400
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
To: andrew.grover@intel.com (Grover, Andrew)
Date: Fri, 31 Aug 2001 23:50:02 +0100 (BST)
Cc: russell@coker.com.au ('Russell Coker'),
        acpi@phobos.fachschaften.tu-muenchen.de ("Acpi-linux (E-mail)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0DB@orsmsx35.jf.intel.com> from "Grover, Andrew" at Aug 31, 2001 02:49:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cx6w-00049f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So of course I realize this wouldn't happen any time soon, but has any
> discussion taken place regarding enhancing the bootloader (grub? Steal
> FreeBSD's?) to load modular drivers very early, and possibly abstracting
> SMP/UP from the kernel proper? Wouldn't this be a better solution than
> initrd?

All the discussion we have has been based on seriously enhancing and
expanding the use of the initrd/ramfs layer. Remember we can begin running
from ramfs without interrupts, pci bus scans or the like. The things it cant
do are - pick a kernel by processor type, pick SMP/non SMP.

As it happens both of those are things that are deeply buried in the whole
compile choices and how we generate the code itself - so they do need to
be boot loader driven (or user driven)

So the path for ACPI could indeed go

load kernel
load initial ramfs
Discover we have ACPI
load acpi core
load acpi irq router
load acpi timers
[init hardware]
load ide disk
load ext3
mount /

Alan
