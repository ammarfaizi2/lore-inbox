Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261237AbRELMfn>; Sat, 12 May 2001 08:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbRELMfY>; Sat, 12 May 2001 08:35:24 -0400
Received: from m2ep.pp.htv.fi ([212.90.64.98]:7694 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S261237AbRELMfT>;
	Sat, 12 May 2001 08:35:19 -0400
Message-ID: <3AFD2E41.213CFB47@tyrell.hu>
Date: Sat, 12 May 2001 15:36:17 +0300
From: Akos Maroy <darkeye@tyrell.hu>
Organization: Tyrell Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Process accessing a Sony DSC-F505V camera through USB as a 
 storage device hangs.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Process accessing a Sony DSC-F505V camera through USB as a storage
device hangs.

[2.] Full description of the problem/report:

I have a Sony DSC-F505V digital camera which comes with a USB interface.
When I connect the camera to the USB port of my PC, at first things seem
to be OK. The camera is recognized as a USB storage device:

kernel: hub.c: USB new device connect on bus1/1, assigned device number
2
kernel: scsi1 : SCSI emulation for USB Mass Storage devices  
kernel:   Vendor: Sony      Model: Sony DSC          Rev: 2.10 
kernel:   Type:   Direct-Access                      ANSI SCSI revision:
02 
kernel: Detected scsi removable disk sdb at scsi1, channel 0, id 0, lun
0
kernel: SCSI device sdb: 126848 512-byte hdwr sectors (65 MB)
kernel: sdb: test WP failed, assume Write Protected
kernel:  sdb: sdb1

I can mount the camera without problems. But when accessing the camera
(e.g. reading the files from it), the process accessing the camera hangs
eventually, and I can't kill it even with kill -9.

The command

ps -eo pid,tt,user,fname,tmout,f,wchan

produces:

 2206 pts/4    root     cp           - 000 wait_on_page

for the process which hangs.

[3.] Keywords (i.e., modules, networking, kernel):

usb, usb-storage

[4.] Kernel version (from /proc/version):

Linux version 2.4.4 (root@destroy) (gcc version 2.96 20000731 (Red Hat
Linux 7.0)) #4 Fri May 11 00:44:33 EEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

There was no oops data in /var/log/messages

[6.] A small shell script or example program which triggers the
     problem (if possible)

mount -r /dev/sdb1 /mnt/mnt
cp -a /mnt/mnt /tmp

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux destroy 2.4.4 #4 Fri May 11 00:44:33 EEST 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
mount                  2.10m
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.20
PPP                    2.3.11
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         NVdriver usb-storage uhci usbcore nls_iso8859-1
nls_cp437 vfat fat

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 0
cpu MHz		: 337.507
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips	: 673.38

[7.3.] Module information (from /proc/modules):

NVdriver              629488  12 (autoclean)
usb-storage            48928   1
uhci                   23680   0 (unused)
usbcore                53008   0 [usb-storage uhci]
nls_iso8859-1           2864   4 (autoclean)
nls_cp437               4384   4 (autoclean)
vfat                    9328   4 (autoclean)
fat                    32160   0 (autoclean) [vfat]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e43f : Ensoniq ES1371 [AudioPCI-97]
  e400-e43f : es1371
e800-e8ff : Adaptec AIC-7881U
ec00-ecff : Standard Microsystems Corp [SMC] 83C170QF
  ec00-ecff : epic100
f000-f00f : Intel Corporation 82371AB PIIX4 IDE


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00217a53 : Kernel code
  00217a54-00286e17 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
e0000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : nVidia Corporation Vanta [NV6]
ea000000-ebffffff : PCI Bus #01
  ea000000-ebffffff : nVidia Corporation Vanta [NV6]
ee000000-ee000fff : Standard Microsystems Corp [SMC] 83C170QF
  ee000000-ee000fff : epic100
ee001000-ee001fff : Adaptec AIC-7881U
  ee001000-ee001fff : aic7xxx
ee002000-ee002fff : Brooktree Corporation Bt878
ee003000-ee003fff : Brooktree Corporation Bt878
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: ea000000-ebffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+
<MAbort+ >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e800 [disabled] [size=256]
	Region 1: Memory at ee001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at ec000000 [disabled] [size=64K]

00:0f.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF
(rev 06)
	Subsystem: Standard Microsystems Corp [SMC] EtherPower II 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 7000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at ed000000 [disabled] [size=64K]

00:11.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
	Subsystem: Avermedia Technologies Inc: Unknown device 0001
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee002000 (32-bit, prefetchable) [size=4K]

00:11.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Avermedia Technologies Inc: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee003000 (32-bit, prefetchable) [size=4K]

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
11) (prog-if 00 [VGA])
	Subsystem: Creative Labs CT6892 RIVA TNT2 Value
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at ea000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at e9000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL ST4.3S  Rev: 0F0C
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Sony     Model: Sony DSC         Rev: 2.10
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/proc/bus/usb/devices:


