Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264899AbSKEQnq>; Tue, 5 Nov 2002 11:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSKEQnq>; Tue, 5 Nov 2002 11:43:46 -0500
Received: from redrock.inria.fr ([138.96.248.51]:63959 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S264899AbSKEQnk>;
	Tue, 5 Nov 2002 11:43:40 -0500
SCF: #mh/Mailbox/outboxDate: Tue, 5 Nov 2002 16:54:33 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-ac2, Sony PCG-C1MHP and Sonypi
Message-Id: <20021105165433.7c1282fa.Manuel.Serrano@sophia.inria.fr>
References: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr>
	<20021105151540.GB12610@tahoe.alcove-fr>
	<20021105155836.GE12610@tahoe.alcove-fr>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 05 Nov 2002 17:44:25 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The failed commands happen when sonypi tries to access the 0x62
> and 0x66 ports, which are (wrongly) reserved by the keyboard 
> (this is why sonypi cannot reserve them). These registers are
> also used by ACPI 'Embedded Controller'.
Oh yes, really!

Have you read my other bug report where I have mentioned that there is
a problem with ACPI and the keyboard unless I load the USB modules
(just in case you have not read the mail I add it at the end of this
one)? USB just make the problem to go away (may be erroneously).

> You didn't say if you compiled in the ACPI susbystem. Does it
> change something if you do not compile it (in case you did
> previously) or if you do compile it (in case you didn't) ?
Up to now every was compiled as modules. 

If I try to compile ACPI inside the kernel, I got:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre10-ac2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0   -nostdinc -iwithprefix include -DKBUILD_BASENAME=compat  -c -o compat.o compat.c
make[3]: *** No rule to make target `/usr/src/linux-2.4.20-pre10-ac2/drivers/pci/devlist.h', needed by `names.o'.  Stop.
make[3]: Leaving directory `/usr/src/linux-2.4.20-pre10-ac2/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20-pre10-ac2/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre10-ac2/drivers'
make: *** [_dir_drivers] Error 2
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

The Makefile for building the kernel seems to be missing a dependence
(no, no, I have not forgotten to emit "make dep" after configuring the 
kernel :-). As a workaround, I did:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
cd drivers/pci
gcc -o gen-devlist gen-devlist.c
./gen-devlist <pci.ids
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

Apparently, compiling ACPI in the kernel, fixes the problem I have with the
keyboard. I will investigate to test if it also fixes the problem 
with USB and SONYPI. I will tell you this by tomorrow morning.

Many thanks.

-- 
Manuel

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
>From Manuel.Serrano@sophia.inria.fr  Tue Nov  5 09:55:41 2002
Return-Path: <Manuel.Serrano@sophia.inria.fr>
Delivered-To: serrano@localhost.inria.fr
Received: from localhost (localhost.localdomain [127.0.0.1])
	by redrock.inria.fr (Postfix) with ESMTP id 0D9A36744
	for <serrano@localhost>; Tue,  5 Nov 2002 09:55:41 +0100 (CET)
Received: from dream.inria.fr [138.96.75.10]
	by localhost with POP3 (fetchmail-5.9.0)
	for serrano@localhost (single-drop); Tue, 05 Nov 2002 09:55:41 +0100 (CET)
Received: from sophia.inria.fr (sophia.inria.fr [138.96.64.20])
	by dream.inria.fr (8.12.5/8.12.5) with ESMTP id gA590OqG005278
	for <mserrano@dream.inria.fr>; Tue, 5 Nov 2002 10:00:25 +0100
Received: from redrock.inria.fr (redrock.inria.fr [138.96.248.51])
	by sophia.inria.fr (8.12.5/8.12.5) with ESMTP id gA590Mnb024893
	for <Manuel.Serrano@sophia.inria.fr>; Tue, 5 Nov 2002 10:00:24 +0100
Received: by redrock.inria.fr (Postfix, from userid 27081)
	id 1AC0D835F; Tue,  5 Nov 2002 09:54:32 +0100 (CET)
Sender: Manuel.Serrano@sophia.inria.fr
To: linux-kernel@vger.kernel.org, dwmw2@redhat.com,
	andrew.grover@intel.com, ptb@it.uc3m.es
Subject: Problem with ACPI and X windows on a Sony Picturebook PCG-C1MHP
SCF: #mh/Mailbox/outboxDate: Tue, 5 Nov 2002 09:51:45 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Message-Id: <20021105095145.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 05 Nov 2002 09:54:32 +0100
Lines: 413
MIME-Version: 1.0
X-Spam-Status: No, hits=2.4 required=5.0
	tests=DOUBLE_CAPSWORD,PORN_12,PORN_10
	version=2.31
X-Spam-Level: **

Hello there,

Here is the description of the second problem I have when running Linux
on my Sony Picturebook PCG-C1MHP. This time, it concerns the ACPI support.
I have actually two problems with ACPI. Let's start with the first one
(the most important one).

[1.] One line summary of the problem:
=====================================

Accessing ACPI files insert spurious characters in X's windows (such as Xterm,
Emacs, ...)

[2.] Full description of the problem/report:
============================================

ACPI works in the sense that it provides significant and relevant information.
Actually I'm using the following modules:

ospm_thermal (for proc temperature)
ospm_battery (for battery charge level)
ospm_ac_adapter (for checking if we are on/off-line)
ospm_bsmgr (which is, as far as I have understood used by the other modules)

Up to now every thing is fine, loading these modules enable access to
/proc/acpi/XXX/XXX/{status,info} files. Perfect. The problem is that 
reading any of these files has a very cumbersome effect. It seems to
generate interruptions that act as key press. The consequence is that
if simultaneously you access a /proc/acpi/XXXX file and you move the mouse
over an Xterm or an Emacs window, the window is filled out with random
characters! The best way to illustrate the problem is by running a loop
such as:

while : ; do 
  cat /proc/acpi/ac_adapter/0/status
done

and then moving the mouse over and Xterm. Each time we move the mouse, each
time a new random character is displayed. 

In addition to my previous shell loop, I run in another Xterm the following:

while : ; do
  cat /proc/interrupts
done

This last file shows:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
  0:      64839          XT-PIC  timer
  1:        487          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:       4414          XT-PIC  acpi, eth0, Ricoh Co Ltd RL5c475, ALi Audio Accelerator
 12:        993          XT-PIC  PS/2 Mouse
 14:       9315          XT-PIC  ide0
NMI:          0 
ERR:          0
           CPU0       
  0:      64840          XT-PIC  timer
  1:        488          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:       4414          XT-PIC  acpi, eth0, Ricoh Co Ltd RL5c475, ALi Audio Accelerator
 12:        993          XT-PIC  PS/2 Mouse
 14:       9315          XT-PIC  ide0
NMI:          0 
ERR:          0
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

That is, my impression is that each time I access the /proc/acpi/XXX files,
the keyboard interrupt counter is incremented!

Now let's go to the real strange thing. If in addition to the previously
loaded modules (the ones describe in section 7.3 above), I load the two
additional modules: usbcore and usb-ohci the problem totally disappear! 
That is, when loading these two additional modules, accessing the /proc/acpi
files and moving the mouse simultaneously does not introduce spurious
characters anymore!

You could think that, loading the two additional modules is a simple 
workaround... Well actually it is but, loading the two usb modules introduce,
in turn, new problems that I will describe in a next bug report...

[3.] Keywords (i.e., modules, networking, kernel):
==================================================

Sony Picture book, Crusoe, ACPI, Interrupt


[4.] Kernel version (from /proc/version):
=========================================

Linux version 2.4.20-pre10-ac2 (root@owens) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Mon Nov 4 21:12:53 CET 2002

[5.] Output of Oops.. message (if applicable) with symbolic information: 
========================================================================    

NA

[6.] A small shell script or example program which triggers the problem:
========================================================================

while : ; do 
  cat /proc/acpi/ac_adapter/0/status
done

then move the mouse over any window.


[7.] Environment
================

Sony Picturebook PCG-C1MHP, Crusoe TM5800, ide disk IC25N030ATCS04-0
ATA/ATAPI IDE	: IDE PCI Bus Master ALi M5229

[7.1.] Software (add the output of the ver_linux script here):
==============================================================

owens:.../src/linux-2.4.20-rc1> sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux owens 2.4.20-pre10-ac2 #2 Mon Nov 4 21:12:53 CET 2002 i686 Transmeta(tm) Crusoe(tm) Processor TM5800 GenuineTMx86 GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.30-WIP
pcmcia-cs              3.2.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.0.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         trident ac97_codec soundcore ds yenta_socket pcmcia_core 8139too mii ospm_thermal ospm_battery ospm_ac_adapter ospm_busmgr

[7.2.] Processor information (from /proc/cpuinfo):
==================================================

owens:.../src/linux-2.4.20-rc1> cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5800
stepping        : 3
cpu MHz         : 860.154
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1717.04


[7.3.] Module information (from /proc/modules):
===============================================

owens:.../src/linux-2.4.20-rc1> cat /proc/modules 
trident                25556   1 (autoclean)
ac97_codec              9640   0 (autoclean) [trident]
soundcore               3364   3 (autoclean) [trident]
ds                      6152   1
yenta_socket            8864   1
pcmcia_core            33632   0 [ds yenta_socket]
8139too                13480   1 (autoclean)
mii                     2192   0 (autoclean) [8139too]
ospm_thermal            5376   0 (unused)
ospm_battery            5364   0 (unused)
ospm_ac_adapter         1924   0 (unused)
ospm_busmgr            10932   0 [ospm_thermal ospm_battery ospm_ac_adapter]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
===========================================================================

owens:.../src/linux-2.4.20-rc1> cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-017f : Acer Laboratories Inc. [ALi] M5229 IDE
01f0-01ff : Acer Laboratories Inc. [ALi] M5229 IDE
  01f0-01f7 : ide0
0376-0376 : Acer Laboratories Inc. [ALi] M5229 IDE
03c0-03df : vga+
03f6-03f6 : Acer Laboratories Inc. [ALi] M5229 IDE
  03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1400-140f : Acer Laboratories Inc. [ALi] M5229 IDE
1800-18ff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device
  1800-18ff : ALi Audio Accelerator
1c00-1cff : Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller
2000-20ff : PCI device 10cf:2011 (Citicorp TTI)
2400-24ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  2400-24ff : 8139too
2800-28ff : ATI Technologies Inc Radeon Mobility M6 LY
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
8000-803f : Acer Laboratories Inc. [ALi] M7101 PMU
8040-805f : Acer Laboratories Inc. [ALi] M7101 PMU

owens:.../src/linux-2.4.20-rc1> cat /proc/iomem 
00000000-0009afff : System RAM
0009b000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dffff : reserved
000e0000-000e0fff : Acer Laboratories Inc. [ALi] USB 1.1 Controller (#2)
000f0000-000fffff : System ROM
00100000-0eeeffff : System RAM
  00100000-001f662e : Kernel code
  001f662f-002649df : Kernel data
0eef0000-0eefbfff : ACPI Tables
0eefc000-0eefffff : ACPI Non-volatile Storage
0ef00000-0effffff : System RAM
10000000-10000fff : Ricoh Co Ltd RL5c475
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
e8000000-e80fffff : Transmeta Corporation LongRun Northbridge
e8100000-e8100fff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device
e8101000-e8101fff : Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller
e8102000-e81027ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
e8102800-e81028ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e8102800-e81028ff : 8139too
e8103000-e8103fff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
e8104000-e8107fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
e8110000-e811ffff : ATI Technologies Inc Radeon Mobility M6 LY
e8200000-e82fffff : PCI device 10cf:2011 (Citicorp TTI)
f0000000-f7ffffff : ATI Technologies Inc Radeon Mobility M6 LY
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
=============================================

owens:.../src/linux-2.4.20-rc1> sudo lspci -vv

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 02)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 02)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 1800 [size=256]
        Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Modem: Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller (prog-if 00 [Generic])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8101000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1c00 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000 Controller (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8102000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e8104000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0a.0 Multimedia controller: Citicorp TTI: Unknown device 2011
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 2000 [disabled] [size=256]
        Region 1: Memory at e8200000 (32-bit, non-prefetchable) [disabled] [size=1M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 2400 [size=256]
        Region 1: Memory at e8102800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2800 [size=256]
        Region 2: Memory at e8110000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8103000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if a0)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: [virtual] I/O ports at 01f0 [size=16]
        Region 1: [virtual] I/O ports at 03f4
        Region 2: [virtual] I/O ports at 0170 [size=16]
        Region 3: [virtual] I/O ports at 0374
        Region 4: I/O ports at 1400 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 80ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 000e0000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

One more time, many thanks for your help. As I have said in my previous
mails, please let me know if there is something I can do.

--
Manuel Serrano

ps: I have noticed the same problem with all the kernel version I have tried
(2.4.19, 2.4.20pre10, 2.4.20rc1, 2.4.10pre10-ac2)
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

