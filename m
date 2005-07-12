Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVGLJBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVGLJBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVGLJBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:01:25 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:11669 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261205AbVGLJBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:01:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aT6H4jyEDqVvmzqVpBIjpBCv1hvfHq+JpN6o2ImlujwWGOyqKDoCfxYk6QEzzjaQLJrgwRbzN3mrYOptGA19Dtv68WP0OEU3PMvmEvI2KMavg+aftkxszyIMqw/iucfEvTDnGZkKGrGmEDh4vQgPcIhkWW5Sk9fKnYYXnxnGmKM=
Message-ID: <1e2adab705071202015fb9aa50@mail.gmail.com>
Date: Tue, 12 Jul 2005 18:01:22 +0900
From: Rajat Jain <rajatxjain@gmail.com>
Reply-To: rajatj@noida.hcltech.com
To: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       rajatxjain@yahoo.com
Subject: Problem while inserting pciehp (PCI Express Hot-plug) driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use the PCI Express Hot-Plug Controller driver
(pciehp.ko) with Kernel 2.6 so that I can get hot-plug events whenever
I add a card to my PCI Express slot.

I built the driver as a module, and am trying to load it manually
using modprobe. However, when trying to insert, I'm getting the
following error:

pciehp: acpi_pciehprm:\_SB.PCI0 _OSC fails=0x5
pciehp: Both _OSC and OSHP methods do not exist
FATAL: Error inserting pciehp
(/lib/modules/2.6.9-5.18AXcustom-hotplug/kernel/drivers/pci/hotplug/pciehp.ko):
No such device

I do not know what exactly "_OSC" and "OSHP" methods mean? What does
it mean when both these methods are absent? Is there a problem with
the acpi? Or the pciehp?? I would appreciate if anyone could provide
me any pointers.

I passed the "pciehp_debug=1" parameter to modprobe and I'm attaching
the detailed messages at the end of the mail. Analysis showed that the
following functions are returning a status of 0x05

acpi_evaluate_object(ab->handle, METHOD_NAME_OSHP, NULL, &ret_buf)
pci_osc_control_set (OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)

Any ind of help / pointers are apreciated.

TIA,

Rajat

---------------------------Debug Output-----------------------------


