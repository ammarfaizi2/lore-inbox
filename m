Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWIVOvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWIVOvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWIVOvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:51:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16552 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932555AbWIVOvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:51:19 -0400
From: John Keller <jpk@sgi.com>
To: akpm@osdl.org
Cc: linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       ayoung@sgi.com, John Keller <jpk@sgi.com>
Date: Fri, 22 Sep 2006 09:51:09 -0500
Message-Id: <20060922145109.12407.58547.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 0/3] - Altix: Add initial ACPI IO support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
 This patchset was sent out more than a few weeks ago and
there have been no comments or discussion on it.
Can you (or Greg, if that is more appropriate) take this
set of patches?

Regards,

John

------------


Patch set to add initial ACPI IO support to Altix.

1/3 acpi-base-support.patch
     - When booting with an ACPI capable PROM, the
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

      - A new platform vector for bus_fixup is created.
      - The size of io_space[] is increased to support large
        IO configurations.
      - Export pcibios_fixup_device_resources() for use by Altix hotplug
        code.

2/3 acpi-hotplug.patch
      Make necessary changes to hotplug code now that
      bus fixup is done via platform vector.
      Note: This patch is dependent on above patch due to
            pcibios_fixup_device_resources() reference.

3/3 acpi-rom-shadow.patch
      Provide support for PROM shadowing of a ROM image.