T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=e000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=054c ProdID=0010 Rev= 2.10
S:  Manufacturer=Sony
S:  Product=Sony DSC
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=ff Prot=01
Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=255ms


Pushing CTRL+SCROLL_LOCK at the console and piping the output to

ksymoops -m /boot/System.map

produces:

ksymoops 2.3.4 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Call Trace: [<f0000000>] [<f0000000>] [<fffb9eff>] [semctl_down+586/592]
[ahc_handle_seqint+368/4224] [get_cmos_time+293/464]
[__dev_get_by_name+28/64] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; fffb9eff <END_OF_CODE+376a5e40/????>

       [<c8890549>] [<cd91e004>] [<cd922318>] [<cd91e004>] [<cd922318>]
[<cd91e004>] [<cd922318>] [<cd922318>] 
       [<cd91e004>] [<c8902f74>] [<c8902f20>] [<cd91e004>] [<c887fbc0>]
[<c88825d6>] [<cd91e004>] [<c88824fd>] 
       [<cd91e004>] [<c8902f20>] [<c887f459>] [handle_IRQ_event+58/112]
[<c8902f20>] [ext2_get_block+44/1264] [ext2_get_block+44/1264]
[ext2_get_block+44/1264] Call Trace: [<f0000000>] [<f0000000>]
[<e14834cc>] [<e0521bc3>] [<e14834cc>] [<e0521bc3>] [<e14834cc>] 
       [<e0521bc3>] [__make_request+298/1680] [__make_request+356/1680]
[__make_request+381/1680] [ext2_get_block+44/1264]
[ide_set_handler+88/96] [do_rw_disk+233/656] [read_intr+0/320] 
       [<c8902f20>] [<cd91e004>] [<c887fbc0>] [bread+24/112]
[build_mmap_avl+117/144] [ext2_read_inode+852/992]
[__alloc_pages+212/704] [do_wp_page+517/560] 
Call Trace: [<f14cc418>] [<e14834cc>] [<e14834cc>] [<e14834cc>]
[<e3a5c1a5>] [__alloc_pages+212/704] [filemap_nopage+294/1056] 
       [<c88824fd>] [<cd91e004>] [<c8902f20>] [ide_multwrite+172/208]
[ide_wait_stat+154/224] [do_rw_disk+461/656] [multwrite_intr+0/176]
[do_IRQ+104/176] 
       [<c88739cf>] [<c8878ce0>] [kernel_thread+38/48] [<c8873920>]
[<c887c18c>] 
Call Trace: [<f4000000>] [<e14834cc>] [<e0521bc3>]
[__alloc_pages_limit+140/176] [__alloc_pages+284/704]
[__alloc_pages_limit+140/176] [__alloc_pages+284/704] 
       [<cd922318>] [<c8902f20>] [<cd91e004>] [<c887fbc0>] [<c88825d6>]
[<cd91e004>] [ext2_getblk+114/288] [<c887f459>] 
Call Trace: [<f0000000>] [<f0000000>] [aic7xxx_setup+166/368]
[vesa_powerdown_screen+14/16] [rs_read_proc+459/1104]
[ahc_suspend+904/1328] [poke_blanked_console+64/112] 
       [<c886b210>] [<cd91e004>] [<c8890549>] [<cd91e004>] [<cd922318>]
[<cd91e004>] [<cd922318>] [<cd91e004>] 
Call Trace: [<f5aac67e>] [<ec835e00>] [<e0397eb6>]
[__make_request+298/1680] [__make_request+356/1680]
[__make_request+381/1680] [ext2_get_block+44/1264] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c8890549 <[NVdriver]UnlockCRTC+15/54>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8902f74 <[NVdriver]TimeStart.22+254/1139f>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c887fbc0 <[NVdriver]nv_post_vblank+24/28>
Trace; c88825d6 <[NVdriver]_nv_rmsym_00547+86/90>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c88824fd <[NVdriver]RmIsr+4d/68>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; c887f459 <[NVdriver]nv_isr+1d/b8>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e0521bc3 <END_OF_CODE+17c0db04/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e0521bc3 <END_OF_CODE+17c0db04/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e0521bc3 <END_OF_CODE+17c0db04/????>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c887fbc0 <[NVdriver]nv_post_vblank+24/28>
Trace; f14cc418 <END_OF_CODE+28bb8359/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e3a5c1a5 <END_OF_CODE+1b1480e6/????>
Trace; c88824fd <[NVdriver]RmIsr+4d/68>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; c88739cf <[usb-storage]usb_stor_control_thread+af/380>
Trace; c8878ce0 <[usb-storage]__module_usb_device_size+1f8/3621>
Trace; f4000000 <END_OF_CODE+2b6ebf41/????>
Trace; e14834cc <END_OF_CODE+18b6f40d/????>
Trace; e0521bc3 <END_OF_CODE+17c0db04/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c887fbc0 <[NVdriver]nv_post_vblank+24/28>
Trace; c88825d6 <[NVdriver]_nv_rmsym_00547+86/90>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; c886b210 <[uhci]uhci_free_td+40/50>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8890549 <[NVdriver]UnlockCRTC+15/54>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; f5aac67e <END_OF_CODE+2d1985bf/????>
Trace; ec835e00 <END_OF_CODE+23f21d41/????>
Trace; e0397eb6 <END_OF_CODE+17a83df7/????>