Jun 28 16:02:32 localhost kernel: pciehp: Initialize + Start the
notification/polling mechanism
Jun 28 16:02:32 localhost kernel: pciehp: Our event thread pid = 4360
Jun 28 16:02:32 localhost kernel: pciehp: !!!!event_thread sleeping
Jun 28 16:02:32 localhost kernel: pciehp: Initialize slot lists
Jun 28 16:02:32 localhost kernel: pciehp: pciehprm ACPI init <enter>
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm: ROOT PCI
seg(0x0)bus(0x0)dev(0x0)func(0x0) [\_SB_.PCI0]
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 0.
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm:16-Bit Address
Space Resource
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Type: Bus Number
Range(fixed)
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:32 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:32 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:32 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:32 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:32 localhost kernel: pciehp:   Address range min: 00000001
Jun 28 16:02:32 localhost kernel: pciehp:   Address range max: 000000FF
Jun 28 16:02:32 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:32 localhost kernel: pciehp:   Address Length: 000000FF
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 1.
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm:16-Bit Address
Space Resource
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Type: I/O Range
Jun 28 16:02:32 localhost kernel: pciehp:   Type Specific: ISA and
non-ISA Io Addresses
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:32 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:32 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:32 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:32 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:32 localhost kernel: pciehp:   Address range min: 00000000
Jun 28 16:02:32 localhost kernel: pciehp:   Address range max: 00000CF7
Jun 28 16:02:32 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:32 localhost kernel: pciehp:   Address Length: 00000CF8
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 2.
Jun 28 16:02:32 localhost kernel: pciehp: Io Resource
Jun 28 16:02:32 localhost kernel: pciehp:   16 bit decode
Jun 28 16:02:32 localhost kernel: pciehp:   Range minimum base: 00000CF8
Jun 28 16:02:32 localhost kernel: pciehp:   Range maximum base: 00000CF8
Jun 28 16:02:32 localhost kernel: pciehp:   Alignment: 00000001
Jun 28 16:02:32 localhost kernel: pciehp:   Range Length: 00000008
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 3.
Jun 28 16:02:32 localhost kernel: pciehp: acpi_pciehprm:16-Bit Address
Space Resource
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Type: I/O Range
Jun 28 16:02:32 localhost kernel: pciehp:   Type Specific: ISA and
non-ISA Io Addresses
Jun 28 16:02:32 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:32 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:32 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:33 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:33 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Address range min: 00000D00
Jun 28 16:02:33 localhost kernel: pciehp:   Address range max: 0000FFFF
Jun 28 16:02:33 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Address Length: 0000F300
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:33 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 4.
Jun 28 16:02:33 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:33 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:33 localhost kernel: pciehp:   Type Specific: Read/Write
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:33 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:33 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:33 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:33 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Address range min: 000A0000
Jun 28 16:02:33 localhost kernel: pciehp:   Address range max: 000BFFFF
Jun 28 16:02:33 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Address Length: 00020000
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:33 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 5.
Jun 28 16:02:33 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:33 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:33 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:33 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:33 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:33 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:33 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Address range min: 000C0000
Jun 28 16:02:33 localhost kernel: pciehp:   Address range max: 000C3FFF
Jun 28 16:02:33 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:33 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:33 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 6.
Jun 28 16:02:33 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:34 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:34 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:34 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:34 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:34 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:34 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:34 localhost kernel: pciehp:   Address range min: 000C4000
Jun 28 16:02:34 localhost kernel: pciehp:   Address range max: 000C7FFF
Jun 28 16:02:34 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:34 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:34 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 7.
Jun 28 16:02:34 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:34 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:34 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:34 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:34 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:34 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:34 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:34 localhost kernel: pciehp:   Address range min: 000C8000
Jun 28 16:02:34 localhost kernel: pciehp:   Address range max: 000CBFFF
Jun 28 16:02:34 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:34 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:34 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 8.
Jun 28 16:02:34 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:34 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:34 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:34 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:34 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:34 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:34 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:34 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Address range min: 000CC000
Jun 28 16:02:35 localhost kernel: pciehp:   Address range max: 000CFFFF
Jun 28 16:02:35 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:35 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 9.
Jun 28 16:02:35 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:35 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:35 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:35 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:35 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:35 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:35 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Address range min: 000D0000
Jun 28 16:02:35 localhost kernel: pciehp:   Address range max: 000D3FFF
Jun 28 16:02:35 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:35 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure a.
Jun 28 16:02:35 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:35 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:35 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:35 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:35 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:35 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:35 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Address range min: 000D4000
Jun 28 16:02:35 localhost kernel: pciehp:   Address range max: 000D7FFF
Jun 28 16:02:35 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:35 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure b.
Jun 28 16:02:35 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:35 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:35 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:36 localhost kernel: pciehp:   Type Specific: Read/Write
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:36 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:36 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:36 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:36 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:36 localhost kernel: pciehp:   Address range min: 000D8000
Jun 28 16:02:36 localhost kernel: pciehp:   Address range max: 000DBFFF
Jun 28 16:02:36 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:36 localhost kernel: pciehp:   Address Length: 00004000
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:36 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure c.
Jun 28 16:02:36 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:36 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:36 localhost kernel: pciehp:   Type Specific: Read/Write
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:36 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:36 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:36 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:36 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:36 localhost kernel: pciehp:   Address range min: 000DC000
Jun 28 16:02:36 localhost kernel: pciehp:   Address range max: 000DFFFF
Jun 28 16:02:36 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:36 localhost kernel: pciehp:   Address Length: 00004000
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:36 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure d.
Jun 28 16:02:36 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:36 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:36 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:36 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:36 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:36 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:36 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:36 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Address range min: 000E0000
Jun 28 16:02:37 localhost kernel: pciehp:   Address range max: 000E3FFF
Jun 28 16:02:37 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:37 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure e.
Jun 28 16:02:37 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:37 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:37 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:37 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:37 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:37 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:37 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Address range min: 000E4000
Jun 28 16:02:37 localhost kernel: pciehp:   Address range max: 000E7FFF
Jun 28 16:02:37 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:37 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure f.
Jun 28 16:02:37 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:37 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:37 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:37 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:37 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:37 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:37 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Address range min: 000E8000
Jun 28 16:02:37 localhost kernel: pciehp:   Address range max: 000EBFFF
Jun 28 16:02:37 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:37 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:38 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 10.
Jun 28 16:02:38 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:38 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:38 localhost kernel: pciehp:   Type Specific: Read Only
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:38 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:38 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:38 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:38 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:38 localhost kernel: pciehp:   Address range min: 000EC000
Jun 28 16:02:38 localhost kernel: pciehp:   Address range max: 000EFFFF
Jun 28 16:02:38 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:38 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:38 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 11.
Jun 28 16:02:38 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:38 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:38 localhost kernel: pciehp:   Type Specific: Read/Write
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:38 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:38 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:38 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:38 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:38 localhost kernel: pciehp:   Address range min: D0000000
Jun 28 16:02:38 localhost kernel: pciehp:   Address range max: FEBFFFFF
Jun 28 16:02:38 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:38 localhost kernel: pciehp:   Address Length: 2EC00000
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:38 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 12.
Jun 28 16:02:38 localhost kernel: pciehp: acpi_pciehprm:32-Bit Address
Space Resource
Jun 28 16:02:38 localhost kernel: pciehp:   Resource Type: Memory Range
Jun 28 16:02:38 localhost kernel: pciehp:   Type Specific: Cacheable memory
Jun 28 16:02:38 localhost kernel: pciehp:   Type Specific: Read/Write
Jun 28 16:02:39 localhost kernel: pciehp:   Resource Producer
Jun 28 16:02:39 localhost kernel: pciehp:   Positive decode
Jun 28 16:02:39 localhost kernel: pciehp:   Min address is  fixed
Jun 28 16:02:39 localhost kernel: pciehp:   Max address is  fixed
Jun 28 16:02:39 localhost kernel: pciehp:   Granularity: 00000000
Jun 28 16:02:39 localhost kernel: pciehp:   Address range min: 00000000
Jun 28 16:02:39 localhost kernel: pciehp:   Address range max: 00000000
Jun 28 16:02:39 localhost kernel: pciehp:   Address translation offset: 00000000
Jun 28 16:02:39 localhost kernel: pciehp:   Address Length: 00000000
Jun 28 16:02:39 localhost kernel: pciehp:   Resource Source Index: 0
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: PCI bus 0x0
Resource structure 13.
Jun 28 16:02:39 localhost kernel: pciehp: End_tag -------- Resource
Jun 28 16:02:39 localhost kernel: pciehp:
pciehp_resource_sort_and_combine: head = f7d1b7c8, *head = f5477d40
Jun 28 16:02:39 localhost kernel: pciehp: *head->next = 00000000
Jun 28 16:02:39 localhost kernel: pciehp:
pciehp_resource_sort_and_combine: head = f7d1b7c4, *head = f5477cc0
Jun 28 16:02:39 localhost kernel: pciehp: *head->next = f5477ca0
Jun 28 16:02:39 localhost kernel: pciehp: *head->base = 0xd00
Jun 28 16:02:39 localhost kernel: pciehp: *head->next->base = 0x0
Jun 28 16:02:39 localhost kernel: pciehp:
pciehp_resource_sort_and_combine: head = f7d1b7bc, *head = f6044fc0
Jun 28 16:02:39 localhost kernel: pciehp: *head->next = f5477f40
Jun 28 16:02:39 localhost kernel: pciehp: *head->base = 0xd0000000
Jun 28 16:02:39 localhost kernel: pciehp: *head->next->base = 0xd8000
Jun 28 16:02:39 localhost kernel: pciehp:
pciehp_resource_sort_and_combine: head = f7d1b7c0, *head = 00000000

