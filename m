Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288570AbSADJjM>; Fri, 4 Jan 2002 04:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288562AbSADJjE>; Fri, 4 Jan 2002 04:39:04 -0500
Received: from abaddon02.airbus.dasa.de ([193.96.150.5]:58831 "EHLO
	abaddon02.airbus.dasa.de") by vger.kernel.org with ESMTP
	id <S288569AbSADJi6>; Fri, 4 Jan 2002 04:38:58 -0500
Message-ID: <ADC649D6283BD511B2A90008C71E93BF33A430@s02mks8.ham.airbus.dasa.de>
From: "Bartels, Christian" <Christian.Bartels@airbus.dasa.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 53c810 SCSI controller not accessible on type-2 config PCI [Kerne
	l 2.4.17]
Date: Fri, 4 Jan 2002 10:38:14 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  upgrading from Suse 7.1 [Kernel 2.2.18] to 7.3 [Kernel 2.4.10], I
found that my type-2 PCI bus was no longer detected. Read Linus'
posting of 2001-10-08 [Re: PCI problem with 2.4.10 on 82434LX Chipset]
and realized that 2.4.10 is 'supposed' to not support type-2 config
PCI. Compiled 2.4.17 kernel, but had problems accessing the SCSI
controller (Symbios 53c810). Tryed also kernel 2.4.4 - same situation
as for 2.4.17 kernel.

For Kernel 2.2.18, I get the following output:
Kernel Bootmessages:
---------------------------------------------------------------------------
PCI: PCI BIOS revision 2.00 entry at 0xfb370, last bus=15
PCI: Using configuration type 2
PCI: Probing PCI hardware
[...]
scsi : 0 hosts.
scsi : detected total.
[...]
ncr53c8xx: at PCI bus 0, device 5, function 0
ncr53c8xx: MMIO base address disabled.
sym53c8xx: at PCI bus 0, device 5, function 0
sym53c8xx: not initializing, device not supported
scsi-ncr53c7,8xx : at PCI bus 0, device 5,  function 0
scsi-ncr53c7,8xx : NCR53c810 at memory 0x0, io 0xd000, irq 10
scsi0 : burst length 8
scsi0 : reset ccf to 3 from 0
scsi0 : NCR code relocated to 0x2a60610 (virt 0xc2a60610)
scsi0 : test 1 started
scsi0 : NCR53c{7,8}xx (rel 17)
[...]
linuxrc uses obsolete /proc/pci interface
---------------------------------------------------------------------------

Output of 'cat /proc/pci'
----------------------------------------------------------------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 82434LX Mercury/Neptune (rev 3).
      Slow devsel.  Master Capable.  Latency=32.  
  Bus  0, device   2, function  0:
    Non-VGA device: Intel 82378IB (rev 3).
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device   5, function  0:
    Non-VGA device: NCR 53c810 (rev 1).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=80.  
      I/O at 0xd000 [0xd001].
  Bus  0, device   6, function  0:
    VGA compatible controller: S3 Inc. Trio32/Trio64 (rev 84).
      Medium devsel.  IRQ 11.  
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc000000].
----------------------------------------------------------------

Output of 'cat /proc/ioports'
----------------------------------------------------------------
[...]
03f8-03ff : serial(auto)
d000-d07f : ncr53c7,8xx
----------------------------------------------------------------

For Kernel 2.4.17, I get the following output:
Kernel Bootmessages (no Kernel options):
----------------------------------------------------------------
PCI: PCI BIOS revision 2.00 entry at 0xfb370, last bus=15
PCI: Using configuration type 2
PCI: Probing PCI Hardware
PCI: Discovered peer bus 01
PCI: Discovered peer bus 02
PCI: Discovered peer bus 03
PCI: Discovered peer bus 04
PCI: Discovered peer bus 05
PCI: Discovered peer bus 06
PCI: Discovered peer bus 07
PCI: Discovered peer bus 08
PCI: Discovered peer bus 09
PCI: Discovered peer bus 0a
PCI: Discovered peer bus 0b
PCI: Discovered peer bus 0c
PCI: Discovered peer bus 0d
PCI: Discovered peer bus 0e
PCI: Discovered peer bus 0f
PCI: Device 00:10 not found by BIOS
PCI: Device 00:28 not found by BIOS
PCI: Device 00:30 not found by BIOS
PCI: Device 01:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 01:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 02:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 03:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 04:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 05:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 06:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 07:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 08:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 09:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 0a:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 0b:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 0c:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 0d:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 0e:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
PCI: Device 0f:00 not found by BIOS
PCI: BIOS reporting unknown device 00:00
[...]
SCSI subsystem driver Revision: 1.00
PCI: Device 00:05.0 not available because of resource collisions
----------------------------------------------------------------

Kernel Bootmessages (boot option 'pci=conf1'):
----------------------------------------------------------------
PCI: PCI BIOS revision 2.00 entry at 0xfb370, last bus=15
PCI: No PCI bus detected
----------------------------------------------------------------

Kernel Bootmessages (boot option 'pci=conf2' or 'pci=nobios'):
----------------------------------------------------------------
PCI: Using configuration type 2
PCI: Probing PCI Hardware
[...]
SCSI subsystem driver Revision: 1.00
PCI: Device 00:05.0 not available because of resource collisions
----------------------------------------------------------------

Output of 'cat /proc/pci'
----------------------------------------------------------------
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:04a3 (rev 3)
      Master Capable.  Latency=32.
  Bus  0, device   2, function  0:
    Class 0000: PCI device 8086:0484 (rev 3)
  Bus  0, device   5, function  0:
    Class 0000: PCI device 1000:0001 (rev 1)
      IRQ 10
      Master Capable.  Latency=80.
      I/O at 0xd000 [0xd0ff]
      Non-prefetchable 32 bit memory at 0x0 [0xff]
  Bus  0, device   6, function  0:
    Class 0300: PCI device 5333:8811 (rev 84)
      IRQ 11
      Non-prefetchable 32 bit memory at 0xfc000000 [0xffffffff].
----------------------------------------------------------------

Output of 'cat /proc/ioports'
----------------------------------------------------------------
[...]
03f8-03ff : serial(auto)
0cf8-0cfb : PCI conf2
d000-d0ff : PCI device 1000:0001
----------------------------------------------------------------

In summary:
- With no boot option, 2.4.17 detects peer busses where there are
  none.
- With boot option 'pci=conf2', 2.4.17 detects a resource collision
  for the SCSI controller (PCI device 5), making it unaccessible to
  any SCSI low-level driver - but 2.2.18 did not detect such a
  resource collision.

My Hardware:
Mainboard: ASUS P_I-P5MP3 60/66 MHz, Intel Processor Socket 4
CPU: Pentium Overdrive 133 MHz
SCSI Controller: Symbios 53c810 (rev. 1) on an ASUS SC-200 Controller
                 card. The SCSI controller does not support MMIO.

Thanks in advance for any advice how to solve this problem.

Regards,
          Christian Bartels
