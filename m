Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291637AbSB0C2H>; Tue, 26 Feb 2002 21:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291640AbSB0C17>; Tue, 26 Feb 2002 21:27:59 -0500
Received: from [209.250.58.215] ([209.250.58.215]:35333 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S291637AbSB0C1h>; Tue, 26 Feb 2002 21:27:37 -0500
Date: Tue, 26 Feb 2002 20:27:17 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Tom Eastep <teastep@shorewall.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Northbridge Workaround in 2.4.18 Causing Video Problems
Message-ID: <20020226202717.A30609@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Tom Eastep <teastep@shorewall.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020226195730.BD7691B93C@mail.shorewall.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020226195730.BD7691B93C@mail.shorewall.net>; from teastep@shorewall.net on Tue, Feb 26, 2002 at 11:57:30AM -0800
X-Uptime: 3:56pm  up 17:20,  1 user,  load average: 1.23, 1.04, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I second this.  Experienced almost exactly the same thing with a
2.4.18-pre2 kernel.  Removing my board from the
arch/i386/kernel/pci-pc.c file (I believe) fixed the problem.

On Tue, Feb 26, 2002 at 11:57:30AM -0800, Tom Eastep wrote:
> 
> 
> [1.] One line summary of the problem:
> 
> The VIA Northbridge workaround in 2.4.18 (arch/i386/kernel/pci-pc.c:pci_fixup_via_northbridge_bug)
> is causing Video Problems on one of my systems.
> 
> [2.] Full description of the problem/report:
> 
> System is an Athlon 1.2GZ with VIA KT133 Northbridge and VT82C686 Southbridge. This is a
> Compaq Presario with onboard S3 Savage Video that uses 8 or 16mb of system RAM as Video
> RAM. Prior to my installing 2.4.18, I have experienced none of the Athlon/VIA problems
> that have plagued other users (including the one addressed by the workaround).
> 
> With 2.4.18:
> 
> a) VGA console goes berserk during boot (random fixed pattern appears and console is unusable).
> b) Vesafb console and X (XF86_FBDEV) -- Heavy memory access (either from CPU or disk activity)
>    produces flicker and horizontal white "noise" on the Display. The amount of flicker and
>    noise is proportional to memory activity.
> 
> I have definitely determined that the problem is with the VIA Workaround as
> the symptoms are eliminated when I disable the workaround (see hack below). 
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> Video VIA Workaround
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.18 (teastep@ursa.shorewall.net) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #2 Tue Feb 26 07:24:29 PST 2002
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
> N/A
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
> N/A
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
> 
> Linux ursa.shorewall.net 2.4.18 #2 Tue Feb 26 07:24:29 PST 2002 i686 unknown
> 
> Gnu C                  2.96
> Gnu make               3.79.1
> util-linux             2.11f
> mount                  2.11g
> modutils               2.4.13
> e2fsprogs              1.23
> PPP                    2.4.1
> isdn4k-utils           3.1pre1
> Linux C Library        2.2.4
> Dynamic linker (ldd)   2.2.4
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.3.3
> Sh-utils               2.0.11
> Modules Loaded         via82cxxx_audio ac97_codec uart401 sound parport_pc lp parport tulip usb-storage nls_iso8859-1 nls_cp437 vfat fat mousedev keybdev hid input usb-uhci usbcore
> 
> [7.2.] Processor information (from /proc/cpuinfo):
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 4
> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 1202.134
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 2398.61
> [7.3.] Module information (from /proc/modules):
> via82cxxx_audio        18048   8 (autoclean)
> ac97_codec              9440   0 (autoclean) [via82cxxx_audio]
> uart401                 6368   0 (autoclean) [via82cxxx_audio]
> sound                  55884   0 (autoclean) [via82cxxx_audio uart401]
> parport_pc             25896   1 (autoclean)
> lp                      6240   0 (autoclean)
> parport                24576   1 (autoclean) [parport_pc lp]
> tulip                  39680   1
> usb-storage            22140   0
> nls_iso8859-1           2816   1 (autoclean)
> nls_cp437               4320   1 (autoclean)
> vfat                    9852   1 (autoclean)
> fat                    31096   0 (autoclean) [vfat]
> mousedev                4128   1
> keybdev                 1856   0 (unused)
> hid                    12992   0 (unused)
> input                   3264   0 [mousedev keybdev hid]
> usb-uhci               21316   0 (unused)
> usbcore                49472   1 [usb-storage hid usb-uhci]
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 0cf8-0cff : PCI conf1
> 1000-10ff : Lite-On Communications Inc LNE100TX
>   1000-10ff : tulip
> 1400-14ff : VIA Technologies, Inc. AC97 Audio Controller
>   1400-14ff : via82cxxx_audio
> 1800-183f : PCTel Inc HSP MicroModem 56
> 1840-185f : VIA Technologies, Inc. UHCI USB
>   1840-185f : usb-uhci
> 1860-187f : VIA Technologies, Inc. UHCI USB (#2)
>   1860-187f : usb-uhci
> 1880-188f : VIA Technologies, Inc. Bus Master IDE
>   1880-1887 : ide0
>   1888-188f : ide1
> 1890-1893 : VIA Technologies, Inc. AC97 Audio Controller
>   1890-1893 : via82cxxx_audio
> 1894-1897 : VIA Technologies, Inc. AC97 Audio Controller
>   1894-1897 : via82cxxx_audio
> ec00-ec0f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> ee00-eeff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
>            CPU0
>   0:     120510          XT-PIC  timer
>   1:          6          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:       4826          XT-PIC  eth0
>   8:          1          XT-PIC  rtc
>   9:          2          XT-PIC  acpi
>  10:       8473          XT-PIC  via82cxxx
>  11:      10879          XT-PIC  usb-uhci, usb-uhci
>  14:      12635          XT-PIC  ide0
>  15:         10          XT-PIC  ide1
> NMI:          0
> ERR:
> [7.5.] PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at 90000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         Memory behind bridge: 80000000-800fffff
>         Prefetchable memory behind bridge: 88000000-8fffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:04.0 Modem: PCTel Inc HSP MicroModem 56 (rev 02) (prog-if 01 [Hayes/16450])
>         Subsystem: PCTel Inc: Unknown device 0001
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at 1800 [size=64]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:05.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
>         Subsystem: Netgear FA310TX
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at 1000 [size=256]
>         Region 1: Memory at a0000000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=256K]
> 
> 00:14.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
> 
> 00:14.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Region 4: I/O ports at 1880 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:14.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66, cache line size 08
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at 1840 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:14.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66, cache line size 08
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at 1860 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:14.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:14.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
>         Subsystem: Compaq Computer Corporation: Unknown device 003d
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin C routed to IRQ 10
>         Region 0: I/O ports at 1400 [size=256]
>         Region 1: I/O ports at 1890 [size=4]
>         Region 2: I/O ports at 1894 [size=4]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8a26 (prog-if 00 [VGA])
>         Subsystem: Compaq Computer Corporation: Unknown device 005b
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (1000ns min, 63750ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 3
>         Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]
>         Region 1: Memory at 88000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [80] AGP version 2.0
>                 Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: COMPAQ   Model: DVD-ROM DRD8120B Rev: 1.10
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: LG       Model: CD-RW CED-8120B  Rev: 1.09
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: Photo Po Model: rt 7700#         Rev:
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 00 Lun: 01
>   Vendor: Photo Po Model: rt 7700#         Rev:
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> [X.] Other notes, patches, fixes, workarounds:
> I'm currently getting around the problem with the following hack:
> 
> diff -u  arch/i386/kernel/pci-pc.orig arch/i386/kernel/pci-pc.c
> --- arch/i386/kernel/pci-pc.orig        Tue Feb 26 07:12:50 2002
> +++ arch/i386/kernel/pci-pc.c   Tue Feb 26 07:24:23 2002
> @@ -1144,7 +1144,7 @@
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5597,          pci_fixup_latency },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5598,          pci_fixup_latency },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371AB_3,  pci_fixup_piix4_acpi },
> -       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_via_northbridge_bug },
> +/*     { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_via_northbridge_bug }, */
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8622,         pci_fixup_via_northbridge_bug },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8361,         pci_fixup_via_northbridge_bug },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8367_0,       pci_fixup_via_northbridge_bug },
> 
> -Tom
> -- 
> Tom Eastep    \ Shorewall - iptables made easy
> AIM: tmeastep  \ http://www.shorewall.net
> ICQ: #60745924  \ teastep@shorewall.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
