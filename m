Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbREBIFL>; Wed, 2 May 2001 04:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbREBIEw>; Wed, 2 May 2001 04:04:52 -0400
Received: from ch-12-44-141-183.lcisp.com ([12.44.141.183]:5636 "EHLO
	debian-home") by vger.kernel.org with ESMTP id <S131459AbREBIEi>;
	Wed, 2 May 2001 04:04:38 -0400
Date: Wed, 2 May 2001 03:07:35 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.4 oops, will not boot
Message-ID: <20010502030735.A650@debian-home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please CC on replies.
Attached is REPORTING-BUGS template from source, and a hand copied oops
that I ran through ksymoops. I really hope this is resolved, anything
further needed, just ask.

It's freezing while startup scripts are run, on Debian Sid, it has just
finished clean /var /tmp etc, and is doing one of three things from tail
end of /etc/rcS/S55bootmisc.sh:
1. if [ -c /dev/ttyp0 ]
     then
        chmod 666 /dev/tty[p-za-e][0-9a-f]
	chown root:tty /dev/tty[p-za-e][0-9a-f]
   fi
2. if [ "$EDITMOTD" != no ]
     then
        uname -a > /etc/motd.tmp
	sed 1d /etc/motd >> /etc/motd.tmp
	mv /etc/motd.tmp /etc/motd
   fi
3. dmesg > /var/log/dmesg

It never gets to /etc/rcS/S55urandom: echo -n "Initializing random number generator... "
		
In addition, about 30 seconds after the oops, while I was copying it,
the following printed at bottom of screen:
VM: refill_inactive, wrong page on list



--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=REPORTING-BUGS

[1.] One line summary of the problem:    
2.4.4 oops, will not boot

[2.] Full description of the problem/report:
With 2.4.4 I actually received an oops prior to login, but forgot to hand
copy it, will try to replicate and run through ksymoops.
2.4.4ac2 blanks the screen right after LILO, then absolutely nothing, I
was able to use reset button on computer.

[3.] Keywords (i.e., modules, networking, kernel):
kernel AMD VIA

[4.] Kernel version (from /proc/version):
2.4.4{ac2}
2.2.19 works just fine using it now

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
To follow, assuming I can replicate with 2.4.4 and copy without typos.

[6.] A small shell script or example program which triggers the
     problem (if possible)
     
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Debian Sid
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 801.828
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 1599.07

[7.3.] Module information (from /proc/modules):

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
Obtained under running 2.2.19:
/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
d000-d007 : ide0
88401000-8840101f : Intel Speedo3 Ethernet
/proc/iomem
Non-existant

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
Latency: 8
Region 0: Memory at d0000000 (32-bit, prefetchable)
Capabilities: [a0] AGP version 2.0
Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
Latency: 0
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: d4000000-d5ffffff
Prefetchable memory behind bridge: d6000000-d6ffffff
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
Subsystem: VIA Technologies, Inc. Bus Master IDE
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32
Region 4: I/O ports at d000
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
Subsystem: Unknown device 0925:1234
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32, cache line size 08
Interrupt: pin D routed to IRQ 15
Region 4: I/O ports at d400
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
Subsystem: Unknown device 0925:1234
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32, cache line size 08
Interrupt: pin D routed to IRQ 15
Region 4: I/O ports at d800
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Capabilities: [68] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
Subsystem: VIA Technologies, Inc.: Unknown device 4511
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin C routed to IRQ 5
Region 0: I/O ports at dc00
Region 1: I/O ports at e000
Region 2: I/O ports at e400
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
Subsystem: Intel Corporation EtherExpress PRO/100+
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (2000ns min, 14000ns max), cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at d8100000 (32-bit, prefetchable)
Region 1: I/O ports at e800
Region 2: Memory at d8000000 (32-bit, non-prefetchable)
Capabilities: [dc] Power Management version 1
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: BusLogic Flashpoint LT (rev 02)
Subsystem: BusLogic Flashpoint LT
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (2000ns min, 2000ns max), cache line size 08
Interrupt: pin A routed to IRQ 15
Region 0: I/O ports at ec00
Region 1: Memory at fe00f000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev 03) (prog-if 00 [VGA])
Subsystem: Creative Labs Graphics Blaster CT6710
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (1250ns min, 250ns max)
Interrupt: pin A routed to IRQ 10
Region 0: Memory at d4000000 (32-bit, non-prefetchable)
Region 1: Memory at d6000000 (32-bit, prefetchable)
Capabilities: [60] Power Management version 1
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [44] AGP version 1.0
Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
SCSI is available as a module, but for test purposes I am using only IDE
provided by motherboard UDMA 100 controller on a 40 pin(UDMA 33) cable,
connected to a QUANTUM FIREBALLP LM20.5 as hda. Linux is running from
one single ext2 partition hda1.
Memory is SDRAM PC100 , 2 64MB DIMMS brandname (HP label).
Motherboard is Epox 8KTA3 (without HPT370).
0 USB installed, 0 ISA slots, 0 serial ports used.
Swap is 128MB, same disk, partition hda2.



--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymresult.out"

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.4/ (specified)
     -m /boot/System.map-2.4.4 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000014 printing EIP: c01254b5
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010: [<c01254b5>]
Using defaults from ksymoops -t elf32-i386 -a i386
eflags: 00010013
eax: c1227e08   ebx: c1227e08     ecx: c7e3ff68       edx: 00000000
esi: 00000286   edi: 00000007     ebp: c12343c0       esp: c7e3feec
ds: 0018        es: 0018       ss: 0018
stack: 00000000 c1263080 c12630dc c013ec88 c1277e08 00000007 00000000 c1263080
       c12630dc c12343c0 00000005 c01370c8 c12343c0 c7e3ff68 c7e3ff68 00000000
       c12343c0 c7e3ffa4 c0137819 c12343c0 c7e3ff68 00000000 c1265000 00000000
Code: 8b 42 14 ff 42 10 89 c1 0f af 4b 0c 03 4a 0c 8b 44 82 18 89

>>EIP; c01254b5 <kmem_cache_alloc+15/60>   <=====
Code;  c01254b5 <kmem_cache_alloc+15/60>
00000000 <_EIP>:
Code;  c01254b5 <kmem_cache_alloc+15/60>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c01254b8 <kmem_cache_alloc+18/60>
   3:   ff 42 10                  incl   0x10(%edx)
Code;  c01254bb <kmem_cache_alloc+1b/60>
   6:   89 c1                     mov    %eax,%ecx
Code;  c01254bd <kmem_cache_alloc+1d/60>
   8:   0f af 4b 0c               imul   0xc(%ebx),%ecx
Code;  c01254c1 <kmem_cache_alloc+21/60>
   c:   03 4a 0c                  add    0xc(%edx),%ecx
Code;  c01254c4 <kmem_cache_alloc+24/60>
   f:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax
Code;  c01254c8 <kmem_cache_alloc+28/60>
  13:   89 00                     mov    %eax,(%eax)


--WIyZ46R2i8wDzkSu--
