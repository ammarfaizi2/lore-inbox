Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132310AbQLNKnp>; Thu, 14 Dec 2000 05:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132307AbQLNKnf>; Thu, 14 Dec 2000 05:43:35 -0500
Received: from takayasu.center.osakafu-u.ac.jp ([157.16.240.30]:6600 "EHLO
	takayasu.center.osakafu-u.ac.jp") by vger.kernel.org with ESMTP
	id <S132310AbQLNKn0>; Thu, 14 Dec 2000 05:43:26 -0500
To: linux-kernel@vger.kernel.org
Subject: failed in BUG() at fs/buffer.c:765
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Capitol Reef)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001214191242E.ark@center.osakafu-u.ac.jp>
Date: Thu, 14 Dec 2000 19:12:42 +0900
From: Atsuhiro Kojima <ark@center.osakafu-u.ac.jp>
X-Dispatcher: imput version 991025(IM133)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel maintainers,
I will report my problem around 2.4.0-test kernel.

Thanks in advance.

---
[1.] failed in BUG() at fs/buffer.c:765
[2.] 
My linux 2.4.0-test12 box failed on writing some files on soft-raid
partition. It seems to touch BUG() macro at fs/buffer.c:765, when file
buffer exceeds a certain amount!?
The raid partion is build under earlier 2.4.0-test* kernel, and
relatively stable on at least 2.4.0-test10.

[3.] kernel BUG, buffer.c, raid5d
[4.]
Linux version 2.4.0-test12 (root@cuvier) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 SMP Wed Dec 13 10:18:18 JST 2000

[5.]
kernel BUG at buffer.c:765!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132601>]
EFLAGS: 00010286
eax: 0000001c   ebx: cc568b28   ecx: 00000000   edx: 02000000
esi: cfe6e160   edi: cfe6e000   ebp: cc568ae0   esp: c1535e8c
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 9, stackpage=c1535000)
Stack: c024e6ba c024ea3a 000002fd 00000008 c01ebe5c cc568ae0 00000001 00000008 
       cfe6e000 00000002 00000000 c01ec9bf cfe6e000 00000002 00000001 cfe6e000 
       c15dd000 cfe6e000 00000003 00000003 c15dd000 c01ed517 cfe6e000 cfe6e000 
Call Trace: [<c024e6ba>] [<c024ea3a>] [<c01ebe5c>] [<c01ec9bf>] [<c01ed517>] [<c01bb97f>] [<d0804087>] 
       [<c01d0c6c>] [<c01eda89>] [<c01f4857>] [<c0107488>] 
Code: 0f 0b 83 c4 0c 5b c3 55 57 56 53 8b 5c 24 14 8b 54 24 18 85 

[6.]
writing some files on raid partition.
[7.]
[7.1.]
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux cuvier 2.4.0-test12 #1 SMP Wed Dec 13 10:18:18 JST 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         

[7.2.]
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 397.730
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 792.99

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 397.730
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 794.62

[7.3.]

[7.4.]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  a400-a4ff : Adaptec AIC-7881U
    a400-a4fe : aic7xxx
  a800-a8ff : Adaptec AHA-294x / AIC-7871
    a800-a8fe : aic7xxx
  af00-af3f : Intel Corporation 82557 [Ethernet Pro 100]
    af00-af3f : eepro100
b000-cfff : PCI Bus #02
  b000-bfff : PCI Bus #03
d000-dfff : PCI Bus #04
e800-e8ff : Intel Corporation 82801AA AC'97 Audio
ef00-ef3f : Intel Corporation 82801AA AC'97 Audio
ef80-ef9f : Intel Corporation 82801AA USB
efa0-efaf : Intel Corporation 82801AA SMBus
ffa0-ffaf : Intel Corporation 82801AA IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1


00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Extension ROM
000ca800-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-002a7a8f : Kernel code
  002a7a90-002bfb1f : Kernel data
f2e00000-f4efffff : PCI Bus #01
  f3000000-f3ffffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
f4f00000-f50fffff : PCI Bus #02
  f4f00000-f4ffffff : PCI Bus #03
f5100000-f51fffff : PCI Bus #04
f8000000-fbffffff : Intel Corporation 82840 840 (Carmel) Chipset Host Bridge (Hub A)
fd300000-fe7fffff : PCI Bus #01
  fd800000-fdffffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
  fe600000-fe6fffff : Intel Corporation 82557 [Ethernet Pro 100]
  fe7f9000-fe7f9fff : Adaptec AIC-7881U
  fe7fa000-fe7fafff : Intel Corporation 82557 [Ethernet Pro 100]
    fe7fa000-fe7fafff : eepro100
  fe7fb000-fe7fbfff : Adaptec AHA-294x / AIC-7871
  fe7fc000-fe7fffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
fe800000-fe9fffff : PCI Bus #02
  fe800000-fe8fffff : PCI Bus #03
    fe8ff000-fe8fffff : Intel Corporation 82806AA PCI64 Hub Advanced Programmable Interrupt Controller
fea00000-feafffff : PCI Bus #04

[7.5.]
00:00.0 Host bridge: Intel Corporation: Unknown device 1a21 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0 set
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=421
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

00:01.0 PCI bridge: Intel Corporation: Unknown device 1a23 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: f5100000-f51fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:02.0 PCI bridge: Intel Corporation: Unknown device 1a24 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=64
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: fe800000-fe9fffff
	Prefetchable memory behind bridge: f4f00000-f50fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801 82810 PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fd300000-fe7fffff
	Prefetchable memory behind bridge: f2e00000-f4efffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801 82810 Chipset ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:1f.1 IDE interface: Intel Corporation 82801 82810 Chipset IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 2411
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801 82810 Chipset USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 2412
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at ef80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801 82810 Chipset SMBus (rev 02)
	Subsystem: Intel Corporation: Unknown device 2413
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at efa0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2415 (rev 02)
	Subsystem: Unknown device 4352:5934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ef00 [size=64]

01:00.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at fe7f9000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe7d0000 [disabled] [size=64K]

01:01.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at fe7fb000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe7f0000 [disabled] [size=32K]

01:07.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at f3000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fe7fc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at fe7e0000 [disabled] [size=64K]

01:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe7fa000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at af00 [size=64]
	Region 2: Memory at fe600000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe500000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:1f.0 PCI bridge: Intel Corporation: Unknown device 1360 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe800000-fe8fffff
	Prefetchable memory behind bridge: f4f00000-f4ffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

03:00.0 PIC: Intel Corporation: Unknown device 1161 (rev 01) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corporation: Unknown device 1161
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Region 0: Memory at fe8ff000 (32-bit, non-prefetchable) [size=4K]

[7.6.]
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST34555W         Rev: 0930
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST34555W         Rev: 0930
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 07 Lun: 00
  Vendor: SEAGATE  Model: ST39173W         Rev: 6244
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: SEAGATE  Model: ST39173W         Rev: 6244
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: SEAGATE  Model: ST39173W         Rev: 6244
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-3801TA Rev: 3386
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] /proc/mdstat:
Personalities : [linear] [raid0] [raid1] [raid5] 
read_ahead 1024 sectors
md0 : active raid5 sde1[2] sdd1[1] sdc1[0]
      17767680 blocks level 5, 32k chunk, algorithm 2 [3/3] [UUU]
      
unused devices: <none>
---
Atsuhiro Kojima
Library & Science Information Center, Osaka Prefecture University.
E-mail: ark@center.osakafu-u.ac.jp
http://cuvier.center.osakafu-u.ac.jp/ark/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
