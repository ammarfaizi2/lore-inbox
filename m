Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWCILAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWCILAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWCILAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:00:01 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:53767 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S1751812AbWCILAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:00:00 -0500
X-Obalka-From: mmokrejs@ribosome.natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Message-ID: <44100AB3.5060004@ribosome.natur.cuni.cz>
Date: Thu, 09 Mar 2006 12:00:03 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc5 huge memory detection regression
References: <440D6581.9080000@ribosome.natur.cuni.cz>	 <20060307041532.3ef45392.akpm@osdl.org>	 <440D7BB8.40106@ribosome.natur.cuni.cz>	 <20060307113631.36ac029d.akpm@osdl.org>	 <1141765722.9274.105.camel@localhost.localdomain>	 <440E172D.7000406@ribosome.natur.cuni.cz> <1141774459.9274.142.camel@localhost.localdomain>
In-Reply-To: <1141774459.9274.142.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------020406020700060109010901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406020700060109010901
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Dave Hansen wrote:
> On Wed, 2006-03-08 at 00:28 +0100, Martin MOKREJ© wrote:
> 
>>Ehm, I don't know why the kernel now sees 16GB. I rebooted again 
>>with the vanilla 2.6.16-rc5 patched with only your e820 patch ... 
>>how could print calls fix the problem? I am working completely 
>>remotely. :((
> 
> 
> The suggestion to jiggle the DIMMs seems appropriate again. :)

So when the machine claims to have only 12GB of RAM, I see with lshw(1):

         *-bank:6
              description: DIMM DDR Synchronous 266 MHz (3.8 ns) [empty]
              product: CM75SD2048RLP-3200
              vendor:
              physical id: 6
              serial: 00000000
              slot: DIMM 7
              clock: 266MHz (3.7594ns)
         *-bank:7
              description: DIMM DDR Synchronous 266 MHz (3.8 ns) [empty]
              product: CM75SD2048RLP-3200
              vendor:
              physical id: 7
              serial: 00000000
              slot: DIMM 8
              clock: 266MHz (3.7594ns)



I am only curious why the product: field is not empty but rather 
shows type of the actual module. All eight DIMMS are same Corsair 
2GB RAM modules (sorry, I think I wrote Kingston previously but is 
not true). Moreover, the modules are at 266MHz and not on 333MHz, 
the board would take only 6 modules at 333MHz. So lshw should report 
-2700 instead of -3200. Inspecting their serial numbers in the 
invoice I see:

340540434
340540435
330541284
330541283
330541282
330541281
330541280
330541279

Yes, 2 are different. I guess your question would be whether those 2 
unseen DIMMS are the first two serial numbers ... I can't say now 
but definitely when only 8 GB of RAM are detected the problem would 
include additional two DIMMs.

So, what would you recommend now. To flash from BIOS 1.20 to 1.50 
and pray? ;-)

Martin

--------------020406020700060109010901
Content-Type: text/plain;
 name="lshw-12GB.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="lshw-12GB.txt"