Jun 28 16:02:39 localhost kernel: pciehp: add_host_bridge: status 5
Jun 28 16:02:39 localhost kernel: pciehp: add_host_bridge: status 5
run__osc_success 0 osc_exist 0

Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI HOST Bridge(00)    on s:b:d:f(00:00:00:00) [\_SB_.PCI0]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: P2P(0-1) on
pci=b:d:f(0:2:0) acpi=b:d:f(0:2:0) [\_SB_.PCI0.PE1A]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(00-01) on s:b:d:f(00:00:02:00) [\_SB_.PCI0.PE1A]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: P2P(1-2) on
pci=b:d:f(1:0:0) acpi=b:d:f(1:0:0) [\_SB_.PCI0.PE1A.PXHA]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(01-02) on s:b:d:f(00:01:00:00) [\_SB_.PCI0.PE1A.PXHA]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: P2P(1-3) on
pci=b:d:f(1:0:2) acpi=b:d:f(1:0:2) [\_SB_.PCI0.PE1A.PXHB]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(01-03) on s:b:d:f(00:01:00:02) [\_SB_.PCI0.PE1A.PXHB]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: P2P(0-4) on
pci=b:d:f(0:4:0) acpi=b:d:f(0:4:0) [\_SB_.PCI0.PE2A]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(00-04) on s:b:d:f(00:00:04:00) [\_SB_.PCI0.PE2A]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: P2P(0-5) on
pci=b:d:f(0:5:0) acpi=b:d:f(0:5:0) [\_SB_.PCI0.PE2B]
Jun 28 16:02:39 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(00-05) on s:b:d:f(00:00:05:00) [\_SB_.PCI0.PE2B]
Jun 28 16:02:40 localhost kernel: pciehp: acpi_pciehprm: P2P(0-6) on
pci=b:d:f(0:6:0) acpi=b:d:f(0:6:0) [\_SB_.PCI0.PE3A]
Jun 28 16:02:40 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(00-06) on s:b:d:f(00:00:06:00) [\_SB_.PCI0.PE3A]
Jun 28 16:02:40 localhost kernel: pciehp: acpi_pciehprm: P2P(0-f) on
pci=b:d:f(0:7:0) acpi=b:d:f(0:7:0) [\_SB_.PCI0.PE3B]
Jun 28 16:02:40 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(00-0f) on s:b:d:f(00:00:07:00) [\_SB_.PCI0.PE3B]
Jun 28 16:02:40 localhost kernel: pciehp: acpi_pciehprm: P2P(0-10) on
pci=b:d:f(0:1e:0) acpi=b:d:f(0:1e:0) [\_SB_.PCI0.PCIB]
Jun 28 16:02:40 localhost kernel: pciehp: acpi_pciehprm: Registered
PCI  P2P Bridge(00-10) on s:b:d:f(00:00:1e:00) [\_SB_.PCI0.PCIB]

