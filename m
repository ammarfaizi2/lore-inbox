Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262958AbSJBD4U>; Tue, 1 Oct 2002 23:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSJBD4U>; Tue, 1 Oct 2002 23:56:20 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:1677 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S262958AbSJBD4K>; Tue, 1 Oct 2002 23:56:10 -0400
Date: Wed, 2 Oct 2002 00:01:35 -0400
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Subject: Oops (ide?) with 2.4.20-pre8-ac3 at boot on scsi only smp
Message-ID: <20021002040135.GA6652@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   hi,

   First report - please let me know what more 
   I can do to help.

   gene/

  
   (0) 2.4.20-pre8-ac3 - oops at boot - scsi disks only - 
       no IDE disks - smp.

   (1) Fresh build of 2.4.20-pre8-ac3 - aic7xxx driver in kernel -
      oops'es at boot in IDE code with  'Unable to handle kernel NULL pointer'
      Does have IDE cdrom and CDRW (latter booted with ide-scsi)

      Machine is dual P4 with 1 Gb memory and kernel compiled with 4Gb memory
      model. Runs fine under stock redhat 2.4.18-10 kernel

   ------------------------------------------------------------------------
   (2) Oops: (hand entered)

ksymoops 2.4.6 on i686 2.4.18-10smp.  Options used
     -v /boot/2.4/2.4.20-pre8-ac3/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-pre8-ac3/ (specified)
     -m /boot/2.4/2.4.20-pre8-ac3/System.map (specified)

No modules in ksyms, skipping objects
        ide1: BM-DMA at 0xffa8-0xffaf<1> Unable to handle kernel NULL pointer
 c01baa84
 *pde = 00000000
 Oops: 0000
 CPU:     0
 EIP:     0010:[<c01baa84>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS:  00010202
 eax:     00000000    ebx: c039c6e0    ecx: c36944cc   edx: c02b87d4
 esi:     c039c6cc    edi: 0000ffa8    ebp: 00000000   esp: c34abedc
 ds:  0018   es: 0018  ss: 0018
 Process swapper (pid: 1, stackpage=c34ab000)
 Stack: 00000008 c039c6cc c3694400 c02b87d4 c01bab46 c039c6cc 0000ffa8 00000008
        0000ffa8 c039c6cc c0303b81 c039c6cc 0000ffa8 00000008 c01b9356 c039c6cc
        0000ffa8 000587f5 c039c6cc c02b87f5 c03901f0 c02b87d4 c01b96c6 c3694400
 Call Trace: [<c01bab46>] [<c01b9356>] [<c01b96c6>] [<c01b9737>] [<c01a51d5>]
             [<c0105000>] [<c0105078>] [<c0105000>] [<c01071f6>] [<c0105050>]
 Code: 8b 80 3c 04 00 00 eb 06 8d 74 26 00 89 f8 89 86 38 04 00 00


>>EIP; c01baa84 <ide_iomio_dma+a4/110>   <=====

>>ebx; c039c6e0 <ide_hwifs+480/2c38>
>>edx; c02b87d4 <piix_pci_info+1e0/330>
>>esi; c039c6cc <ide_hwifs+46c/2c38>

Trace; c01bab46 <ide_setup_dma+16/2a0>
Trace; c01b9356 <ide_hwif_setup_dma+b6/f0>
Trace; c01b96c6 <do_ide_setup_pci_device+236/290>
Trace; c01b9737 <ide_setup_pci_device+17/20>
Trace; c01a51d5 <piix_init_one+35/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105078 <init+28/190>
Trace; c0105000 <_stext+0/0>
Trace; c01071f6 <kernel_thread+26/30>
Trace; c0105050 <init+0/190>

Code;  c01baa84 <ide_iomio_dma+a4/110>
00000000 <_EIP>:
Code;  c01baa84 <ide_iomio_dma+a4/110>   <=====
   0:   8b 80 3c 04 00 00         mov    0x43c(%eax),%eax   <=====
Code;  c01baa8a <ide_iomio_dma+aa/110>
   6:   eb 06                     jmp    e <_EIP+0xe> c01baa92 <ide_iomio_dma+b2/110>
Code;  c01baa8c <ide_iomio_dma+ac/110>
   8:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01baa90 <ide_iomio_dma+b0/110>
   c:   89 f8                     mov    %edi,%eax
Code;  c01baa92 <ide_iomio_dma+b2/110>
   e:   89 86 38 04 00 00         mov    %eax,0x438(%esi)

  <0>Kernel panic: Attempted to kill init!

   ------------------------------------------------------------------------
   (3) ver_linux:

      Linux flash 2.4.18-10smp #1 SMP Wed Aug 7 11:17:48 EDT 2002 i686 unknown
 
     Gnu C                  2.96
     Gnu make               3.79.1
     util-linux             2.11n
     mount                  2.11n
     modutils               2.4.14
     e2fsprogs              1.27
     jfsutils               1.0.17
     reiserfsprogs          3.x.0j
     pcmcia-cs              3.1.22
     PPP                    2.4.1
     isdn4k-utils           3.1pre1
     Linux C Library        2.2.5
     Dynamic linker (ldd)   2.2.5
     Procps                 2.0.7
     Net-tools              1.60
     Console-tools          0.3.3
     Sh-utils               2.0.11
     Modules Loaded         nfs lockd sunrpc sr_mod emu10k1 sound ac97_codec soundcore radeon agpgart parport_pc lp parport binfmt_misc autofs 3c59x ide-scsi ide-cd cdrom mousedev hid input usb-uhci usbcore ext3 jbd aic7xxx sd_mod scsi_mod
     
   ------------------------------------------------------------------------
   4) cat /proc/cpuinfo
      processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.897
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3381.65

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.897
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3381.65


   ------------------------------------------------------------------------
    5) lspci -vvv

  
00:00.0 Host bridge: Intel Corp. 82850 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: ff800000-ff9fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff500000-ff7fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff300000-ff4fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80 [Master])
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 04) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at bcd0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 04) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 23
	Region 4: I/O ports at ff60 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 1b8a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at ec00 [size=256]
	Region 2: Memory at ff8f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at c1000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff600000-ff7fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82806AA PCI64 Hub APIC
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at ff6ff000 (32-bit, non-prefetchable) [disabled] [size=4K]

03:0c.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 20
	BIST result: 00
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at ff6fe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at ff700000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0e.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 22
	BIST result: 00
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at ff6fd000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at ff700000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at cc80 [size=128]
	Region 1: Memory at ff3ffc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ff400000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

04:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link) (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00d8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ff3ff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ff3f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4780 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at cc60 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:0e.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at cc58 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

       
   ------------------------------------------------------------------------
    5) cat /proc/scsi/scsi

Attached devices: 
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAM3184MP        Rev: 5A01
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: FUJITSU  Model: MAM3184MP        Rev: 5A01
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: NR-7800A         Rev: 1.0B
  Type:   CD-ROM                           ANSI SCSI revision: 02

   ------------------------------------------------------------------------
