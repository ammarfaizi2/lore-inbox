Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVI3F5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVI3F5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 01:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbVI3F5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 01:57:11 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:20331 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751435AbVI3F5I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 01:57:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+IFllmre9B5TWvFzBbpdVUOve2YyWwfxr/BZA++G/EN4Fhp6Yx0qqaXm8GPrVMOiJeIa4dQbopgJv46KFEzjS109OWMbfhYRRoFGWkz9V1HWN7EH+lY1muI5ymcPS4gIA55UPd0lNSXfS75pufJMTIfsIffC/7RHx59QR8VyI0=
Message-ID: <b115cb5f0509292257j395d60f8j53d1afa967caa263@mail.gmail.com>
Date: Fri, 30 Sep 2005 14:57:07 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] Re: ACPI problem with PCI Express Native Hot-plug driver
Cc: Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       greg@kroah.com, dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
In-Reply-To: <b115cb5f05090418583abfc73@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b115cb5f0509020057741365dc@mail.gmail.com>
	 <b115cb5f050902005877607db1@mail.gmail.com>
	 <1125683188.13185.5.camel@whizzy>
	 <b115cb5f05090418583abfc73@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using stock kernel 2.6.13 on RHEL4 Distribution, and am trying to
make PCI Express Native Hot-plug driver (pciehp) work on my system (My
system has two hot-pluggable PCI Express slots). I am facing following
problem, and would really appreciate if any one can provide any info
regarding this problem. (I had earlier tried RHEL4 kernel, but as
suggested by list, have tried with 2.6.13. but to no avail).

When I disable the ACPI support in my kernel configuration, the
("non-acpi") pciehp driver inserts successfully and I see the
following two entries appearing in my /sys/bus/pci/slots:

drwxr-xr-x  2 root root 0 Sep  2 14:28 10
drwxr-xr-x  2 root root 0 Sep  2 14:28 11

However, when I enable the ACPI support in the kernel, the controller
initialization fails giving me following error (excerpts):

......
......
pciehp: pfar:cannot locate acpi bridge of PCI 0xb.
pciehp: pciehprm_find_available_resources = 0xffffffff
pciehp: unable to locate PCI configuration resources for hot plug add.
......
......
pciehp: pfar:cannot locate acpi bridge of PCI 0xe.
pciehp: pciehprm_find_available_resources = 0xffffffff
pciehp: unable to locate PCI configuration resources for hot plug add.
......
......

I am not sure where the problem lies. But the fact that the entries
are appearing correctly when I disable ACPI, combined with above error
messages, I suspect that there is a problem with ACPI namespace
(probably the resources cannot be found using ACPI).

I have two questions:

1) How can I go about tackling this problem? The possibility of BIOS /
Hardware being faulty cannot be ruled out. But then what exactly is
missing and how can that be solved (I can tell my BIOS provider /
hardware provider to correct the problem, but I need to pinpoint the
problem). Is some thing missing in the AML?

2) If the resources are actually missing, then how does the driver
find the required resources when I disable the ACPI from kernel?

I am attaching complete logs of both the cases (The one with ACPI
enabled and giving this error, the other - ACPI disabled and
displaying the slot entries) with highlighted error message. I would
really appreciate if any one can provide me any kind of pointers.

TIA,

Rajat


===========================================
ACPI Enabled Error Log
===========================================
 Initialize + Start the notification/polling mechanism
 Our event thread pid = 5691
 Initialize slot lists
 pciehprm ACPI init <enter>
 acpi_pciehprm: ROOT PCI seg(0x0)bus(0x0)dev(0x0)func(0x0) [\_SB_.PCI0]
 acpi_pciehprm: PCI bus 0x0 Resource structure 0.
 acpi_pciehprm:16-Bit Address Space Resource
   Resource Type: Bus Number Range(fixed)
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 00000001
   Address range max: 000000FF
   Address translation offset: 00000000
   Address Length: 000000FF
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 1.
 acpi_pciehprm:16-Bit Address Space Resource
   Resource Type: I/O Range
   Type Specific: ISA and non-ISA Io Addresses
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 00000000
   Address range max: 00000CF7
   Address translation offset: 00000000
   Address Length: 00000CF8
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 2.
 Io Resource
   16 bit decode
   Range minimum base: 00000CF8
   Range maximum base: 00000CF8
   Alignment: 00000001
   Range Length: 00000008
 acpi_pciehprm: PCI bus 0x0 Resource structure 3.
 acpi_pciehprm:16-Bit Address Space Resource
   Resource Type: I/O Range
   Type Specific: ISA and non-ISA Io Addresses
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 00000D00
   Address range max: 0000FFFF
   Address translation offset: 00000000
   Address Length: 0000F300
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 4.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read/Write
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000A0000
   Address range max: 000BFFFF
   Address translation offset: 00000000
   Address Length: 00020000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 5.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000C0000
   Address range max: 000C3FFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 6.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000C4000
   Address range max: 000C7FFF
   Address translation offset: 00000000
   Address Length: 00000000
 !!!!event_thread sleeping
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 7.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000C8000
   Address range max: 000CBFFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 8.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000CC000
   Address range max: 000CFFFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 9.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000D0000
   Address range max: 000D3FFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure a.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000D4000
   Address range max: 000D7FFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure b.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read/Write
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000D8000
   Address range max: 000DBFFF
   Address translation offset: 00000000
   Address Length: 00004000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure c.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read/Write
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000DC000
   Address range max: 000DFFFF
   Address translation offset: 00000000
   Address Length: 00004000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure d.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000E0000
   Address range max: 000E3FFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure e.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000E4000
   Address range max: 000E7FFF
   Address translation offset: 00000000
   Address Length: 00000000