Call Trace: [<f5aac67e>] [<ec835e00>] [<e0397eb6>]
[ahc_handle_message_phase+92/1728] [cdrom_count_tracks+309/352]
[sock_recvmsg+64/176] [ahc_done+780/944] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; f5aac67e <END_OF_CODE+2d1985bf/????>
Trace; ec835e00 <END_OF_CODE+23f21d41/????>
Trace; e0397eb6 <END_OF_CODE+17a83df7/????>

Call Trace: [<f0000000>] [<f0000000>] [<d4000000>]
[arp_error_report+25/64] [ahc_init+2932/4096] [scsi_ioctl+248/992]
[do_tcp_sendpages+2562/2720] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; d4000000 <END_OF_CODE+b6ebf41/????>

Call Trace: [<f0000000>] [<f0000000>] [<fffb9eff>] [reclaimer+39/224]
[do_tcp_sendpages+2506/2720] [sys_msgrcv+250/800]
[ahc_clear_critical_section+577/784] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; fffb9eff <END_OF_CODE+376a5e40/????>

Call Trace: [<f0000000>] [<f0000000>] [d_instantiate+5/80]
[tcp_close+796/1296] [tcp_sacktag_write_queue+585/1232]
[ext2_new_block+1278/1968] [ahc_setup_initiator_msgout+440/672] 
       [<cd922318>] [<cd91e004>] [<cd922318>] [<cd922318>] [<cd91e004>]
[<c8902f74>] [<c8902f20>] [<cd91e004>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8902f74 <[NVdriver]TimeStart.22+254/1139f>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; cd91e004 <END_OF_CODE+5009f45/????>

Call Trace: [<f0000000>] [<f0000000>] [<fbad0001>] [<fbad0001>]
[ignored_signal+46/64] [send_sig_info+77/160]
[send_sigio_to_task+214/224] 
       [<cd922318>] [<cd91e004>] [<cd922318>] [<cd922318>] [<cd91e004>]
[<c8902f74>] [<c8902f20>] [<cd91e004>] 
       [<c887fbc0>] [<c886d235>] [<c886d1ae>] [process_timeout+0/80]
[timer_bh+531/592] [bh_action+28/96] [tasklet_hi_action+54/96]
[do_softirq+91/128] 
Call Trace: [<f0000000>] [<f0000000>] [<ef800000>] [<fb800000>]
[<ef800000>] [<fffb9eff>] [epic_init_one+388/1344] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; fbad0001 <END_OF_CODE+331bbf42/????>
Trace; fbad0001 <END_OF_CODE+331bbf42/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8902f74 <[NVdriver]TimeStart.22+254/1139f>
Trace; c8902f20 <[NVdriver]TimeStart.22+200/1139f>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c887fbc0 <[NVdriver]nv_post_vblank+24/28>
Trace; c886d235 <[uhci]rh_init_int_timer+75/80>
Trace; c886d1ae <[uhci]rh_int_timer_do+10e/120>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; ef800000 <END_OF_CODE+26eebf41/????>
Trace; fb800000 <END_OF_CODE+32eebf41/????>
Trace; ef800000 <END_OF_CODE+26eebf41/????>
Trace; fffb9eff <END_OF_CODE+376a5e40/????>

       [<cd922318>] [<cd91e004>] [<c8902f74>] [__alloc_pages+212/704]
[handle_mm_fault+154/208] [copy_page_range+233/432]
[do_page_fault+0/1104] [do_page_fault+346/1104] 
Call Trace: [<f0000000>] [<f0000000>] [<ef800000>] [<fb800000>]
[<ef800000>] [mm_init+144/160] [n_tty_ioctl+1151/1200] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; cd922318 <END_OF_CODE+500e259/????>
Trace; cd91e004 <END_OF_CODE+5009f45/????>
Trace; c8902f74 <[NVdriver]TimeStart.22+254/1139f>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; f0000000 <END_OF_CODE+276ebf41/????>
Trace; ef800000 <END_OF_CODE+26eebf41/????>
Trace; fb800000 <END_OF_CODE+32eebf41/????>
Trace; ef800000 <END_OF_CODE+26eebf41/????>


9 warnings issued.  Results may not be reliable.

[X.] Other notes, patches, fixes, workarounds:
