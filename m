Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279839AbRJ3DuB>; Mon, 29 Oct 2001 22:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279841AbRJ3Dtw>; Mon, 29 Oct 2001 22:49:52 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:50693 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279839AbRJ3Dtl>;
	Mon, 29 Oct 2001 22:49:41 -0500
Message-Id: <5.1.0.14.0.20011030133431.00a70b90@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 30 Oct 2001 14:50:14 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: SiS sound driver
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current state of affairs with the SiS/Trident driver tests on this (damn 
annoying) machine.

Any suggestions where to go from here? Recommendations of where to look? 
Anything I can test, probe, send the output of? I'm starting to think it's 
a PCI addressing problem caused in part by the PnP BIOS. There isn't any 
option to disable the PCI PnP BIOS, otherwise I'd have tried that already. 
Going to try removing the FireWire expansion and see if that will change 
things (by giving me back another interrupt that is).


With 2.4.13: Loads but no sound.
  (Fixed the PCI_VENDOR_ID_SI and the device array trailing {0,})

With 2.4.13-ac4: Does not load: "trident: can't allocate I/O space at 0x1000"
  (Fixed the PCI_VENDOR_ID_SI)

With 2.4.9: kernel oops.
  (Fixed the PCI_VENDOR_ID_SI and the device array trailing {0,})

With 2.4.7: Loads but no sound.
  (Fixed the PCI_VENDOR_ID_SI)


All drivers that load produce the following output (well the 
version/compile time is different):
  Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 
0.14.9d, 17:16:29 Oct 29 2001
  PCI: Found IRQ 5 for device 00:01.4
  PCI: Sharing IRQ 5 with 00:0c.1
  trident: SiS 7018 PCI Audio found at IO 0x1000, IRQ 5
  ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)


Kernel oops from 2.4.9:
  Trident 4DWave/SiS 7018/ALi 5451 PCI Audio, version 0.14.9b, 13:49:46 Oct 
30 2001
  PCI: Found IRQ 5 for device 00:01.4
  PCI: Sharing IRQ 5 with 00:0c.1
  trident: SiS 7018 PCI Audio found at IO 0x1000, IRQ 5
  ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
  Unable to handle kernel NULL pointer dereference at virtual address 00000000
   printing eip:
  cf82ad86
  *pde = 00000000
  Oops: 0000
  CPU:    0
  EIP:    0010:[<cf82ad86>]
  EFLAGS: 00010297
  eax: 00000000   ebx: ceeed980   ecx: 02000040   edx: 00001044
  esi: 000001ec   edi: 00000029   ebp: 00000000   esp: cdebfe6c
  ds: 0018   es: 0018   ss: 0018
  Process modprobe (pid: 220, stackpage=cdebf000)
  Stack: ceeed980 000001ec 00000029 cf82acec ceeed980 cf82be60 cf82bb4d 
00000000
         00000000 cf82be4a 02000000 00000000 ceeed980 ce7e6800 00000000 
00000000
         cf832ab4 ceeed980 cf833bc0 cef64c00 ce7e6800 00000000 ceeed980 
cf832ed0
  Call Trace: [<cf82acec>] [<cf82be60>] [<cf82bb4d>] [<cf82be4a>] [<cf832ab4>]
     [<cf833bc0>] [<cf832ed0>] [<cf832f34>] [<cf833c08>] [<cf833d60>] 
[pci_announce_device+54/84]
     [<cf833c08>] [<cf833d60>] [pci_register_driver+72/96] [<cf833d60>] 
[<cf833127>] [<cf833d60>]
     [<cf8339a0>] [sys_init_module+1285/1448] [<cf82e060>] [system_call+51/56]

  Code: 83 38 00 74 08 53 8b 00 ff d0 83 c4 04 31 ff ba e0 c0 82 cf


Output of 'lspci -bv' from 2.4.13-ac4:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
	Flags: bus master, medium devsel, latency 128
	Memory at 30000000 (32-bit, non-prefetchable)
	Capabilities: [c0] AGP version 2.0

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 80 [Master])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 2200
	Flags: bus master, fast devsel, latency 16
	I/O ports at 1100

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Flags: bus master, medium devsel, latency 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 82)
	Subsystem: CLEVO/KAPOK Computer: Unknown device 2200
	Flags: bus master, medium devsel, latency 128, IRQ 9
	I/O ports at 3000
	Memory at 34000000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Flags: bus master, medium devsel, latency 128, IRQ 255
	Memory at 34001000 (32-bit, non-prefetchable)

00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 7000
	Flags: bus master, medium devsel, latency 128, IRQ 255
	Memory at 34002000 (32-bit, non-prefetchable)

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS 
PCI Audio Accelerator (rev 02)
	Subsystem: CLEVO/KAPOK Computer SiS PCI Audio Accelerator
	Flags: bus master, medium devsel, latency 128, IRQ 5
	I/O ports at 1000
	Memory at 34003000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

00:01.6 Modem: Silicon Integrated Systems [SiS]: Unknown device 7013 (rev 
a0) (prog-if 00 [Generic])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 2200
	Flags: bus master, medium devsel, latency 128, IRQ 9
	I/O ports at 3200
	I/O ports at 3300
	Capabilities: [48] Power Management version 2

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 
00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: 50000000-560fffff
	Prefetchable memory behind bridge: 40000000-4f0fffff

00:0c.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: CLEVO/KAPOK Computer: Unknown device 2200
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: CLEVO/KAPOK Computer: Unknown device 2200
	Flags: bus master, medium devsel, latency 168, IRQ 5
	Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:0d.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 
(prog-if 10 [OHCI])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 8586
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at e910f000 (32-bit, non-prefetchable)
	Memory at e9100000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 1

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 
GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 2200
	Flags: 66Mhz, medium devsel
	BIST result: 00
	Memory at 40000000 (32-bit, prefetchable)
	Memory at 50000000 (32-bit, non-prefetchable)
	I/O ports at a000
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0

AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

