Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263148AbTCWTO4>; Sun, 23 Mar 2003 14:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbTCWTO4>; Sun, 23 Mar 2003 14:14:56 -0500
Received: from mail0.mx.voyager.net ([216.93.66.205]:61200 "EHLO
	mail0.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S263148AbTCWTOy>; Sun, 23 Mar 2003 14:14:54 -0500
Message-ID: <3E7E0A73.3D00B9CB@megsinet.net>
Date: Sun, 23 Mar 2003 13:26:43 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.65 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mflt1@micrologica.com.hk, ambx1@neo.rr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
References: <3E7DE01B.2B6985DF@megsinet.net> <1048443865.10727.36.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sun, 2003-03-23 at 16:26, M.H.VanLeeuwen wrote:
> > NE2k ISAPNP broke around 2.5.64, again.  There are 2 parts to the attached
> > patch, one to move the NIC initialization earlier in the boot sequence
> > and the second is a HACK to get ne2k to work when compiled into the
> > kernel, I've never tried NE2k as a module...
> >
> > 1. The level of isapnp_init was moved to after apci.  Since it is now
> >    after net_dev_init, ISA PNP NICs fail to initialized at boot.
> >
> >    This fix allows ISA PNP NIC cards to work during net_dev_init, and still
> >    leaves isapnp_init after apci_init.
> 
> We must initialise ACPI before ISAPnP because we need PCI and ACPI to
> know what system resources we must not hit. How about moving the
> net_dev_init to later ?

Here is the ordering of initcall from System.map file w/ my change.
I take it that you want isapnp_init after pci*_init also, or is it sufficient
like it is, after the acpi*_init?

c0410f30 t __initcall_init_bio
c0410f34 t __initcall_acpi_init
c0410f38 t __initcall_acpi_ec_init
c0410f3c t __initcall_acpi_pci_root_init
c0410f40 t __initcall_acpi_pci_link_init
c0410f44 t __initcall_acpi_power_init
c0410f48 t __initcall_acpi_system_init
c0410f4c t __initcall_acpi_event_init
c0410f50 t __initcall_acpi_scan_init
c0410f54 t __initcall_pnp_init
c0410f58 t __initcall_pnp_system_init
c0410f5c t __initcall_isapnp_init   <<<<<< patch moved it here <<<
c0410f60 t __initcall_device_init
c0410f64 t __initcall_deadline_slab_setup
c0410f68 t __initcall_pci_acpi_init
c0410f6c t __initcall_pci_legacy_init
c0410f70 t __initcall_pcibios_irq_init
c0410f74 t __initcall_pcibios_init
c0410f78 t __initcall_net_dev_init
c0410f7c t __initcall_init_8259A_devicefs

Or is this not the place to see initcall ordering?

Looking into moving net_dev_init to later...
Martin