Sep 28 17:39:52 localhost su[5683]: Warning!  Could not get current
context for /dev/pts/0, not relabeling.
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure f.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000E8000
   Address range max: 000EBFFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 10.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read Only
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 000EC000
   Address range max: 000EFFFF
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 11.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read/Write
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: D0000000
   Address range max: FEBFFFFF
   Address translation offset: 00000000
   Address Length: 2EC00000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 12.
 acpi_pciehprm:32-Bit Address Space Resource
   Resource Type: Memory Range
   Type Specific: Cacheable memory
   Type Specific: Read/Write
   Resource Producer
   Positive decode
   Min address is  fixed
   Max address is  fixed
   Granularity: 00000000
   Address range min: 00000000
   Address range max: 00000000
   Address translation offset: 00000000
   Address Length: 00000000
   Resource Source Index: 0
 acpi_pciehprm: PCI bus 0x0 Resource structure 13.
 End_tag -------- Resource
 pciehp_resource_sort_and_combine: head = f3ced148, *head = f5645aa0
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f3ced144, *head = f6cf4300
 *head->next = f79e8d00
 *head->base = 0xd00
 *head->next->base = 0x0
 pciehp_resource_sort_and_combine: head = f3ced13c, *head = f3c7aa40
 *head->next = f718fc40
 *head->base = 0xd0000000
 *head->next->base = 0xd8000
 pciehp_resource_sort_and_combine: head = f3ced140, *head = 00000000
 add_host_bridge: osc_run_status 5
 acpi_pciehprm: Registered PCI HOST Bridge(00)    on
s:b:d:f(00:00:00:00) [\_SB_.PCI0]
 acpi_pciehprm: P2P(0-1) on pci=b:d:f(0:2:0) acpi=b:d:f(0:2:0) [\_SB_.PCI0.PE1A]
 acpi_pciehprm: Registered PCI  P2P Bridge(00-01) on
s:b:d:f(00:00:02:00) [\_SB_.PCI0.PE1A]
 acpi_pciehprm: P2P(1-2) on pci=b:d:f(1:0:0) acpi=b:d:f(1:0:0)
[\_SB_.PCI0.PE1A.PXHA]
 acpi_pciehprm: Registered PCI  P2P Bridge(01-02) on
s:b:d:f(00:01:00:00) [\_SB_.PCI0.PE1A.PXHA]
 acpi_pciehprm: P2P(1-3) on pci=b:d:f(1:0:2) acpi=b:d:f(1:0:2)
[\_SB_.PCI0.PE1A.PXHB]
 acpi_pciehprm: Registered PCI  P2P Bridge(01-03) on
s:b:d:f(00:01:00:02) [\_SB_.PCI0.PE1A.PXHB]
 acpi_pciehprm: P2P(0-4) on pci=b:d:f(0:4:0) acpi=b:d:f(0:4:0) [\_SB_.PCI0.PE2A]
 acpi_pciehprm: Registered PCI  P2P Bridge(00-04) on
s:b:d:f(00:00:04:00) [\_SB_.PCI0.PE2A]
 acpi_pciehprm: P2P(0-5) on pci=b:d:f(0:5:0) acpi=b:d:f(0:5:0) [\_SB_.PCI0.PE2B]
 acpi_pciehprm: Registered PCI  P2P Bridge(00-05) on
