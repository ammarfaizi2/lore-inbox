Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVEUAfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVEUAfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVEUAeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:34:21 -0400
Received: from fmr18.intel.com ([134.134.136.17]:15054 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261621AbVEUAdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:33:35 -0400
Message-Id: <20050521004239.581618000@csdlinux-1>
Date: Fri, 20 May 2005 17:42:39 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, len.brown@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: [patch 0/2] Collecting host bridge resources
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI hotplug code now uses the PCI core to allocate and manage
resources for hot-plug devices. To work correctly, this requires
all bridges to report resources they are decoding in their
pci_bus structure. We already do this for PCI-PCI bridges, but
not for host bridges. This patchset reads and stores host bridge
resources reported by ACPI BIOS for i386 and x86_64 systems.
Without this, we currently assume that all host bridges decode
all unused resources in iomem_resource and ioport_resource.
This patchset also adds a boot parameter (acpi=root_resources),
and the code to collect resources does not trigger unless it
is enabled via this boot option. This fixes hotplug failures
on some IBM (xseries) systems, and has been previously discussed
on the pci hotplug mailing list.

The current pci_bus structure can only store 4 resource
descriptors for a bus, but many host bridges decode more than 4
ranges. Storing incomplete host bridges resource ranges could
lead to resource-not-available errors for devices that were
otherwise properly configured by BIOS. Hence, this code triggers
only when it is explicitly enabled using the acpi=root_resources
boot option. For now, I expect that only systems that have PCI
hotplug slots directly under a host bridge will enable this option.

Rajesh

--
