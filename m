Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUAVUEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUAVUEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:04:53 -0500
Received: from smtp02.web.de ([217.72.192.151]:54293 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264942AbUAVUES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:04:18 -0500
Date: Thu, 22 Jan 2004 21:05:01 +0100
From: Arne Ahrend <aahrend@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6: No hot_UN_plugging of PCMCIA network cards
Message-Id: <20040122210501.40800ea7.aahrend@web.de>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appears to be a problem with unplugging PCMCIA
ethernet cards under 2.6. I have to run ifconfig .. down
manually before removing the card from its socket,
otherwise the system generates unkillable processes,
reconnecting the card later does not work and the
file systems cannot be unmounted properly.

Running ifconfig ethX down manually solves the problem,
but is cumbersome and requires root privileges...


Issue report:
=============
[1.] One line summary of the problem:
     Unplugging PCMCIA network cards under kernel 2.6 requires manual ifconfig ethX down first
     

[2.] Full description of the problem/report:
     Under 2.6 kernels (.0-test5, .0-test11, .0, .1-rc1, .1)
     I need to manually run
	   ifconfig ethX down
     before removing a PCMCIA network card (X=0 in my case, the card
     in question is a 10Mbit Novell 2000 clone). Otherwise
     subsequent calls to /sbin/ifconfig will never return and
     cannot be killed either (-KILL). 

     This is probably some sort of data corruption issue inside the
     kernel, but I do not get any Oopses. (And cannot unmount the filesystems
     properly either, because of unkillable processes keeping them busy.)

     Everything works fine with the 2.4 series (2.4.18, 2.4.2[134]).


[3.] Keywords (i.e., modules, networking, kernel):
     kernel 2.6, hotplug, pcmcia, network


[4.] Kernel version (from /proc/version):
     Linux version 2.6.1 (root@westley) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Mon Jan 19 20:57:12 CET 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
     n/a


[6.] A small shell script or example program which triggers the
     problem (if possible)
     n/a


[7.] Environment
     Five year old laptop, cardbus is a TI-PCI1220, see lspci output below.
     Given the age of the laptop I can probably happily stay with 2.4 for the rest of
     its life time.


[7.1.] Software (add the output of the ver_linux script here)
        sh /usr/src/linux/linux-2.6.1/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux westley 2.6.1 #1 Mon Jan 19 20:57:12 CET 2004 i586 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.13
e2fsprogs              1.34-WIP
pcmcia-cs              3.1.33
PPP                    version
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         pppoe pppox pcnet_cs 8390 crc32 ppp_generic slhc snd_es18xx snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd soundcore uhci_hcd usbcore rtc


remark:
PPP is 2.4.2


[7.2.] Processor information (from /proc/cpuinfo):
       cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 8
model name      : Mobile Pentium MMX
stepping        : 1
cpu MHz         : 267.390
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 528.38


[7.3.] Module information (from /proc/modules):
       Taken after removing the PCMCIA network card without running
       ifconfig ethX down manually before.
cat /proc/modules 
pppoe 14272 0 - Live 0xc8c5e000
pppox 3496 1 pppoe, Live 0xc8c59000
pcnet_cs 17748 1 - Live 0xc8cb6000
8390 10400 1 pcnet_cs, Live 0xc8c84000
crc32 4288 1 8390, Live 0xc8c81000
ppp_generic 25808 2 pppoe,pppox, Live 0xc8c8a000
slhc 7008 1 ppp_generic, Live 0xc8c5b000
snd_es18xx 28644 0 - Live 0xc8c79000
snd_pcm 94884 1 snd_es18xx, Live 0xc8c96000
snd_page_alloc 11268 1 snd_pcm, Live 0xc8c53000
snd_opl3_lib 9728 1 snd_es18xx, Live 0xc8c34000
snd_timer 24580 2 snd_pcm,snd_opl3_lib, Live 0xc8c71000
snd_hwdep 9024 1 snd_opl3_lib, Live 0xc8c30000
snd_mpu401_uart 7200 1 snd_es18xx, Live 0xc8c2d000
snd_rawmidi 23552 1 snd_mpu401_uart, Live 0xc8c1d000
snd 49156 7 snd_es18xx,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi, Live 0xc8c63000
soundcore 8672 1 snd, Live 0xc8c19000
uhci_hcd 31248 0 - Live 0xc8c24000
usbcore 105116 3 uhci_hcd, Live 0xc8c38000
rtc 12504 0 - Live 0xc8c14000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0220-022f : ES18xx
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0800-0807 : ES18xx - CTRL
0cf8-0cff : PCI conf1
1000-103f : 0000:00:07.3
1100-110f : 0000:00:07.1
  1100-1107 : ide0
  1108-110f : ide1
1400-141f : 0000:00:07.3
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
4800-48ff : PCI CardBus #05
4c00-4cff : PCI CardBus #05
f300-f31f : 0000:00:07.2
  f300-f31f : uhci_hcd


cat /proc/iomem   
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000cc000-000ccfff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00263b9e : Kernel code
  00263b9f-002f9ebf : Kernel data
10000000-10000fff : 0000:00:0a.0
  10000000-10000fff : yenta_socket
10001000-10001fff : 0000:00:0a.1
  10001000-10001fff : yenta_socket
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
10c00000-10ffffff : PCI CardBus #05
11000000-113fffff : PCI CardBus #05
a0000000-a0000fff : card services
c0000000-c3ffffff : 0000:00:08.0
  c0000000-c03fffff : vesafb


[7.5.] PCI information ('lspci -vvv' as root)
lspci -vvv
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 1100 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 240
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at f300 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 VGA compatible controller: S3 Inc. ViRGE/MX (rev 06) (prog-if 00 [VGA])
        Subsystem: Unknown device abcd:1100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (1000ns min, 63750ns max)
        Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at 000c0000 [disabled] [size=64K]

00:0a.0 CardBus bridge: Texas Instruments PCI1220 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1220 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001


[7.6.] SCSI information (from /proc/scsi/scsi)
       n/a


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/sbin/ifdown reports eth0 as unconfigured, this is normal,
it also happens under 2.4. The "Hw. address read/write mismap"
messages indicate trouble under 2.6...


/var/log/syslog
===============
Jan 19 22:21:22 westley pppd[880]: Connection terminated.
Jan 19 22:21:22 westley pppd[880]: Connect time 6.0 minutes.
Jan 19 22:21:22 westley pppd[880]: Sent 12425 bytes, received 122043 bytes.
Jan 19 22:21:23 westley pppd[880]: Connect time 6.0 minutes.
Jan 19 22:21:23 westley pppd[880]: Sent 12425 bytes, received 122043 bytes.
Jan 19 22:21:23 westley pppd[880]: Exit.
Jan 19 22:21:34 westley cardmgr[314]: executing: './network stop eth0'
Jan 19 22:21:34 westley cardmgr[314]: + /sbin/ifdown: interface eth0 not configured
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 0
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 1
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 2
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 3
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 4
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 5


/var/log/kern.log
=================
Jan 19 22:08:42 westley kernel: CSLIP: code copyright 1989 Regents of the University of California
Jan 19 22:08:42 westley kernel: PPP generic driver version 2.4.2
Jan 19 22:15:01 westley kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jan 19 22:15:01 westley kernel: eth0: NE2000 Compatible: io 0x320, irq 3, hw_addr 00:E0:98:12:F5:47
Jan 19 22:15:23 westley kernel: NET: Registered protocol family 24
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 0
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 1
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 2
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 3
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 4
Jan 19 22:21:34 westley kernel: Hw. address read/write mismap 5


/var/log/daemon.log
===================
Jan 19 22:20:50 westley pppd[1121]: Plugin /usr/lib/pppd/2.4.2b3/rp-pppoe.so loaded.
Jan 19 22:20:50 westley pppd[1121]: RP-PPPoE plugin version 3.3 compiled against pppd 2.4.2b3
Jan 19 22:21:22 westley pppd[880]: Terminating on signal 2.
Jan 19 22:21:22 westley pppd[880]: Couldn't increase MTU to 1500
Jan 19 22:21:22 westley pppd[880]: Couldn't increase MRU to 1500
Jan 19 22:21:22 westley pppd[880]: Connection terminated.
Jan 19 22:21:22 westley pppd[880]: Connect time 6.0 minutes.
Jan 19 22:21:22 westley pppd[880]: Sent 12425 bytes, received 122043 bytes.
Jan 19 22:21:23 westley pppd[880]: Connect time 6.0 minutes.
Jan 19 22:21:23 westley pppd[880]: Sent 12425 bytes, received 122043 bytes.
Jan 19 22:21:23 westley pppd[880]: Exit.
Jan 19 22:21:34 westley cardmgr[314]: executing: './network stop eth0'
Jan 19 22:21:34 westley cardmgr[314]: + /sbin/ifdown: interface eth0 not configured



[X.] Other notes, patches, fixes, workarounds:
     n/a