s:b:d:f(00:00:05:00) [\_SB_.PCI0.PE2B]
 acpi_pciehprm: P2P(0-6) on pci=b:d:f(0:6:0) acpi=b:d:f(0:6:0) [\_SB_.PCI0.PE3A]
 acpi_pciehprm: Registered PCI  P2P Bridge(00-06) on
s:b:d:f(00:00:06:00) [\_SB_.PCI0.PE3A]
 acpi_pciehprm: P2P(0-13) on pci=b:d:f(0:7:0) acpi=b:d:f(0:7:0)
[\_SB_.PCI0.PE3B]
 acpi_pciehprm: Registered PCI  P2P Bridge(00-13) on
s:b:d:f(00:00:07:00) [\_SB_.PCI0.PE3B]
 acpi_pciehprm: P2P(0-14) on pci=b:d:f(0:1e:0) acpi=b:d:f(0:1e:0)
[\_SB_.PCI0.PCIB]
 acpi_pciehprm: Registered PCI  P2P Bridge(00-14) on
s:b:d:f(00:00:1e:00) [\_SB_.PCI0.PCIB]
 pciehprm ACPI init success
 pciehp_probe: Called by hp_drv
 pciehp_probe: DRV_thread pid = 5684
 pcie_init: pdev->vendor 1033 pdev->device 124
 pcie_init: pcie_cap_base 0
 pcie_init: CAP_REG offset 62 cap_reg 161
 pcie_init: SLOT_CAP offset 74 slot_cap 500540
 pcie_init: SLOT_STATUS offset 7a slot_status 100
 pcie_init: SLOT_CTRL offset 78 slot_ctrl 7c0
 pdev = c1b2f800: b:d:f:irq=0x7:1:0:e1
 pci resource[7] start=0x5000(len=0x1000)
 pci resource[8] start=0xd0400000(len=0x100000)
 pci resource[9] start=0xd0900000(len=0x100000)
 HPC vendor_id 1033 device_id 124 ss_vid 0 ss_did 0
Sep 28 17:39:55 localhost kernel: ACPI: PCI Interrupt 0000:07:01.0[A]
-> GSI 17 (level, low) -> IRQ 169
 HPC interrupt = 225
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init : Mask HPIE hp_register_write_word SLOT_CTRL 7c0
 pcie_init: Mask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pcie_init: request_irq 225 for hpc0 (returns 0)
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init: slot_cap 500540
 pcie_init: temp_word 7e8
 pcie_init : Unmask HPIE hp_register_write_word SLOT_CTRL with 7e8
 pcie_init: Unmask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pciehp_probe: ctrl->pci_bus f6fd5d80
 pciehp_probe: ctrl bus=0x7, device=1, function=0, irq=a9
 pcie_get_ctlr_slot_config: PSN 10
 get_ctlr_slot_config: bus(0xb) num_slot(0x1) 1st_dev(0x0) psn(0xa)
ctrlcap(40) for b:d (7:1)
 pciehp_probe: Before calling pciehp_save_config, ctrl->bus 7,ctrl->slot_bus b
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 1, first_device_num = 0
 FirstSupported = 0, LastSupported = 0
 pciehp_save_config: pci_bus->number = b
 pciehp_save_config: bus = b, dev = 0
 pciehp_save_config: ID = 3408086
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = b
 pciehp_save_config: bus = c, dev = 0
 pciehp_save_config: ID = 23221077
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus c device 7 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus c dev 7 fun 0
 pciehp_slot_create: busnumber c
 pciehp_save_config: if, new_slot = f6fd5780 bus c dev 7 fun 0
 new_slot->pci_dev = c1b39400
 pciehp_save_config: In while loop
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus c device 7 index 0
 pciehp_slot_find: func-> bus c device 7 function 0 pci_dev c1b39400
 pciehp_save_config: new_slot = f6fd5780 bus c dev 7 fun 0
 pciehp_slot_find: bus c device 7 index 1
 pciehp_slot_find: func-> bus c device 7 function 0 pci_dev c1b39400
 pciehp_save_config: while loop, new_slot = 00000000 bus c dev 7 fun 1
 pciehp_slot_create: busnumber c
 pciehp_save_config: if, new_slot = f731f080 bus c dev 7 fun 1
 new_slot->pci_dev = c1b39000
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: Exit
 pciehp_slot_find: bus b device 0 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus b dev 0 fun 0
 pciehp_slot_create: busnumber b
 pciehp_save_config: if, new_slot = f731f180 bus b dev 0 fun 0
 new_slot->pci_dev = c1b39c00
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = b
 pciehp_save_config: bus = d, dev = 0
 pciehp_save_config: Exit
 pciehp_slot_find: bus b device 0 index 0
 pciehp_slot_find: func-> bus b device 0 function 0 pci_dev c1b39c00
 pciehp_save_config: new_slot = f731f180 bus b dev 0 fun 0
 pciehp_slot_find: bus b device 0 index 1
 pciehp_slot_find: func-> bus b device 0 function 0 pci_dev c1b39c00
 pciehp_save_config: while loop, new_slot = 00000000 bus b dev 0 fun 1
 pciehp_slot_create: busnumber b
 pciehp_save_config: if, new_slot = f731f280 bus b dev 0 fun 2
 new_slot->pci_dev = c1b39800
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: Exit
---------------------------------------------------------
 pfar:cannot locate acpi bridge of PCI 0xb.
 pciehprm_find_available_resources = 0xffffffff
 unable to locate PCI configuration resources for hot plug add.
