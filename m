Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265533AbSJXQdP>; Thu, 24 Oct 2002 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265535AbSJXQdO>; Thu, 24 Oct 2002 12:33:14 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:17869 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265533AbSJXQdN>; Thu, 24 Oct 2002 12:33:13 -0400
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF42@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
Cc: "Luck, Tony" <tony.luck@intel.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: RE: PCI Hotplug Drivers for 2.5
Date: Thu, 24 Oct 2002 09:37:50 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think we now all agree that resource management should move into a
> place where it can be shared by all pci hotplug drivers, right?
> 
> If so, anyone want to propose some common code?  I think the stuff in
> the ACPI driver that was pulled from the Compaq driver is a 
> great start.
> I can try to pull this into the core myself, but if the Intel 
> developers
> have the time, and energy, I would greatly appreciate their help (or
> anyone else who wants to join in.)
> 

Resource Management code in phprm.h works fine for both ACPI based platforms
and non-ACPI platforms (smbios, BIOS $HRT, pcibios_pci_irq_routing...) doing
php enumeration, configuration, resource allocation, etc. Only phprm_acpi.c
is included in this release for size matters.
intcphp driver is free from controller type, IA32/IPF, ACPI/non-ACPI and
depending on kernel configuration, it can bind to either ACPI PHPRM or
non-ACPI PHPRM.

PCI resource handling code - that does add/delete/sort/combine, etc on
pci_resource - has nothing to do with ACPI or non-ACPI so it should be
common across cpqphp, ibmphp, acpiphp and intcphp. They are duplicated and
varied due to mother structures differences.

> thanks,
> 
> greg k-h
> 