phylo
    description: Tower Computer
    product: MS-9136
    vendor: MSI
    version: Revision 0C
    serial: 0123456789
    width: 32 bits
    capabilities: smbios-2.3 dmi-2.3
    configuration: administrator_password=enabled boot=normal chassis=tower frontpanel_password=disabled keyboard_password=disabled power-on_password=disabled
  *-core
       description: Motherboard
       product: MS-9136
       vendor: MSI
       physical id: 0
       version: Revision 0C
       serial: 9876543210
       slot: L1 Cache for CPU#2
     *-firmware
          description: BIOS
          vendor: Phoenix Technologies,Ltd
          physical id: 0
          version: 6.0.1.20 (11/03/2004)
          size: 118KB
          capacity: 960KB
          capabilities: pci pnp upgrade shadowing escd cdboot bootselect edd int13floppynec int13floppytoshiba int13floppy720 int13floppy2880 int14serial int17printer int10video acpi usb ls120boot zipboot biosbootspecification netboot
     *-cpu:0
          description: CPU
          product: Intel(R) Xeon(TM) CPU 3.00GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: 15.4.1
          serial: 0000-0F41-0000-0000-0000-0000
          slot: CPU#1
          size: 3GHz
          capacity: 3600MHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx x86-64 constant_tsc pni monitor ds_cpl cid cx16 xtpr cpufreq
          configuration: id=0
        *-cache:0
             description: L1 cache
             physical id: 6
             slot: L1 Cache for CPU#1
             size: 16KB
             capacity: 16KB
             capabilities: burst pipeline-burst internal write-back data
        *-cache:1
             description: L2 cache
             physical id: 7
             slot: L2 Cache for CPU#1
             size: 1MB
             capacity: 1MB
             capabilities: burst internal write-back unified
        *-logicalcpu:0
             description: Logical CPU
             physical id: 0.1
             width: 64 bits
             capabilities: logical
        *-logicalcpu:1
             description: Logical CPU
             physical id: 0.2
             width: 64 bits
             capabilities: logical
     *-cpu:1
          description: CPU
          product: Intel(R) Xeon(TM) CPU 3.00GHz
          vendor: Intel Corp.
          physical id: 5
          bus info: cpu@1
          version: 15.4.1
          serial: 0000-0F41-0000-0000-0000-0000
          slot: CPU#2
          size: 3GHz
          capacity: 3600MHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx x86-64 constant_tsc pni monitor ds_cpl cid cx16 xtpr cpufreq
          configuration: id=6
        *-cache:0
             description: L1 cache
             physical id: 9
             slot: L1 Cache for CPU#2
             size: 16KB
             capacity: 16KB
             capabilities: burst pipeline-burst internal write-back data
        *-cache:1
             description: L2 cache
             physical id: a
             slot: L2 Cache for CPU#2
             size: 1MB
             capacity: 1MB
             capabilities: burst internal write-back unified
        *-logicalcpu:0
             description: Logical CPU
             physical id: 6.1
             width: 64 bits
             capabilities: logical
        *-logicalcpu:1
             description: Logical CPU
             physical id: 6.2
             width: 64 bits
             capabilities: logical
     *-memory
          description: System Memory
          physical id: 28
          slot: System board or motherboard
          size: 12GB
        *-bank:0
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             product: CM74SD2048RLP-2100
             vendor: 
             physical id: 0
             serial: 00000000
             slot: DIMM 1
             size: 2GB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:1
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             product: CM74SD2048RLP-2100
             vendor: 
             physical id: 1
             serial: 00000000
             slot: DIMM 2
             size: 2GB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:2
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             product: CM75SD2048RLP-3200
             vendor: 
             physical id: 2
             serial: 00000000
             slot: DIMM 3
             size: 2GB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:3
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             product: CM75SD2048RLP-3200
             vendor: 
             physical id: 3
             serial: 00000000
             slot: DIMM 4
             size: 2GB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:4
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             product: CM75SD2048RLP-3200
             vendor: 
             physical id: 4
             serial: 00000000
             slot: DIMM 5
             size: 2GB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:5
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             product: CM75SD2048RLP-3200
             vendor: 
             physical id: 5
             serial: 00000000
             slot: DIMM 6
             size: 2GB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:6
             description: DIMM DDR Synchronous 266 MHz (3.8 ns) [empty]
             product: CM75SD2048RLP-3200
             vendor: 
             physical id: 6
             serial: 00000000
             slot: DIMM 7
             clock: 266MHz (3.7594ns)
        *-bank:7
             description: DIMM DDR Synchronous 266 MHz (3.8 ns) [empty]
             product: CM75SD2048RLP-3200
             vendor: 
             physical id: 7
             serial: 00000000
             slot: DIMM 8
             clock: 266MHz (3.7594ns)
     *-pci
          description: Host bridge
          product: E7520 Memory Controller Hub
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@00:00.0
          version: 0c
          width: 32 bits
          clock: 33MHz
        *-generic UNCLAIMED
             product: E7525/E7520 Error Reporting Registers
             vendor: Intel Corporation
             physical id: 0.1
             bus info: pci@00:00.1
             version: 0c
             width: 32 bits
             clock: 33MHz
        *-system:0 UNCLAIMED
             description: System peripheral
             product: E7520 DMA Controller
             vendor: Intel Corporation
             physical id: 1
             bus info: pci@00:01.0
             version: 0c
             width: 32 bits
             clock: 33MHz
             capabilities: cap_list
             resources: iomemory:d0000000-d0000fff irq:10
        *-pci:0
             description: PCI bridge
             product: E7525/E7520/E7320 PCI Express Port A
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@00:02.0
             version: 0c
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
           *-pci:0
                description: PCI bridge
                product: 6700PXH PCI Express-to-PCI Bridge A
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@01:00.0
                version: 09
                width: 32 bits
                clock: 33MHz
                capabilities: pci normal_decode bus_master cap_list
           *-pci:1
                description: PCI bridge
                product: 6700PXH PCI Express-to-PCI Bridge B
                vendor: Intel Corporation
                physical id: 0.2
                bus info: pci@01:00.2
                version: 09
                width: 32 bits
                clock: 33MHz
                capabilities: pci normal_decode bus_master cap_list
        *-pci:1
             description: PCI bridge
             product: E7525/E7520 PCI Express Port B
             vendor: Intel Corporation
             physical id: 4
             bus info: pci@00:04.0
             version: 0c
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
        *-pci:2
             description: PCI bridge
             product: E7520 PCI Express Port B1
             vendor: Intel Corporation
             physical id: 5
             bus info: pci@00:05.0
             version: 0c
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
        *-pci:3
             description: PCI bridge
             product: E7520 PCI Express Port C
             vendor: Intel Corporation
             physical id: 6
             bus info: pci@00:06.0
             version: 0c
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
        *-pci:4
             description: PCI bridge
             product: E7520 PCI Express Port C1
             vendor: Intel Corporation
             physical id: 7
             bus info: pci@00:07.0
             version: 0c
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master cap_list
        *-pci:5
             description: PCI bridge
             product: 6300ESB 64-bit PCI-X Bridge
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@00:1c.0
             version: 02
             width: 32 bits
             clock: 66MHz
             capabilities: pci normal_decode bus_master cap_list
           *-display
                description: VGA compatible controller
                product: Radeon RV100 QY [Radeon 7000/VE]
                vendor: ATI Technologies Inc
                physical id: 1
                bus info: pci@08:01.0
                version: 00
                size: 128MB
                width: 32 bits
                clock: 66MHz
                capabilities: vga cap_list
                resources: iomemory:d8000000-dfffffff ioport:2000-20ff iomemory:d0100000-d010ffff irq:17
           *-network:0
                description: Ethernet interface
                product: 82541GI/PI Gigabit Ethernet Controller
                vendor: Intel Corporation
                physical id: 2
                bus info: pci@08:02.0
                logical name: eth0
                version: 00
                serial: 00:11:09:b6:c1:7a
                size: 1GB/s
                capacity: 1GB/s
                width: 32 bits
                clock: 66MHz
                capabilities: bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegociation
                configuration: autonegociation=on broadcast=yes driver=e1000 driverversion=6.3.9-k4 duplex=full firmware=N/A ip=195.113.57.18 link=yes multicast=yes port=twisted pair speed=1GB/s
                resources: iomemory:d0140000-d015ffff iomemory:d0120000-d013ffff ioport:2400-243f irq:18
           *-network:1
                description: Ethernet interface
                product: 82541GI/PI Gigabit Ethernet Controller
                vendor: Intel Corporation
                physical id: 3
                bus info: pci@08:03.0
                logical name: eth1
                version: 00
                serial: 00:11:09:b6:c1:7b
                capacity: 1GB/s
                width: 32 bits
                clock: 66MHz
                capabilities: bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegociation
                configuration: autonegociation=on broadcast=yes driver=e1000 driverversion=6.3.9-k4 firmware=N/A ip=192.168.1.254 link=no multicast=yes port=twisted pair
                resources: iomemory:d0180000-d019ffff iomemory:d0160000-d017ffff ioport:2440-247f irq:19
        *-usb:0
             description: USB Controller
             product: 6300ESB USB Universal Host Controller
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@00:1d.0
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd
             resources: ioport:1400-141f irq:16
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.16-rc5-git12 uhci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:1
             description: USB Controller
             product: 6300ESB USB Universal Host Controller
             vendor: Intel Corporation
             physical id: 1d.1
             bus info: pci@00:1d.1
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd
             resources: ioport:1420-143f irq:22
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.16-rc5-git12 uhci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-system:1 UNCLAIMED
             description: System peripheral
             product: 6300ESB Watchdog Timer
             vendor: Intel Corporation
             physical id: 1d.4
             bus info: pci@00:1d.4
             version: 02
             width: 32 bits
             clock: 33MHz
             resources: iomemory:d0001000-d000100f
        *-system:2 UNCLAIMED
             description: PIC
             product: 6300ESB I/O Advanced Programmable Interrupt Controller
             vendor: Intel Corporation
             physical id: 1d.5
             bus info: pci@00:1d.5
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: io_x_-apic bus_master cap_list
        *-usb:2
             description: USB Controller
             product: 6300ESB USB2 Enhanced Host Controller
             vendor: Intel Corporation
             physical id: 1d.7
             bus info: pci@00:1d.7
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: ehci bus_master cap_list
             configuration: driver=ehci_hcd
             resources: iomemory:d0001400-d00017ff irq:23
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 2.6.16-rc5-git12 ehci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 2.06
                capabilities: usb-2.00
                configuration: driver=hub maxpower=0mA slots=4 speed=480.0MB/s
        *-pci:6
             description: PCI bridge
             product: 82801 PCI Bridge
             vendor: Intel Corporation
             physical id: 1e
             bus info: pci@00:1e.0
             version: 0a
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master
           *-network
                description: Ethernet interface
                product: 82541PI Gigabit Ethernet Controller
                vendor: Intel Corporation
                physical id: 1
                bus info: pci@09:01.0
                logical name: eth2
                version: 05
                serial: 00:0e:0c:84:83:71
                capacity: 1GB/s
                width: 32 bits
                clock: 66MHz
                capabilities: bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegociation
                configuration: autonegociation=on broadcast=yes driver=e1000 driverversion=6.3.9-k4 firmware=N/A ip=192.168.2.254 link=no multicast=yes port=twisted pair
                resources: iomemory:d0220000-d023ffff iomemory:d0200000-d021ffff ioport:3000-303f irq:20
        *-isa UNCLAIMED
             description: ISA bridge
             product: 6300ESB LPC Interface Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@00:1f.0
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master
        *-ide:0
             description: IDE interface
             product: 6300ESB PATA Storage Controller
             vendor: Intel Corporation
             physical id: 1f.1
             bus info: pci@00:1f.1
             version: 02
             width: 32 bits
             clock: 33MHz
             capabilities: ide bus_master
             configuration: driver=PIIX_IDE
             resources: ioport:1460-146f iomemory:d1100000-d11003ff irq:21
           *-ide
                description: IDE Channel 0
                physical id: 0
                bus info: ide@0
                logical name: ide0
                clock: 33MHz
              *-cdrom
                   description: DVD reader
                   product: SONY DVD-ROM DDU1615
                   physical id: 0
                   bus info: ide@0.0
                   logical name: /dev/hda
                   version: FYS2
                   capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio dvd
                   configuration: mode=udma2
                 *-disc
                      physical id: 0
                      logical name: /dev/hda
        *-ide:1
             description: IDE interface
             product: 6300ESB SATA Storage Controller
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@00:1f.2
             logical name: scsi0
             logical name: scsi1
             version: 02
             width: 32 bits
             clock: 66MHz
             capabilities: ide bus_master emulated
             configuration: driver=ata_piix
             resources: ioport:14a8-14af ioport:149c-149f ioport:14a0-14a7 ioport:1498-149b ioport:1470-147f irq:21
           *-disk:0
                description: SCSI Disk
                product: ST3200826AS
                vendor: ATA
                physical id: 0
                bus info: scsi@0:0.0.0
                logical name: /dev/sda
                version: 3.03
                serial: 3ND1H3NW
                size: 186GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5
              *-volume:0
                   description: Linux filesystem partition
                   physical id: 1
                   bus info: scsi@0:0.0.0,1
                   logical name: /dev/sda1
                   capacity: 86MB
                   capabilities: primary bootable
              *-volume:1
                   description: Linux swap / Solaris partition
                   physical id: 2
                   bus info: scsi@0:0.0.0,2
                   logical name: /dev/sda2
                   capacity: 29GB
                   capabilities: primary nofs
              *-volume:2
                   description: Linux filesystem partition
                   physical id: 3
                   bus info: scsi@0:0.0.0,3
                   logical name: /dev/sda3
                   capacity: 37GB
                   capabilities: primary
              *-volume:3 UNCLAIMED
                   description: Linux filesystem partition
                   physical id: 4
                   bus info: scsi@0:0.0.0,4
                   capacity: 119GB
                   capabilities: primary
           *-disk:1
                description: SCSI Disk
                product: ST3200826AS
                vendor: ATA
                physical id: 1
                bus info: scsi@1:0.0.0
                logical name: /dev/sdb
                version: 3.03
                serial: 3ND13NH3
                size: 186GB
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5
              *-volume
                   description: Linux filesystem partition
                   physical id: 1
                   bus info: scsi@1:0.0.0,1
                   logical name: /dev/sdb1
                   capacity: 186GB
                   capabilities: primary
        *-serial
             description: SMBus
             product: 6300ESB SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@00:1f.3
             version: 02
             width: 32 bits
             clock: 33MHz
             configuration: driver=i801_smbus
             resources: ioport:1440-145f irq:10

--------------020406020700060109010901--