----------------------------------------------------------
 pciehp_probe: Called by hp_drv
 pciehp_probe: DRV_thread pid = 5684
 pcie_init: pdev->vendor 1033 pdev->device 124
 pcie_init: pcie_cap_base 0
 pcie_init: CAP_REG offset 62 cap_reg 161
 pcie_init: SLOT_CAP offset 74 slot_cap 580540
 pcie_init: SLOT_STATUS offset 7a slot_status 100
 pcie_init: SLOT_CTRL offset 78 slot_ctrl 7c0
 pdev = c1b2f400: b:d:f:irq=0x7:2:0:e9
 pci resource[7] start=0x6000(len=0x1000)
 pci resource[8] start=0xd0500000(len=0x100000)
 pci resource[9] start=0xd0a00000(len=0x100000)
 HPC vendor_id 1033 device_id 124 ss_vid 0 ss_did 0
Sep 28 17:39:59 localhost kernel: ACPI: PCI Interrupt 0000:07:02.0[A]
-> GSI 18 (level, low) -> IRQ 177
 HPC interrupt = 233
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init : Mask HPIE hp_register_write_word SLOT_CTRL 7c0
 pcie_init: Mask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pcie_init: request_irq 233 for hpc1 (returns 0)
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init: slot_cap 580540
 pcie_init: temp_word 7e8
 pcie_init : Unmask HPIE hp_register_write_word SLOT_CTRL with 7e8
 pcie_init: Unmask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pciehp_probe: ctrl->pci_bus f6fd5d80
 pciehp_probe: ctrl bus=0x7, device=2, function=0, irq=b1
 pcie_get_ctlr_slot_config: PSN 11
 get_ctlr_slot_config: bus(0xe) num_slot(0x1) 1st_dev(0x0) psn(0xb)
ctrlcap(40) for b:d (7:2)
 pciehp_probe: Before calling pciehp_save_config, ctrl->bus 7,ctrl->slot_bus e
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 1, first_device_num = 0
 FirstSupported = 0, LastSupported = 0
 pciehp_save_config: pci_bus->number = e
 pciehp_save_config: bus = e, dev = 0
 pciehp_save_config: ID = 3408086
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = e
 pciehp_save_config: bus = f, dev = 0
 pciehp_save_config: ID = 23221077
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus f device 7 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus f dev 7 fun 0
 pciehp_slot_create: busnumber f
 pciehp_save_config: if, new_slot = f731f380 bus f dev 7 fun 0
 new_slot->pci_dev = c1b3d400
 pciehp_save_config: In while loop
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus f device 7 index 0
 pciehp_slot_find: func-> bus f device 7 function 0 pci_dev c1b3d400
 pciehp_save_config: new_slot = f731f380 bus f dev 7 fun 0
 pciehp_slot_find: bus f device 7 index 1
 pciehp_slot_find: func-> bus f device 7 function 0 pci_dev c1b3d400
 pciehp_save_config: while loop, new_slot = 00000000 bus f dev 7 fun 1
 pciehp_slot_create: busnumber f
 pciehp_save_config: if, new_slot = f731f480 bus f dev 7 fun 1
 new_slot->pci_dev = c1b3d000
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: Exit
 pciehp_slot_find: bus e device 0 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus e dev 0 fun 0
 pciehp_slot_create: busnumber e
 pciehp_save_config: if, new_slot = f731f580 bus e dev 0 fun 0
 new_slot->pci_dev = c1b3dc00
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = e
 pciehp_save_config: bus = 10, dev = 0
 pciehp_save_config: Exit
 pciehp_slot_find: bus e device 0 index 0
 pciehp_slot_find: func-> bus e device 0 function 0 pci_dev c1b3dc00
 pciehp_save_config: new_slot = f731f580 bus e dev 0 fun 0
 pciehp_slot_find: bus e device 0 index 1
 pciehp_slot_find: func-> bus e device 0 function 0 pci_dev c1b3dc00
 pciehp_save_config: while loop, new_slot = 00000000 bus e dev 0 fun 1
 pciehp_slot_create: busnumber e
 pciehp_save_config: if, new_slot = f731f680 bus e dev 0 fun 2
 new_slot->pci_dev = c1b3d800
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: Exit
----------------------------------------------------------------
 pfar:cannot locate acpi bridge of PCI 0xe.
 pciehprm_find_available_resources = 0xffffffff
 unable to locate PCI configuration resources for hot plug add.
