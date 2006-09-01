Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWIAQBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWIAQBb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIAQBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:01:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7321 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932261AbWIAQB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:01:29 -0400
Date: Fri, 1 Sep 2006 11:01:20 -0500 (CDT)
From: John Keller <jpk@sgi.com>
To: linux-ia64@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, ayoung@sgi.com, linux-kernel@vger.kernel.org,
       John Keller <jpk@sgi.com>, pcihpd-discuss@lists.sourceforge.net
Message-Id: <20060901160120.30625.14877.92881@attica.americas.sgi.com>
Subject: [PATCH 0/3] - Altix: Add initial ACPI IO support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set to add initial ACPI IO support to Altix.

1/3 acpi-base-support.patch
      When booting with an ACPI capable PROM, the
      DSDT will now define the system nodes and root
      PCI busses. An Altix specific ACPI driver will be
      registered for the node devices, while the
      standard acpi_pci_root_driver can now scan
      the PCI busses, eliminating the need for the current
      fixup code to manually initiate the scan. Multiple SAL
      calls are no longer needed, as platform specific info
      is now passed via the ACPI vendor resource descriptor
      (though all the old fixup code still remains due
      to backward compatability requirements).

      A new platform vector for bus_fixup is created.
      The size of io_space[] is increased to support large
      IO configurations.

2/3 acpi-hotplug.patch
      Make necessary changes to hotplug code now that
      bus fixup is done via platform vector.

3/3 acpi-rom-shadow.patch
      Provide support for PROM shadowing of a ROM image.