Jun 28 16:02:40 localhost kernel: pciehp: Both _OSC and OSHP methods
do not exist

Jun 28 16:02:40 localhost kernel: pciehp: pciehprm_init:
run__osc_success 0 osc_exist 0
Jun 28 16:02:40 localhost kernel: pciehp: pciehprm_init:
run_oshp_success 0 oshp_exist 0pciehp: pciehprm ACPI init fail

Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(1-2) [\_SB_.PCI0.PE1A.PXHA] on s:b:d:f(0:1:0:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(1-3) [\_SB_.PCI0.PE1A.PXHB] on s:b:d:f(0:1:0:2)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(0-1) [\_SB_.PCI0.PE1A] on s:b:d:f(0:0:2:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(0-4) [\_SB_.PCI0.PE2A] on s:b:d:f(0:0:4:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(0-5) [\_SB_.PCI0.PE2B] on s:b:d:f(0:0:5:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(0-6) [\_SB_.PCI0.PE3A] on s:b:d:f(0:0:6:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(0-f) [\_SB_.PCI0.PE3B] on s:b:d:f(0:0:7:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI P2P
Bridge(0-10) [\_SB_.PCI0.PCIB] on s:b:d:f(0:0:1e:0)
Jun 28 16:02:40 localhost kernel: pciehp: Free ACPI PCI HOST Bridge(0)
[\_SB_.PCI0] on s:b:d:f(0:0:0:0)

Jun 28 16:02:40 localhost kernel: pciehp: event_thread finish command given
Jun 28 16:02:40 localhost kernel: pciehp: wait for event_thread to exit
Jun 28 16:02:40 localhost kernel: pciehp: event_thread woken finished = 1
Jun 28 16:02:40 localhost kernel: pciehp: event_thread signals exit