------------------------------------------------------------------
 pcie_port_service_register = 0
 PCI Express Hot Plug Controller Driver version: 0.4
 PCIEHPRM ACPI Slots
 PCI HOST Bridge (0) [\_SB_.PCI0]
     Total BUS Resources:
         base= 0x1 length= 0xff
     BUS Resources:
         base= 0x1 length= 0xff
     Total IO Resources:
         base= 0xd00 length= 0xf300
         base= 0x0 length= 0xcf8
     IO Resources:
         base= 0x0 length= 0xcf8
         base= 0xd00 length= 0xf300
     Total MEM Resources:
         base= 0xd0000000 length= 0x2ec00000
         base= 0xd8000 length= 0x8000
         base= 0xa0000 length= 0x20000
     MEM Resources:
         base= 0xa0000 length= 0x20000
         base= 0xd8000 length= 0x8000
         base= 0xd0000000 length= 0x2ec00000
 PCI P2P Bridge (0-14) [\_SB_.PCI0.PCIB]
 PCI P2P Bridge (0-13) [\_SB_.PCI0.PE3B]
 PCI P2P Bridge (0-6) [\_SB_.PCI0.PE3A]
 PCI P2P Bridge (0-5) [\_SB_.PCI0.PE2B]
 PCI P2P Bridge (0-4) [\_SB_.PCI0.PE2A]
 PCI P2P Bridge (0-1) [\_SB_.PCI0.PE1A]
 PCI P2P Bridge (1-3) [\_SB_.PCI0.PE1A.PXHB]
 PCI P2P Bridge (1-2) [\_SB_.PCI0.PE1A.PXHA]







===============================================
Log when ACPI Disabled
===============================================


 Our event thread pid = 5192
 Initialize slot lists
 pciehp_probe: Called by hp_drv
 pciehp_probe: DRV_thread pid = 5188
 pcie_init: pdev->vendor 1033 pdev->device 124
 pcie_init: pcie_cap_base 0
 pcie_init: CAP_REG offset 62 cap_reg 161
 pcie_init: SLOT_CAP offset 74 slot_cap 500540
 pcie_init: SLOT_STATUS offset 7a slot_status 100
 pcie_init: SLOT_CTRL offset 78 slot_ctrl 7c0
 pdev = f7f04800: b:d:f:irq=0x7:1:0:e1
 pci resource[7] start=0x5000(len=0x1000)
 pci resource[9] start=0xd0900000(len=0x100000)
 HPC vendor_id 1033 device_id 124 ss_vid 0 ss_did 0
 HPC interrupt = 225
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init : Mask HPIE hp_register_write_word SLOT_CTRL 7c0
 pcie_init: Mask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pcie_init: request_irq 225 for hpc0 (returns 0)
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init: slot_cap 500540
 pcie_init: temp_word 7e8
 pcie_init : Unmask HPIE hp_register_write_word SLOT_CTRL with 7e8
 pcie_init: Unmask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pciehp_probe: ctrl->pci_bus f5042c80
 pciehp_probe: ctrl bus=0x7, device=1, function=0, irq=e1
 pcie_get_ctlr_slot_config: PSN 10
 get_ctlr_slot_config: bus(0xb) num_slot(0x1) 1st_dev(0x0) psn(0xa)
