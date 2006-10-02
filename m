Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965309AbWJBTDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbWJBTDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbWJBTC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:02:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19934 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965308AbWJBTC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:02:57 -0400
From: John Keller <jpk@sgi.com>
Message-Id: <200610021902.k92J2hEP124945@fcbayern.americas.sgi.com>
Subject: Re: [PATCH 1/3] - Altix: Add initial ACPI IO support
To: akpm@osdl.org (Andrew Morton)
Date: Mon, 2 Oct 2006 14:02:42 -0500 (CDT)
Cc: jpk@sgi.com (John Keller), linux-ia64@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, ayoung@sgi.com
In-Reply-To: <20061001001511.ae77d6b1.akpm@osdl.org> from "Andrew Morton" at Oct 01, 2006 12:15:11 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 22 Sep 2006 09:51:23 -0500
> John Keller <jpk@sgi.com> wrote:
> 
> > First phase in introducing ACPI support to SN.
> 
> This:
> 
> --- gregkh-2.6.orig/include/linux/pci.h
> +++ gregkh-2.6/include/linux/pci.h
> @@ -405,6 +405,7 @@ extern struct bus_type pci_bus_type;
>  extern struct list_head pci_root_buses;        /* list of all known PCI buses */
>  extern struct list_head pci_devices;   /* list of all devices */
>  
> +void pcibios_fixup_device_resources(struct pci_dev *);
>  void pcibios_fixup_bus(struct pci_bus *);
>  int __must_check pcibios_enable_device(struct pci_dev *, int mask);
>  char *pcibios_setup (char *str);
> 
> breaks a bunch of architectures.
> 
> For example alpha has
> 
> void __init
> pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus)
> 
> box:/usr/src/linux-2.6.18> grep -rl pcibios_fixup_device_resources .
> ./arch/alpha/kernel/pci.c
> ./arch/ia64/pci/pci.c
> ./arch/mips/pci/pci.c
> ./arch/powerpc/kernel/pci_64.c
> ./arch/powerpc/platforms/pseries/pci_dlpar.c
> ./include/asm-powerpc/pci.h
> 
> It needs work...
> 

Interesting. Looks like I made a bad assumption thinking
the definitions would be the same for all archs.

I'll fix and resend.

John



