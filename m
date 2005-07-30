Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVG3Pde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVG3Pde (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVG3Pdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:33:31 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:30905 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262984AbVG3Pd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:33:26 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Khalid Aziz <khalid.aziz@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Khalid Aziz <khalid_aziz@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>, linux-acpi@intel.com
In-Reply-To: <20050729161751.34705ac6.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122678354.20867.48.camel@lyra.fc.hp.com>
	 <20050729161751.34705ac6.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-dgYOYDJtLJmrmmZ0nYKM"
Date: Sat, 30 Jul 2005 09:33:15 -0600
Message-Id: <1122737595.3133.7.camel@minuet.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dgYOYDJtLJmrmmZ0nYKM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-07-29 at 16:17 -0700, Andrew Morton wrote:
> Khalid Aziz <khalid_aziz@hp.com> wrote:
> >
> > Serial console is broken on ia64 on an HP rx2600 machine on
> > 2.6.13-rc3-mm3. When kernel is booted up with "console=ttyS,...", no
> > output ever appears on the console and system is hung. So I booted the
> > kernel with "console=uart,mmio,0xff5e0000" to enable early console and
> > here is how far the kernel got before hanging:
> 
> (cc the ia64 and acpi lists)
> 
> OK, thanks.  There have been a few serial driver changes recently, but
> there's also a tremendous ACPI patch in -mm.  I'm wondering about those
> ACPI error messages:
> 
> > -------
> > Linux version 2.6.13-rc3-mm3 (root@mars) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #4 SMP Fri Jul 29 16:30:41 MDT 2005
> > EFI v1.10 by HP: SALsystab=0x3fb38000 ACPI 2.0=0x3fb2e000 SMBIOS=0x3fb3a000 HCDP=0x3fb2c000
> > booting generic kernel on platform hpzx1
> > PCDP: v0 at 0x3fb2c000
> > Explicit "console="; ignoring PCDP
> ..............
> > NET: Registered protocol family 16
> > ACPI: bus type pci registered
> > ACPI: Subsystem revision 20050708
> >     ACPI-0509: *** Error: Method execution failed [\PARS.GFIT] (Node e0000002ffff8a00), AE_BAD_PARAMETER
> >     ACPI-0509: *** Error: Method execution failed [\_SB_.SBA0._INI] (Node e0000002ffffa780), AE_BAD_PARAMETER
> > ACPI: Interpreter enabled
> > ACPI: Using IOSAPIC for interrupt routing
> 
> Does the above happen on 2.6.13-rc3 or 2.6.13-rc4?

No, I do not see this on 2.6.13-rc3. It does seem ACPI is busted on
2.6.13-rc3-mm3 which is leading to kernel not being able to scan PCI bus
and set up IRQ routing.


> Well it did claim to find an 8250 controller.
> 
> If you have time, it would be useful if you could obtain the 2.6.13-rc3 dmesg
> output and do
> 	diff -u dmesg-2.6.13-rc3 dmesg-2.6.13-rc3-mm3
> 
> and send it, thanks.

Here is the diff:

1c1
< Linux version 2.6.13-rc3 (root@mars) (gcc version 3.3.5 (Debian
1:3.3.5-12)) #
3 SMP Fri Jul 29 16:07:24 MDT 2005
---
> Linux version 2.6.13-rc3-mm3 (root@mars) (gcc version 3.3.5 (Debian
1:3.3.5-12
)) #4 SMP Fri Jul 29 16:30:41 MDT 2005
5a6
> Early serial console at MMIO 0xff5e0000 (options '115200')
19c20
< Kernel command line:
BOOT_IMAGE=scsi1:/EFI/debian/boot/vmlinuz-2.6.13-rc3 root
=/dev/sdb2 console=ttyS0,115200n8  ro
---
> Kernel command line:
BOOT_IMAGE=scsi1:/EFI/debian/boot/vmlinuz-2.6.13-rc3-mm3 
root=/dev/sdb2 console=uart,mmio,0xff5e0000  ro
22c23
< Memory: 12438928k/12541920k available (6951k code, 116448k reserved,
3697k dat
a, 288k init)
---
> Memory: 12439136k/12542128k available (7051k code, 116240k reserved,
3406k dat
a, 352k init)
28c29
< CPU 1: synchronized ITC with CPU 0 (last diff 0 cycles, maxerr 433
cycles)
---
> CPU 1: synchronized ITC with CPU 0 (last diff -5 cycles, maxerr 433
cycles)
30a32,60
> -> [0][1][ 786432]   0.5 [  0.5] (0): (  500513   250256)
> -> [0][1][ 827823]   0.5 [  0.5] (0): (  529015   139379)
> -> [0][1][ 871392]   0.5 [  0.5] (0): (  557119    83741)
> -> [0][1][ 917254]   0.5 [  0.5] (0): (  585481    56051)
> -> [0][1][ 965530]   0.6 [  0.6] (0): (  615654    43112)
> -> [0][1][1016347]   0.6 [  0.6] (0): (  653296    40377)
> -> [0][1][1069838]   0.6 [  0.6] (0): (  681359    34220)
> -> [0][1][1126145]   0.7 [  0.7] (0): (  706209    29535)
> -> [0][1][1185415]   0.7 [  0.7] (0): (  754788    39057)
> -> [0][1][1247805]   0.7 [  0.7] (0): (  788675    36472)
> -> [0][1][1313478]   0.8 [  0.8] (0): (  840102    43949)
> -> [0][1][1382608]   0.7 [  0.8] (0): (  742042    71004)
> -> [0][1][1455376]   0.6 [  0.8] (0): (  653934    79556)
> -> [0][1][1531974]   0.7 [  0.8] (0): (  766991    96306)
> -> [0][1][1612604]   0.7 [  0.8] (0): (  779253    54284)
> -> [0][1][1697477]   0.5 [  0.8] (0): (  534912   149312)
> -> [0][1][1786817]   0.5 [  0.8] (0): (  503106    90559)
> -> found max.
> [0][1] working set size found: 1313478, cost: 840102
> ---------------------
> | migration cost matrix (max_cache_size: 1572864, cpu: -1 MHz):
> ---------------------
>           [00]    [01]
> [00]:     -     1.6(0)
> [01]:   1.6(0)    -   
> --------------------------------
> | cacheflush times [1]: 1.6 (1680204)
> | calibration delay: 1 seconds
> --------------------------------
33c63,65
< ACPI: Subsystem revision 20050408
---
> ACPI: Subsystem revision 20050708
>     ACPI-0509: *** Error: Method execution failed [\PARS.GFIT] (Node
e0000002f
fff8a00), AE_BAD_PARAMETER
>     ACPI-0509: *** Error: Method execution failed [\_SB_.SBA0._INI]
(Node e000
0002ffffa780), AE_BAD_PARAMETER
36,91d67
< ACPI: PCI Root Bridge [PCI0] (0000:00)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
< ACPI: PCI Root Bridge [PCI1] (0000:20)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
< ACPI: PCI Root Bridge [PCI2] (0000:40)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
< ACPI: PCI Root Bridge [PCI3] (0000:60)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
< ACPI: PCI Root Bridge [PCI4] (0000:80)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
< ACPI: PCI Root Bridge [PCI6] (0000:c0)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
< ACPI: PCI Root Bridge [PCI7] (0000:e0)
< ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
 ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
< ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
93d68
< IOC: zx1 2.2 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
100d74
< inotify syscall
106,116c80
< GSI 34 (edge, high) -> CPU 0 (0x0000) vector 49
< ttyS0 at MMIO 0xff5e0000 (irq = 49) is a 16550A
< GSI 35 (edge, high) -> CPU 1 (0x0100) vector 50
< ttyS1 at MMIO 0xff5e2000 (irq = 50) is a 16550A
< GSI 82 (level, low) -> CPU 0 (0x0000) vector 51
< ACPI: PCI Interrupt 0000:e0:01.0[A] -> GSI 82 (level, low) -> IRQ 51
< ttyS2 at MMIO 0xf8031000 (irq = 51) is a 16450
< ACPI: PCI Interrupt 0000:e0:01.1[A] -> GSI 82 (level, low) -> IRQ 51
< ttyS3 at MMIO 0xf8030000 (irq = 51) is a 16550A
< ttyS4 at MMIO 0xf8030010 (irq = 51) is a 16550A
< ttyS5 at MMIO 0xf8030038 (irq = 51) is a 16550A
---
> mice: PS/2 mouse device common for all mice
124c88
< e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
---
> e100: Intel(R) PRO/100 Network Driver, 3.4.10-k2-NAPI
126,134d89
< GSI 20 (level, low) -> CPU 1 (0x0100) vector 52
< ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 52
< e100: eth0: e100_probe: addr 0x80020000, irq 52, MAC addr
00:30:6E:39:C6:60
< tg3.c:v3.33 (July 5, 2005)
< GSI 29 (level, low) -> CPU 0 (0x0000) vector 53
< ACPI: PCI Interrupt 0000:20:02.0[A] -> GSI 29 (level, low) -> IRQ 53
< eth1: Tigon3 [partno(BCM95700A6) rev 0105 PHY(5701)]
(PCI:66MHz:64-bit) 10/100
/1000BaseT Ethernet 00:30:6e:39:16:c0
< eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[0]
 
< eth1: dma_rwctrl[76ff2d0f]
137,148c92
< ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
< CMD649: IDE controller at PCI slot 0000:00:02.0
< GSI 21 (level, low) -> CPU 1 (0x0100) vector 54
< ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 21 (level, low) -> IRQ 54
< CMD649: chipset revision 2
< CMD649: 100% native mode on irq 54
<     ide0: BM-DMA at 0x0d40-0x0d47, BIOS settings: hda:pio, hdb:pio
<     ide1: BM-DMA at 0x0d48-0x0d4f, BIOS settings: hdc:pio, hdd:pio
< hda: DW-28E, ATAPI CD/DVD-ROM drive
< ide0 at 0xd58-0xd5f,0xd66 on irq 54
< hda: ATAPI 24X DVD-ROM CD-R/RW drive, 1698kB Cache, UDMA(33)
< Uniform CD-ROM driver Revision: 3.20
---
> ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
150,167d93
< GSI 38 (level, low) -> CPU 0 (0x0000) vector 55
< ACPI: PCI Interrupt 0000:40:01.0[A] -> GSI 38 (level, low) -> IRQ 55
< sym0: <1010-66> rev 0x1 at pci 0000:40:01.0 irq 55
< sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
< sym0: open drain IRQ line driver, using on-chip SRAM
< sym0: using LOAD/STORE-based firmware.
< sym0: handling phase mismatch from SCRIPTS.
< sym0: SCSI BUS has been reset.
< scsi0 : sym-2.2.1
< GSI 39 (level, low) -> CPU 1 (0x0100) vector 56
< ACPI: PCI Interrupt 0000:40:01.1[B] -> GSI 39 (level, low) -> IRQ 56
< sym1: <1010-66> rev 0x1 at pci 0000:40:01.1 irq 56
< sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
< sym1: open drain IRQ line driver, using on-chip SRAM
< sym1: using LOAD/STORE-based firmware.
< sym1: handling phase mismatch from SCRIPTS.
< sym1: SCSI BUS has been reset.
< scsi1 : sym-2.2.1
171,205d96
< GSI 27 (level, low) -> CPU 0 (0x0000) vector 57
< ACPI: PCI Interrupt 0000:20:01.0[A] -> GSI 27 (level, low) -> IRQ 57
< mptbase: Initiating ioc0 bringup
< ioc0: 53C1030: Capabilities={Initiator,Target}
< scsi2 : ioc0: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=57
<   Vendor: HP 36.4G  Model: ST336706LC        Rev: HP05
<   Type:   Direct-Access                      ANSI SCSI revision: 02
< SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
< SCSI device sda: drive cache: write through
< SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
< SCSI device sda: drive cache: write through
<  sda: sda1 sda2 sda3
< Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
<   Vendor: HP 36.4G  Model: ST336706LC        Rev: HP05
<   Type:   Direct-Access                      ANSI SCSI revision: 02
< SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
< SCSI device sdb: drive cache: write through
< SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
< SCSI device sdb: drive cache: write through
<  sdb: sdb1 sdb2 sdb3 sdb4
< Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
< GSI 28 (level, low) -> CPU 1 (0x0100) vector 58
< ACPI: PCI Interrupt 0000:20:01.1[B] -> GSI 28 (level, low) -> IRQ 58
< mptbase: Initiating ioc1 bringup
< mptscsih: ioc0: DV: Release failed. id 0<6>ioc1: 53C1030:
Capabilities={Initia
tor,Target}
< scsi3 : ioc1: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=58
<   Vendor: HP 36.4G  Model: ST336706LC        Rev: HP04
<   Type:   Direct-Access                      ANSI SCSI revision: 02
< SCSI device sdc: 71132960 512-byte hdwr sectors (36420 MB)
< SCSI device sdc: drive cache: write through
< SCSI device sdc: 71132960 512-byte hdwr sectors (36420 MB)
< SCSI device sdc: drive cache: write through
<  sdc: sdc1 sdc2 sdc3
< Attached scsi disk sdc at scsi3, channel 0, id 2, lun 0
< mice: PS/2 mouse device common for all mice
216,220c107
< kjournald starting.  Commit interval 5 seconds
< EXT3-fs: mounted filesystem with ordered data mode.
< VFS: Mounted root (ext3 filesystem) readonly.
< Freeing unused kernel memory: 288kB freed
< INIT: version 2.86 booting
---
> No ttyS device at MMIO 0xff5e0000 for console

I have also attached the bootup logs for 2.6.13-rc3 and 2.6.13-rc3-mm3.

--
Khalid

--=-dgYOYDJtLJmrmmZ0nYKM
Content-Disposition: attachment; filename=rc3_bootup.log
Content-Type: text/x-log; name=rc3_bootup.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.13-rc3 (root@mars) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #3 SMP Fri Jul 29 16:07:24 MDT 2005
EFI v1.10 by HP: SALsystab=0x3fb38000 ACPI 2.0=0x3fb2e000 SMBIOS=0x3fb3a000 HCDP=0x3fb2c000
booting generic kernel on platform hpzx1
PCDP: v0 at 0x3fb2c000
Explicit "console="; ignoring PCDP
efi.trim_top: ignoring 4KB of memory at 0x0 due to granule hole at 0x0
efi.trim_top: ignoring 636KB of memory at 0x1000 due to granule hole at 0x0
efi.trim_bottom: ignoring 15360KB of memory at 0x100000 due to granule hole at 0x0
SAL 3.1: HP version 2.31
SAL Platform features: None
SAL: AP wakeup using external interrupt vector 0xff
No logical to physical processor mapping available
ACPI: Local APIC address c0000000fee00000
GSI 36 (level, low) -> CPU 0 (0x0000) vector 48
2 CPUs available, 2 CPUs total
MCA related initialization done
Virtual mem_map starts at 0xa0007fffc7200000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi1:/EFI/debian/boot/vmlinuz-2.6.13-rc3 root=/dev/sdb2 console=ttyS0,115200n8  ro
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour VGA+ 80x25
Memory: 12438928k/12541920k available (6951k code, 116448k reserved, 3697k data, 288k init)
Leaving McKinley Errata 9 workaround enabled
Dentry cache hash table entries: 2097152 (order: 10, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0x0
CPU 1: synchronized ITC with CPU 0 (last diff 0 cycles, maxerr 433 cycles)
Brought up 2 CPUs
Total of 2 processors activated (2695.16 BogoMIPS).
NET: Registered protocol family 16
ACPI: bus type pci registered
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
ACPI: PCI Root Bridge [PCI1] (0000:20)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
ACPI: PCI Root Bridge [PCI2] (0000:40)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
ACPI: PCI Root Bridge [PCI3] (0000:60)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
ACPI: PCI Root Bridge [PCI4] (0000:80)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
ACPI: PCI Root Bridge [PCI6] (0000:c0)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
ACPI: PCI Root Bridge [PCI7] (0000:e0)
ACPI: Assume root bridge [\_SB_.SBA0.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI1] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI2] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI3] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI4] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI6] segment is 0
ACPI: Assume root bridge [\_SB_.SBA0.PCI7] segment is 0
SCSI subsystem initialized
IOC: zx1 2.2 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
inotify syscall
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
EFI Time Services Driver v0.4
i8042.c: No controller found.
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
GSI 34 (edge, high) -> CPU 0 (0x0000) vector 49
ttyS0 at MMIO 0xff5e0000 (irq = 49) is a 16550A
GSI 35 (edge, high) -> CPU 1 (0x0100) vector 50
ttyS1 at MMIO 0xff5e2000 (irq = 50) is a 16550A
GSI 82 (level, low) -> CPU 0 (0x0000) vector 51
ACPI: PCI Interrupt 0000:e0:01.0[A] -> GSI 82 (level, low) -> IRQ 51
ttyS2 at MMIO 0xf8031000 (irq = 51) is a 16450
ACPI: PCI Interrupt 0000:e0:01.1[A] -> GSI 82 (level, low) -> IRQ 51
ttyS3 at MMIO 0xf8030000 (irq = 51) is a 16550A
ttyS4 at MMIO 0xf8030010 (irq = 51) is a 16550A
ttyS5 at MMIO 0xf8030038 (irq = 51) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
GSI 20 (level, low) -> CPU 1 (0x0100) vector 52
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 52
e100: eth0: e100_probe: addr 0x80020000, irq 52, MAC addr 00:30:6E:39:C6:60
tg3.c:v3.33 (July 5, 2005)
GSI 29 (level, low) -> CPU 0 (0x0000) vector 53
ACPI: PCI Interrupt 0000:20:02.0[A] -> GSI 29 (level, low) -> IRQ 53
eth1: Tigon3 [partno(BCM95700A6) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:30:6e:39:16:c0
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
eth1: dma_rwctrl[76ff2d0f]
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD649: IDE controller at PCI slot 0000:00:02.0
GSI 21 (level, low) -> CPU 1 (0x0100) vector 54
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 21 (level, low) -> IRQ 54
CMD649: chipset revision 2
CMD649: 100% native mode on irq 54
    ide0: BM-DMA at 0x0d40-0x0d47, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x0d48-0x0d4f, BIOS settings: hdc:pio, hdd:pio
hda: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0xd58-0xd5f,0xd66 on irq 54
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 1698kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
GSI 38 (level, low) -> CPU 0 (0x0000) vector 55
ACPI: PCI Interrupt 0000:40:01.0[A] -> GSI 38 (level, low) -> IRQ 55
sym0: <1010-66> rev 0x1 at pci 0000:40:01.0 irq 55
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
GSI 39 (level, low) -> CPU 1 (0x0100) vector 56
ACPI: PCI Interrupt 0000:40:01.1[B] -> GSI 39 (level, low) -> IRQ 56
sym1: <1010-66> rev 0x1 at pci 0000:40:01.1 irq 56
sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.1
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.02
GSI 27 (level, low) -> CPU 0 (0x0000) vector 57
ACPI: PCI Interrupt 0000:20:01.0[A] -> GSI 27 (level, low) -> IRQ 57
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator,Target}
scsi2 : ioc0: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=57
  Vendor: HP 36.4G  Model: ST336706LC        Rev: HP05
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
  Vendor: HP 36.4G  Model: ST336706LC        Rev: HP05
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
GSI 28 (level, low) -> CPU 1 (0x0100) vector 58
ACPI: PCI Interrupt 0000:20:01.1[B] -> GSI 28 (level, low) -> IRQ 58
mptbase: Initiating ioc1 bringup
mptscsih: ioc0: DV: Release failed. id 0<6>ioc1: 53C1030: Capabilities={Initiator,Target}
scsi3 : ioc1: LSI53C1030, FwRev=01032300h, Ports=1, MaxQ=255, IRQ=58
  Vendor: HP 36.4G  Model: ST336706LC        Rev: HP04
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdc: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdc: drive cache: write through
SCSI device sdc: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi3, channel 0, id 2, lun 0
mice: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP route cache hash table entries: 2097152 (order: 10, 16777216 bytes)
TCP established hash table entries: 8388608 (order: 13, 134217728 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 8388608 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 288kB freed
INIT: version 2.86 booting

--=-dgYOYDJtLJmrmmZ0nYKM
Content-Disposition: attachment; filename=rc3-mm3_bootup.log
Content-Type: text/x-log; name=rc3-mm3_bootup.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.13-rc3-mm3 (root@mars) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #4 SMP Fri Jul 29 16:30:41 MDT 2005
EFI v1.10 by HP: SALsystab=0x3fb38000 ACPI 2.0=0x3fb2e000 SMBIOS=0x3fb3a000 HCDP=0x3fb2c000
booting generic kernel on platform hpzx1
PCDP: v0 at 0x3fb2c000
Explicit "console="; ignoring PCDP
Early serial console at MMIO 0xff5e0000 (options '115200')
efi.trim_top: ignoring 4KB of memory at 0x0 due to granule hole at 0x0
efi.trim_top: ignoring 636KB of memory at 0x1000 due to granule hole at 0x0
efi.trim_bottom: ignoring 15360KB of memory at 0x100000 due to granule hole at 0x0
SAL 3.1: HP version 2.31
SAL Platform features: None
SAL: AP wakeup using external interrupt vector 0xff
No logical to physical processor mapping available
ACPI: Local APIC address c0000000fee00000
GSI 36 (level, low) -> CPU 0 (0x0000) vector 48
2 CPUs available, 2 CPUs total
MCA related initialization done
Virtual mem_map starts at 0xa0007fffc7200000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi1:/EFI/debian/boot/vmlinuz-2.6.13-rc3-mm3 root=/dev/sdb2 console=uart,mmio,0xff5e0000  ro
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour VGA+ 80x25
Memory: 12439136k/12542128k available (7051k code, 116240k reserved, 3406k data, 352k init)
Leaving McKinley Errata 9 workaround enabled
Dentry cache hash table entries: 2097152 (order: 10, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0x0
CPU 1: synchronized ITC with CPU 0 (last diff -5 cycles, maxerr 433 cycles)
Brought up 2 CPUs
Total of 2 processors activated (2695.16 BogoMIPS).
-> [0][1][ 786432]   0.5 [  0.5] (0): (  500513   250256)
-> [0][1][ 827823]   0.5 [  0.5] (0): (  529015   139379)
-> [0][1][ 871392]   0.5 [  0.5] (0): (  557119    83741)
-> [0][1][ 917254]   0.5 [  0.5] (0): (  585481    56051)
-> [0][1][ 965530]   0.6 [  0.6] (0): (  615654    43112)
-> [0][1][1016347]   0.6 [  0.6] (0): (  653296    40377)
-> [0][1][1069838]   0.6 [  0.6] (0): (  681359    34220)
-> [0][1][1126145]   0.7 [  0.7] (0): (  706209    29535)
-> [0][1][1185415]   0.7 [  0.7] (0): (  754788    39057)
-> [0][1][1247805]   0.7 [  0.7] (0): (  788675    36472)
-> [0][1][1313478]   0.8 [  0.8] (0): (  840102    43949)
-> [0][1][1382608]   0.7 [  0.8] (0): (  742042    71004)
-> [0][1][1455376]   0.6 [  0.8] (0): (  653934    79556)
-> [0][1][1531974]   0.7 [  0.8] (0): (  766991    96306)
-> [0][1][1612604]   0.7 [  0.8] (0): (  779253    54284)
-> [0][1][1697477]   0.5 [  0.8] (0): (  534912   149312)
-> [0][1][1786817]   0.5 [  0.8] (0): (  503106    90559)
-> found max.
[0][1] working set size found: 1313478, cost: 840102
---------------------
| migration cost matrix (max_cache_size: 1572864, cpu: -1 MHz):
---------------------
          [00]    [01]
[00]:     -     1.6(0)
[01]:   1.6(0)    -   
--------------------------------
| cacheflush times [1]: 1.6 (1680204)
| calibration delay: 1 seconds
--------------------------------
NET: Registered protocol family 16
ACPI: bus type pci registered
ACPI: Subsystem revision 20050708
    ACPI-0509: *** Error: Method execution failed [\PARS.GFIT] (Node e0000002ffff8a00), AE_BAD_PARAMETER
    ACPI-0509: *** Error: Method execution failed [\_SB_.SBA0._INI] (Node e0000002ffffa780), AE_BAD_PARAMETER
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
SCSI subsystem initialized
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
EFI Time Services Driver v0.4
i8042.c: No controller found.
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
ide-floppy driver 0.99.newide
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.02
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP route cache hash table entries: 2097152 (order: 10, 16777216 bytes)
TCP established hash table entries: 8388608 (order: 13, 134217728 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 8388608 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
No ttyS device at MMIO 0xff5e0000 for console

--=-dgYOYDJtLJmrmmZ0nYKM--