ctrlcap(40) for b:d (7:1)
 pciehp_probe: Before calling pciehp_save_config, ctrl->bus 7,ctrl->slot_bus b
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 1, first_device_num = 0
 FirstSupported = 0, LastSupported = 0
 pciehp_save_config: pci_bus->number = b
 pciehp_save_config: bus = b, dev = 0
 pciehp_save_config: ID = 3408086
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = b
 pciehp_save_config: bus = c, dev = 0
 pciehp_save_config: ID = 23221077
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus c device 7 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus c dev 7 fun 0
 pciehp_slot_create: busnumber c
 pciehp_save_config: if, new_slot = f695f280 bus c dev 7 fun 0
 new_slot->pci_dev = f7f05400
 pciehp_save_config: In while loop
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus c device 7 index 0
 pciehp_slot_find: func-> bus c device 7 function 0 pci_dev f7f05400
 pciehp_save_config: new_slot = f695f280 bus c dev 7 fun 0
 pciehp_slot_find: bus c device 7 index 1
 pciehp_slot_find: func-> bus c device 7 function 0 pci_dev f7f05400
 pciehp_save_config: while loop, new_slot = 00000000 bus c dev 7 fun 1
 pciehp_slot_create: busnumber c
 pciehp_save_config: if, new_slot = f695f080 bus c dev 7 fun 1
 new_slot->pci_dev = f7f05000
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 !!!!event_thread sleeping
 Nothing there
 pciehp_save_config: Exit
 pciehp_slot_find: bus b device 0 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus b dev 0 fun 0
 pciehp_slot_create: busnumber b
 pciehp_save_config: if, new_slot = f695f580 bus b dev 0 fun 0
 new_slot->pci_dev = f7f05c00
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = b
 pciehp_save_config: bus = d, dev = 0
 pciehp_save_config: Exit
 pciehp_slot_find: bus b device 0 index 0
 pciehp_slot_find: func-> bus b device 0 function 0 pci_dev f7f05c00
 pciehp_save_config: new_slot = f695f580 bus b dev 0 fun 0
 pciehp_slot_find: bus b device 0 index 1
 pciehp_slot_find: func-> bus b device 0 function 0 pci_dev f7f05c00
 pciehp_save_config: while loop, new_slot = 00000000 bus b dev 0 fun 1
 pciehp_slot_create: busnumber b
 pciehp_save_config: if, new_slot = f695f480 bus b dev 0 fun 2
 new_slot->pci_dev = f7f05800
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
Nothing there
 pciehp_save_config: Exit
 Save_used_res of PCI bridge b:d=0x7:1, sc=0x507
 pciehprm_find_available_resources: pciehp_save_used_resources rc = 0
 pciehp_resource_sort_and_combine: head = f78e36b4, *head = f30c5d80
 *head->next = 00000000
 pciehprm_find_available_resources:pre-Bind PCI 0x7 Ctrl Resource Dump
 :    BUS Resources:
         base= 0xc length= 0x2
 :    IO Resources:
         base= 0x5000 length= 0x1000
 :    MEM Resources:
         base= 0xd0400000 length= 0x100000
 :    PMEM Resources:
         base= 0xd0910000 length= 0x100000
 pciehprm_find_available_resources: before bind_pci_resources_to slots
 bind_pci_resources_to_slots: vid = 3408086 bus b dev 0 fun 0
 pciehp_slot_find: bus b device 0 index 0
 pciehp_slot_find: func-> bus b device 0 function 0 pci_dev f7f05c00
 bind_pci_resources_to_slots: func = f695f580
 Save_used_res of PCI bridge b:d=0xb:0, sc=0x107
 pciehp_resource_sort_and_combine: head = f78e36b4, *head = f5c6e840
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f78e36b0, *head = f5dd8780
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f78e36a8, *head = f5dd8760
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f78e36ac, *head = f5c6e880
 *head->next = 00000000
 :    BUS Resources:
         base= 0xc length= 0x1
 :    IO Resources:
         base= 0x5000 length= 0x1000
 :    MEM Resources:
         base= 0xd0400000 length= 0x100000
 :    PMEM Resources:
         base= 0xd0910000 length= 0x100000
 aCCF:existing PCI 0x7 Func ResourceDump
 bind_pci_resources_to_slots: vid = 3418086 bus b dev 0 fun 2
 pciehp_slot_find: bus b device 0 index 2
 pciehp_slot_find: func-> bus b device 0 function 0 pci_dev f7f05c00
 pciehp_slot_find: In while loop, func-> bus b device 0 function 2
