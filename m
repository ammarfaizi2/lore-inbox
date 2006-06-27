Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWF0QMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWF0QMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWF0QMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:12:16 -0400
Received: from ns1.suse.de ([195.135.220.2]:5330 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161142AbWF0QMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:12:13 -0400
Date: Tue, 27 Jun 2006 09:08:54 -0700
From: Greg KH <gregkh@suse.de>
To: Josh Boyer <jwboyer@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pciehp borkage.
Message-ID: <20060627160854.GA10332@suse.de>
References: <20060627033749.GB26575@redhat.com> <20060627042750.GA1768@suse.de> <625fc13d0606270519wc506fsa7b1c7e55044ec78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0606270519wc506fsa7b1c7e55044ec78@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 07:19:37AM -0500, Josh Boyer wrote:
> On 6/26/06, Greg KH <gregkh@suse.de> wrote:
> >On Mon, Jun 26, 2006 at 11:37:49PM -0400, Dave Jones wrote:
> >> My head hurts..
> >>
> >> drivers/pci/pcie/Kconfig ..
> >>
> >> config HOTPLUG_PCI_PCIE
> >>     tristate "PCI Express Hotplug driver"
> >>     depends on HOTPLUG_PCI && PCIEPORTBUS && (BROKEN || ACPI)
> >>
> >>
> >>
> >> but drivers/pci/hotplug/Makefile has..
> >>
> >> pciehp-objs     :=  pciehp_core.o   \
> >>                 pciehp_ctrl.o   \
> >>                 pciehp_pci.o    \
> >>                 pciehp_hpc.o
> >>
> >> So it gets built regardless of the option, which leaves ppc (among 
> >others)
> >> totally busted..
> >
> >Yes, this driver does have issues on ppc, see the archives for Anton
> >trying to fix it up to get it to build.  But as ppc currently doesn't
> >_have_ pci express hotplug hardware it really doesn't matter much :)
> >
> >> In file included from include/acpi/platform/acenv.h:140,
> >>                  from include/acpi/acpi.h:54,
> >>                  from drivers/pci/hotplug/pciehp_hpc.c:41:
> >> include/acpi/platform/aclinux.h:59:22: error: asm/acpi.h: No such file 
> >or directory
> >> In file included from include/acpi/acpi.h:55,
> >>                  from drivers/pci/hotplug/pciehp_hpc.c:41:
> >> include/acpi/actypes.h:129: error: expected '=', ',', ';', 'asm' or 
> >'__attribute__' before 'UINT64'
> >> include/acpi/actypes.h:130: error: expected '=', ',', ';', 'asm' or 
> >'__attribute__' before 'INT64'
> >> make[3]: *** [drivers/pci/hotplug/pciehp_hpc.o] Error 1
> >> make[2]: *** [drivers/pci/hotplug] Error 2
> >> make[1]: *** [drivers/pci] Error 2
> >>
> >>
> >> Should that Makefile be more along the lines of..
> >>
> >> pciehp-$(CONFIG_PCI_PCIE)     :=  pciehp_core.o   \
> >>                 pciehp_ctrl.o   \
> >>                 pciehp_pci.o    \
> >>                 pciehp_hpc.o
> >>
> >> perhaps ?
> >
> >No, look up a bit higher:
> >        obj-$(CONFIG_HOTPLUG_PCI_PCIE)          += pciehp.o
> >
> >which will build pciehp or not.  Just don't enable the option for now
> >on ppc please.  Until people sanitize the ACPI headers for non-acpi
> >arches (which is currently underway...)
> 
> Would it be sane to make the Kconfig refuse to enable the option for
> archs that this is known to be broken on?

Sure, no objection from me there.

thanks,

greg k-h
