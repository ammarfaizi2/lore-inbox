Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbWF0Dh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbWF0Dh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 23:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWF0Dh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 23:37:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16560 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933296AbWF0Dh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 23:37:57 -0400
Date: Mon, 26 Jun 2006 23:37:49 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: pciehp borkage.
Message-ID: <20060627033749.GB26575@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My head hurts..

drivers/pci/pcie/Kconfig ..

config HOTPLUG_PCI_PCIE
    tristate "PCI Express Hotplug driver"
    depends on HOTPLUG_PCI && PCIEPORTBUS && (BROKEN || ACPI)



but drivers/pci/hotplug/Makefile has..

pciehp-objs     :=  pciehp_core.o   \
                pciehp_ctrl.o   \
                pciehp_pci.o    \
                pciehp_hpc.o

So it gets built regardless of the option, which leaves ppc (among others)
totally busted..

In file included from include/acpi/platform/acenv.h:140,
                 from include/acpi/acpi.h:54,
                 from drivers/pci/hotplug/pciehp_hpc.c:41:
include/acpi/platform/aclinux.h:59:22: error: asm/acpi.h: No such file or directory
In file included from include/acpi/acpi.h:55,
                 from drivers/pci/hotplug/pciehp_hpc.c:41:
include/acpi/actypes.h:129: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'UINT64'
include/acpi/actypes.h:130: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'INT64'
make[3]: *** [drivers/pci/hotplug/pciehp_hpc.o] Error 1
make[2]: *** [drivers/pci/hotplug] Error 2
make[1]: *** [drivers/pci] Error 2


Should that Makefile be more along the lines of..

pciehp-$(CONFIG_PCI_PCIE)	:=  pciehp_core.o   \
                pciehp_ctrl.o   \
                pciehp_pci.o    \
                pciehp_hpc.o

perhaps ?

		Dave

-- 
http://www.codemonkey.org.uk