pci_dev f7f05800
 pciehp_slot_find: while loop, found 1, index 2
 pciehp_slot_find: Found bus b dev 0 func 2
 bind_pci_resources_to_slots: func = f695f480
 Save_used_res of PCI bridge b:d=0xb:0, sc=0x107
 pciehp_resource_sort_and_combine: head = f78e36b4, *head = f47559a0
 *head->next = 00000000
 :    BUS Resources:
         base= 0xd length= 0x1
 aCCF:existing PCI 0x7 Func ResourceDump
 pciehprm_find_available_resources:post-Bind PCI 0x7 Ctrl Resource Dump
 :    BUS Resources:
         base= 0xe length= 0x0
 :    IO Resources:
         base= 0x6000 length= 0x0
 :    MEM Resources:
         base= 0xd0500000 length= 0x0
 :    PMEM Resources:
         base= 0xd0a10000 length= 0x0
 init_slots
 hpc_get_power_status: SLOT_CTRL 78 value read 7e8
 hpc_get_attention_status: SLOT_CTRL 78, value read 7e8
 Registering bus=b dev=0 hp_slot=0 sun=a slot_device_offset=0
 p_slot = f5afed80
 pciehp_probe: t_slot f5afed80
 pciehp_probe: adpater value 0
 pciehp_probe: Called by hp_drv
 pciehp_probe: DRV_thread pid = 5188
 pcie_init: pdev->vendor 1033 pdev->device 124
 pcie_init: pcie_cap_base 0
 pcie_init: CAP_REG offset 62 cap_reg 161
 pcie_init: SLOT_CAP offset 74 slot_cap 580540
 pcie_init: SLOT_STATUS offset 7a slot_status 100
 pcie_init: SLOT_CTRL offset 78 slot_ctrl 7c0
 pdev = f7f04400: b:d:f:irq=0x7:2:0:e9
 pci resource[7] start=0x6000(len=0x1000)
 pci resource[8] start=0xd0500000(len=0x100000)
 pci resource[9] start=0xd0a00000(len=0x100000)
 HPC vendor_id 1033 device_id 124 ss_vid 0 ss_did 0
 HPC interrupt = 233
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init : Mask HPIE hp_register_write_word SLOT_CTRL 7c0
 pcie_init: Mask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pcie_init: request_irq 233 for hpc1 (returns 0)
 pcie_init: SLOT_CTRL 78 value read 7c0
 pcie_init: slot_cap 580540
 pcie_init: temp_word 7e8
 pcie_init : Unmask HPIE hp_register_write_word SLOT_CTRL with 7e8
 pcie_init: Unmask HPIE SLOT_STATUS offset 7a reads slot_status 110
 pcie_init: SLOT_STATUS offset 7a writes slot_status 1f
 pciehp_probe: ctrl->pci_bus f695fa80
 pciehp_probe: ctrl bus=0x7, device=2, function=0, irq=e9
 pcie_get_ctlr_slot_config: PSN 11
 get_ctlr_slot_config: bus(0xe) num_slot(0x1) 1st_dev(0x0) psn(0xb)
