Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263634AbREYIaj>; Fri, 25 May 2001 04:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263649AbREYIaV>; Fri, 25 May 2001 04:30:21 -0400
Received: from mail.inup.com ([194.250.46.226]:60682 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263634AbREYIaD>;
	Fri, 25 May 2001 04:30:03 -0400
Date: Fri, 25 May 2001 10:29:05 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: dean@dasco.ltd.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: fifo behaviour is broken in 2.4.4
Message-ID: <20010525102905.A18683@pc8.lineo.fr>
In-Reply-To: <Tc18428c053b679d761@brwmsw01.btcellnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Tc18428c053b679d761@brwmsw01.btcellnet.net>; from dean@dasco.ltd.uk on Thu, May 24, 2001 at 10:15:02 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the same thing on a vanillia 2.4.4 kernel.
It works on 2.2.18.

Christophe

On Thu, 24 May 2001 10:15:02 dean@dasco.ltd.uk wrote:
> 
> [1.] fifo behaviour is broken in 2.4.4
> 
> [2.] fifo are being flushed. Sending characters to a fifo, select(2)
> returns
> 'ready to read' on the fifo, but attempting to determine the number of
> characters in fifo returns zero.
> 
> [3.] mkfifo select flush kernel fs
> 
> [4.] Linux version 2.4.4 (root@devl) (gcc version 2.95.2 19991024
> (release)) #1 Sat Apr 28 21:15:56 BST 2001
> 
> [5.] Not Ooops.
> 
> [6.]
> 
> In first session:
> 
>   mkfifo /tmp/myfifo
>   while (sleep 2)
>   do
>      echo fred > /tmp/myfifo
>   done
> 
> 
> In second session:
> 
>   tail -f /tmp/myfifo
> 
> 
> 
> Expect 2nd session to display 'fred' every 2 seconds.
> Results I am getting, in 2.4.4, just one 'fred'.
> 
> [
> Test of expectations:
>     Linux 2.4.3 as expected   (albeit with 'file trucation' warnings)
>     Solaris 2.6: as expected
> ]
> 
> [7.] Any shell
> 
> [7.1] ver_linux
> 
> Linux devl 2.4.4 #1 Sat Apr 28 21:15:56 BST 2001 i686 unknown
> Gnu C                  2.95.2
> Gnu make               3.79.1
> binutils               2.9.5.0.24
> util-linux             2.10q
> mount                  2.10q
> modutils               2.4.1
> e2fsprogs              1.19
> pcmcia-cs              3.1.17
> PPP                    2.3.11
> isdn4k-utils           3.1pre1a
> Linux C Library        x    1 root     root      1382179 Jan 19 06:14
> /lib/libc.so.6
> Dynamic linker (ldd)   2.2
> Procps                 2.0.6
> Net-tools              1.57
> Kbd                    0.99
> Sh-utils               2.0
> Modules Loaded
> 
> [7.2] /proc/cpuinfo
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 6
> model name      : Celeron (Mendocino)
> stepping        : 10
> cpu MHz         : 466.678
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
> cmov pat pse36 mmx fxsr
> bogomips        : 930.61
> 
> [7.3] /proc/modules
> 
> [7.4] /proc/ioports, /proc/iomem
> 
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 0cf8-0cff : PCI conf1
> 1000-103f : Intel Corporation 82371AB PIIX4 ACPI
> 1040-105f : Intel Corporation 82371AB PIIX4 ACPI
> 1060-107f : Intel Corporation 82371AB PIIX4 USB
> 1080-108f : Intel Corporation 82371AB PIIX4 IDE
>   1080-1087 : ide0
>   1088-108f : ide1
> 1400-14ff : ESS Technology ES1978 Maestro 2E
>   1400-14ff : ESS Maestro 2E
> 1800-18ff : PCI CardBus #02
>   1800-187f : PCI device 115d:0003
>     1800-187f : xircom_tulip_cb
>   1880-1887 : PCI device 115d:0103
> 1c00-1cff : PCI CardBus #02
> 2000-2fff : PCI Bus #01
>   2000-20ff : ATI Technologies Inc 3D Rage P/M Mobility AGP 2x
> 3000-30ff : PCI CardBus #06
> 3400-34ff : PCI CardBus #06
> 
> 
> 
> 00000000-0009f7ff : System RAM
> 0009f800-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-13feffff : System RAM
>   00100000-002090ad : Kernel code
>   002090ae-0026a98b : Kernel data
> 13ff0000-13fffbff : ACPI Tables
> 13fffc00-13ffffff : ACPI Non-volatile Storage
> 14000000-14000fff : Texas Instruments PCI1225
> 14001000-14001fff : Texas Instruments PCI1225 (#2)
> 14400000-147fffff : PCI CardBus #02
>   14400000-14403fff : PCI device 115d:0003
>   14404000-14407fff : PCI device 115d:0103
> 14800000-14bfffff : PCI CardBus #02
>   14800000-148007ff : PCI device 115d:0003
>   14800800-14800fff : PCI device 115d:0003
>   14801000-148017ff : PCI device 115d:0103
>   14801800-14801fff : PCI device 115d:0103
> 14c00000-14ffffff : PCI CardBus #06
> 15000000-153fffff : PCI CardBus #06
> e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
> fc000000-fdffffff : PCI Bus #01
>   fc000000-fc000fff : ATI Technologies Inc 3D Rage P/M Mobility AGP 2x
>   fd000000-fdffffff : ATI Technologies Inc 3D Rage P/M Mobility AGP 2x
> fff80000-ffffffff : reserved
> 
> 
> [7.5] lspci -vvv
> 
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
> (rev 03)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR+
> 	Latency: 64
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: [a0] AGP version 1.0
> 		Status: RQ=31 SBA+ 64bit- FW- Rate=x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
> (rev 03) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 128
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> 	I/O behind bridge: 00002000-00002fff
> 	Memory behind bridge: fc000000-fdffffff
> 	Prefetchable memory behind bridge: fff00000-000fffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
> 
> 00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
> 	Subsystem: Dell Computer Corporation: Unknown device 009e
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168, cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
> 	Memory window 0: 14400000-147ff000 (prefetchable)
> 	Memory window 1: 14800000-14bff000
> 	I/O window 0: 00001800-000018ff
> 	I/O window 1: 00001c00-00001cff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt-
> PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 00:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
> 	Subsystem: Dell Computer Corporation: Unknown device 009e
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168, cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 14001000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=06, subordinate=06, sec-latency=176
> 	Memory window 0: 14c00000-14fff000 (prefetchable)
> 	Memory window 1: 15000000-153ff000
> 	I/O window 0: 00003000-000030ff
> 	I/O window 1: 00003400-000034ff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
> PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 
> 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> (prog-if 80 [Master])
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Region 4: I/O ports at 1080 [size=16]
> 
> 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> (prog-if 00 [UHCI])
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin D routed to IRQ 5
> 	Region 4: I/O ports at 1060 [size=32]
> 
> 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin ? routed to IRQ 9
> 
> 00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E
> (rev 10)
> 	Subsystem: Dell Computer Corporation: Unknown device 009e
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (500ns min, 6000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at 1400 [size=256]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold-)
> 		Status: D2 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M
> Mobility AGP 2x (rev 64) (prog-if 00 [VGA])
> 	Subsystem: Dell Computer Corporation: Unknown device 009e
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 66 (2000ns min), cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at fd000000 (32-bit, non-prefetchable)
> [size=16M]
> 	Region 1: I/O ports at 2000 [size=256]
> 	Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [50] AGP version 1.0
> 		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 	Capabilities: [5c] Power Management version 1
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
> 	Subsystem: Xircom Cardbus Ethernet 10/100
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (5000ns min, 10000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at 1800 [size=128]
> 	Region 1: Memory at 14800000 (32-bit, non-prefetchable) [size=2K]
> 	Region 2: Memory at 14800800 (32-bit, non-prefetchable) [size=2K]
> 	Expansion ROM at 14400000 [size=16K]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 
> 02:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)
> (prog-if 02 [16550])
> 	Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at 1880 [size=8]
> 	Region 1: Memory at 14801000 (32-bit, non-prefetchable) [size=2K]
> 	Region 2: Memory at 14801800 (32-bit, non-prefetchable) [size=2K]
> 	Expansion ROM at 14404000 [size=16K]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 
> 
> 
> [7.6] /proc/scsi/scsi NA
> 
> [7.7] -
> 
> 
> [8.] Method in [6.] tested on 2.4.3 and Solaris 2.6 both work as
> expected.
> 
> 
> Cheers,
>   Dean.
> 
> -- 
> Dean.A.Darlison                                           
> dean@dasco.ltd.uk
> Dasco Ltd.                                          
> http://www.dasco.ltd.uk/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

