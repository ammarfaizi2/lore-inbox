Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135651AbRDSM5M>; Thu, 19 Apr 2001 08:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135652AbRDSM5D>; Thu, 19 Apr 2001 08:57:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55820 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135651AbRDSM44>; Thu, 19 Apr 2001 08:56:56 -0400
Subject: Re: PCI power management
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 Apr 2001 13:57:57 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds),
        linux-pm-devel@lists.sourceforge.net
In-Reply-To: <19031231222908.21882@mailhost.mipsys.com> from "Benjamin Herrenschmidt" at Jan 01, 1904 11:29:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qE0V-00078Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - Some devices just can't be brought back to life from D3 state without
> a PCI reset (ATI Rage M3 for example) and that require some arch specific
> support (when it's possible at all).

Putting on a driver author hat what I want is

	pci_power_on_generic
	pci_power_off_generic
	pci_power_on_null
	pci_power_off_null

At which point most driver writers are having to do no thinking at all about
their device. The PCI layer just requires they pick a function and stick it
in the struct pci_device. 

>  - On SMP, we need some way to stop other CPUs in the scheduler
> while running the last round of sleep (putting devices to sleep) at least
> until all IO layers in Linux can properly handle blocking of IO queues
> while the device sleeps.

This doesnt help you. You need device specific support in each case where
bus mastering is occuring and a bus master error could be fatal if missed.
For example on i2o I can easily have 4Mbytes of outstanding I/O between the
message layer and disk, all of which is bus mastering. Only the driver actually
knows when its idle.

> that bang hardware directly (X, but not only X) need to be properly
> suspended (and the kernel has to wait for ack from them before continuing
> with devices sleep).

X has hooks for this in XFree 4