ctrlcap(40) for b:d (7:2)
 pciehp_probe: Before calling pciehp_save_config, ctrl->bus 7,ctrl->slot_bus e
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 1, first_device_num = 0
 FirstSupported = 0, LastSupported = 0
 pciehp_save_config: pci_bus->number = e
 pciehp_save_config: bus = e, dev = 0
 pciehp_save_config: ID = 3408086
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = e
 pciehp_save_config: bus = f, dev = 0
 pciehp_save_config: ID = 23221077
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus f device 7 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus f dev 7 fun 0
 pciehp_slot_create: busnumber f
 pciehp_save_config: if, new_slot = f695f680 bus f dev 7 fun 0
 new_slot->pci_dev = f7f19400
 pciehp_save_config: In while loop
 class_code = c, header_type = 80
 pciehp_save_config: In do loop
 pciehp_slot_find: bus f device 7 index 0
 pciehp_slot_find: func-> bus f device 7 function 0 pci_dev f7f19400
 pciehp_save_config: new_slot = f695f680 bus f dev 7 fun 0
 pciehp_slot_find: bus f device 7 index 1
 pciehp_slot_find: func-> bus f device 7 function 0 pci_dev f7f19400
 pciehp_save_config: while loop, new_slot = 00000000 bus f dev 7 fun 1
 pciehp_slot_create: busnumber f
 pciehp_save_config: if, new_slot = f5d42780 bus f dev 7 fun 1
 new_slot->pci_dev = f7f19000
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: Exit
 pciehp_slot_find: bus e device 0 index 0
 pciehp_slot_find: func == NULL
 pciehp_save_config: new_slot = 00000000 bus e dev 0 fun 0
 pciehp_slot_create: busnumber e
 pciehp_save_config: if, new_slot = f5d42680 bus e dev 0 fun 0
 new_slot->pci_dev = f7f19c00
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 class_code = 6, header_type = 81
 pciehp_save_config: In do loop
 pciehp_save_config: Enter
 pciehp_save_config: num_ctlr_slots = 0, first_device_num = 0
 FirstSupported = 0, LastSupported = 31
 pciehp_save_config: pci_bus->number = e
 pciehp_save_config: bus = 10, dev = 0
 pciehp_save_config: Exit
 pciehp_slot_find: bus e device 0 index 0
 pciehp_slot_find: func-> bus e device 0 function 0 pci_dev f7f19c00
 pciehp_save_config: new_slot = f5d42680 bus e dev 0 fun 0
 pciehp_slot_find: bus e device 0 index 1
 pciehp_slot_find: func-> bus e device 0 function 0 pci_dev f7f19c00
 pciehp_save_config: while loop, new_slot = 00000000 bus e dev 0 fun 1
 pciehp_slot_create: busnumber e
 pciehp_save_config: if, new_slot = f3964e80 bus e dev 0 fun 2
 new_slot->pci_dev = f7f19800
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: In while loop
 Nothing there
 pciehp_save_config: Exit
 Save_used_res of PCI bridge b:d=0x7:2, sc=0x507
 pciehprm_find_available_resources: pciehp_save_used_resources rc = 0
 pciehp_resource_sort_and_combine: head = f78e37b4, *head = f3339a20
 *head->next = 00000000
 pciehprm_find_available_resources:pre-Bind PCI 0x7 Ctrl Resource Dump
 :    BUS Resources:
         base= 0xf length= 0x2
 :    IO Resources:
         base= 0x6000 length= 0x1000
 :    MEM Resources:
         base= 0xd0500000 length= 0x100000
 :    PMEM Resources:
         base= 0xd0a10000 length= 0x100000
 pciehprm_find_available_resources: before bind_pci_resources_to slots
 bind_pci_resources_to_slots: vid = 3408086 bus e dev 0 fun 0
 pciehp_slot_find: bus e device 0 index 0
 pciehp_slot_find: func-> bus e device 0 function 0 pci_dev f7f19c00
 bind_pci_resources_to_slots: func = f5d42680
 Save_used_res of PCI bridge b:d=0xe:0, sc=0x107
 pciehp_resource_sort_and_combine: head = f78e37b4, *head = f3339960
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f78e37b0, *head = f3339aa0
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f78e37a8, *head = f3339940
 *head->next = 00000000
 pciehp_resource_sort_and_combine: head = f78e37ac, *head = f3339b00
 *head->next = 00000000
 :    BUS Resources:
         base= 0xf length= 0x1
 :    IO Resources:
         base= 0x6000 length= 0x1000
 :    MEM Resources:
         base= 0xd0500000 length= 0x100000
 :    PMEM Resources:
         base= 0xd0a10000 length= 0x100000
 aCCF:existing PCI 0x7 Func ResourceDump
 bind_pci_resources_to_slots: vid = 3418086 bus e dev 0 fun 2
 pciehp_slot_find: bus e device 0 index 2
 pciehp_slot_find: func-> bus e device 0 function 0 pci_dev f7f19c00
 pciehp_slot_find: In while loop, func-> bus e device 0 function 2
pci_dev f7f19800
 pciehp_slot_find: while loop, found 1, index 2
 pciehp_slot_find: Found bus e dev 0 func 2
 bind_pci_resources_to_slots: func = f3964e80
 Save_used_res of PCI bridge b:d=0xe:0, sc=0x107
 pciehp_resource_sort_and_combine: head = f78e37b4, *head = f3339c60
 *head->next = 00000000
 :    BUS Resources:
         base= 0x10 length= 0x1
 aCCF:existing PCI 0x7 Func ResourceDump
 pciehprm_find_available_resources:post-Bind PCI 0x7 Ctrl Resource Dump
 :    BUS Resources:
         base= 0x11 length= 0x0
 :    IO Resources:
         base= 0x7000 length= 0x0
 :    MEM Resources:
         base= 0xd0600000 length= 0x0
 :    PMEM Resources:
         base= 0xd0b10000 length= 0x0
 init_slots
 hpc_get_power_status: SLOT_CTRL 78 value read 7e8
 hpc_get_attention_status: SLOT_CTRL 78, value read 7e8
 Registering bus=e dev=0 hp_slot=0 sun=b slot_device_offset=0
 p_slot = f5afe980
 pciehp_probe: t_slot f5afe980
 pciehp_probe: adpater value 0
 pcie_port_service_register = 0
 PCI Express Hot Plug Controller Driver version: 0.4
