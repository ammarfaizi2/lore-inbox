Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTDPIma (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 04:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTDPIma 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 04:42:30 -0400
Received: from [81.16.98.25] ([81.16.98.25]:48949 "ehlo phion.com")
	by vger.kernel.org with ESMTP id S261287AbTDPImR 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 04:42:17 -0400
Message-ID: <3E9D1A2D.1020109@phion.com>
Date: Wed, 16 Apr 2003 10:54:05 +0200
From: Arno Wilhelm <a.wilhelm@phion.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel 2.4.20 crashes when a second isdn channel is opened
 by ibod
X-MIMETrack: Itemize by SMTP Server on gnom/Phion(Release 5.0.6a |January 17, 2001) at
 16.04.2003 10:54:02,
	Serialize by Router on gnom/Phion(Release 5.0.6a |January 17, 2001) at 16.04.2003
 10:54:04,
	Serialize complete at 16.04.2003 10:54:04
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
X-phion-id: 20030416-104654-29443-00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I guess we have detected a kernel bug in the isdn subsystem ( isdn_ppp.c ).
I have enclosed the bug report in this mail in the format that is asked by
the file "REPORTING-BUGS" in the kernel source directory.
If you need further assistance please mail to: a.wilhelm@phion.com



Regards,

			Arno Wilhelm



[1.] One line summary of the problem:

Kernel 2.4.20 crashes when a second isdn channel is opened by ibod (isdn 
bandwith daemon).

[2.] Full description of the problem/report:

After having connected to our internet provider via isdn, the kernel crashes
whenever the ibod daemons succeeds in opening a second isdn channel.
The last human readable messages are:

ippp0: all channels busy - requeuing!
Scheduling in iterrrupt
kernel BUG at sched.c; 564!
invalid operand: 0000

We have compiled a fresh unpatched kernel version 2.4.20 from www.kernel.org in
order to trace down the bug.

I have to say at this point that probably our internet provider does *not*
support channel bundling. So I guess that the second channel get's a new
connection. But I think that should be a reason for the kernel to crash ?
We can reproduce this problem very easily by:
- Starting ipppd and connecting to the provider
- Flood pinging the point to point partner so that ibod opens the second channel.

I will enclose in this mail the full oops message, /var/log/messages, and a
patch thar worked for us.


[3.] Keywords (i.e., modules, networking, kernel):

kernel 2.4.20, all channels busy - requeuing!, kernel BUG at sched.c; 564!,
isdn, ibod, second channel, isdn4k-utils 3.2p1,


[4.] Kernel version (from /proc/version):

cat /proc/version
Linux version 2.4.20 (root@vir) (gcc version 2.96 20000731 (Red Hat Linux 7.1 
2.96-85)) #4 Thu Apr 10 14:41:07 CEST 2003


[5.] Output of Oops.. message (if applicable) with symbolic information resolved 
(see Documentation/oops-tracing.txt)

ippp0: all channels busy - requeuing!
Scheduling in iterrrupt
kernel BUG at sched.c; 564!
invalid operand: 0000

CPU:	0
EIP:	0010:[<c0113cb3>]	Not tainted
EFLAGS:	00010292
eax: 00000018	ebx: c0106df0	ecx: c5a48000	edx: 00000001
esi: c027c000	edi: c027c000	ebp: c027dfdc	esp: c027dfb8
ds: 0018	es: 0018	ss: 0018
Process swapper (pid: 0, stackpage=c027d000)
Stack: c020e2be c027c000 c027c000 00000000 cfd90018 c0100018 c0106df0 c027c000
        c027c000 c0106df0 c0106e9e 00000001 00098800 c0105000 0008e000 c027e708
Call Trace:    [<c0106df0>] [<c0106df0>] [<c0106e9e>] [<c0105000>]

Code: 0f 0b 34 02 b6 e2 20 c0 58 8b 45 e8 c1 e0 05 05 00 6b 29 c0
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
  <0>Rebooting in 120 seconds..

[6.] A small shell script or example program which triggers the problem (if 
possible)

  Use redhat isdn setup.

[7.] Environment

  Not important !

[7.1.] Software (add the output of the ver_linux script here)

 > ./ver_linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux virusnix 2.4.20 #4 Thu Apr 10 14:41:07 CEST 2003 i686 unknown

Gnu C                  2.96
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10f
modutils               2.3.21
e2fsprogs              1.18
reiserfsprogs          3.x.0k-pre7
PPP                    2.4.1
isdn4k-utils           3.2p1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         hisax_fcpcipnp hisax_isac hisax isdn slhc e100


[7.2.] Processor information (from /proc/cpuinfo):

 > cat /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 951.689
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1900.54


[7.3.] Module information (from /proc/modules):

 > cat /proc/modules
hisax_fcpcipnp          7600   0 (unused)
hisax_isac              8400   0 [hisax_fcpcipnp]
hisax                 511440   0 [hisax_fcpcipnp hisax_isac]
isdn                  114256   0 [hisax]
slhc                    4656   0 [isdn]
e100                   52272   1


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

 > cat /proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
   d000-d007 : ide0
   d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. USB
d800-d81f : VIA Technologies, Inc. USB (#2)
dc00-dc1f : AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN
   dc00-dc1f : fcpcipnp
e000-e0ff : PCI device 1050:6692 (Winbond Electronics Corp)
e400-e43f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   e400-e43f : e100
e800-e83f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   e800-e83f : e100

 > cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
   00100000-00208a6e : Kernel code
   00208a6f-002778c3 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : S3 Inc. Savage 4
d8000000-dbffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
dd000000-dd07ffff : S3 Inc. Savage 4
dd080000-dd09ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   dd080000-dd09ffff : e100
dd0a0000-dd0bffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   dd0a0000-dd0bffff : e100
dd0c0000-dd0c0fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   dd0c0000-dd0c0fff : e100
dd0c1000-dd0c1fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   dd0c1000-dd0c1fff : e100
dd0c2000-dd0c201f : AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI 
v2.0 ISDN
dd0c3000-dd0c3fff : PCI device 1050:6692 (Winbond Electronics Corp)
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

 > lspci -vvv

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8 set
         Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0 set
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 set
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 set
         Region 4: I/O ports at d000 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 set, cache line size 08
         Interrupt: pin D routed to IRQ 10
         Region 4: I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 set, cache line size 08
         Interrupt: pin D routed to IRQ 10
         Region 4: I/O ports at d800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 11
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH 
Fritz!PCI v2.0 ISDN (rev 02)
         Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH: Unknown 
device 0e00
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at dd0c2000 (32-bit, non-prefetchable) [size=32]
         Region 1: I/O ports at dc00 [size=32]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI- D1- D2+ PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Network controller: Winbond Electronics Corp W6692 (rev 01)
         Subsystem: Technical Corp.: Unknown device 5678
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 7
         Region 0: Memory at dd0c3000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at e000 [size=256]

00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
         Subsystem: IBM 10/100 Ethernet Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 8 min, 56 max, 32 set, cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at dd0c1000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at e400 [size=64]
         Region 2: Memory at dd080000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
         Subsystem: IBM 10/100 Ethernet Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 8 min, 56 max, 32 set, cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at dd0c0000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at e800 [size=64]
         Region 2: Memory at dd0a0000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 VGA compatible controller: S3 Inc. Savage 4 (rev 06) (prog-if 00 [VGA])
         Subsystem: IBM: Unknown device 01c5
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 4 min, 255 max, 248 set, cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=512K]
         Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME-
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI !

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
	
	
[7.8] Other notes, patches, fixes, workarounds:


Patch that worked around the kernel crash:

----------------------------- snip -----------------------------------

--- isdn_ppp.c  Fri Apr 11 09:03:09 2003
+++ isdn_ppp.c.new  Thu Apr 10 14:37:43 2003
@@ -1174,9 +1174,10 @@

     lp = isdn_net_get_locked_lp(nd);
     if (!lp) {
-       printk(KERN_WARNING "%s: all channels busy - requeuing!\n", netdev->name);
+       printk(KERN_WARNING "isdn_ppp.c:1177: %s: all channels busy - 
requeuing!\n", netdev->name);
         retval = 1;
-       goto unlock;
+       //goto unlock;
+       goto out;
     }
     /* we have our lp locked from now on */

----------------------------- snip -----------------------------------


7.9 Logfile

Apr  9 19:14:06 virusnix kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Apr  9 19:14:06 virusnix kernel: ISDN subsystem Rev: 
1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1 loaded

Apr  9 19:14:06 virusnix kernel: HiSax: Linux Driver for passive ISDN cards
Apr  9 19:14:06 virusnix kernel: HiSax: Version 3.5 (module)
Apr  9 19:14:06 virusnix kernel: HiSax: Layer1 Revision 1.1.4.1
Apr  9 19:14:06 virusnix kernel: HiSax: Layer2 Revision 1.1.4.1
Apr  9 19:14:06 virusnix kernel: HiSax: TeiMgr Revision 1.1.4.1
Apr  9 19:14:06 virusnix kernel: HiSax: Layer3 Revision 1.1.4.1
Apr  9 19:14:06 virusnix kernel: HiSax: LinkLayer Revision 1.1.4.1
Apr  9 19:14:06 virusnix kernel: HiSax: Approval certification valid
Apr  9 19:14:06 virusnix kernel: HiSax: Approved with ELSA Microlink PCI cards
Apr  9 19:14:06 virusnix kernel: HiSax: Approved with Eicon Technology Diva 2.01 
PCI cards
Apr  9 19:14:06 virusnix kernel: HiSax: Approved with Sedlbauer Speedfax + cards
Apr  9 19:14:06 virusnix kernel: HiSax: Approved with HFC-S PCI A based cards
Apr  9 19:14:06 virusnix kernel: hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
Apr  9 19:14:06 virusnix kernel: hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN 
driver v0.0.1
Apr  9 19:14:06 virusnix kernel: HiSax: Card 1 Protocol EDSS1 Id=fcpcipnp0 (0)
Apr  9 19:14:06 virusnix kernel: HiSax: DSS1 Rev. 1.1.4.1
Apr  9 19:14:06 virusnix kernel: HiSax: 2 channels added
Apr  9 19:14:06 virusnix kernel: HiSax: MAX_WAITING_CALLS added
Apr  9 19:14:06 virusnix kernel: PCI: Found IRQ 5 for device 00:09.0
Apr  9 19:14:06 virusnix kernel: PCI: Sharing IRQ 5 with 00:0f.0
Apr  9 19:14:06 virusnix kernel: hisax_fcpcipnp: found adapter Fritz!Card PCI v2 
at 00:09.0
Apr  9 19:14:08 virusnix ipppd[5029]: Found 2 devices: ,
Apr  9 19:14:08 virusnix ipppd[5030]: ipppd i2.2.12 (isdn4linux version of pppd 
by MH) started
Apr  9 19:14:08 virusnix ipppd[5030]: init_unit: 0
Apr  9 19:14:08 virusnix ipppd[5030]: Connect[0]: /dev/ippp0, fd: 7
Apr  9 19:14:08 virusnix ipppd[5030]: init_unit: 1
Apr  9 19:14:08 virusnix ipppd[5030]: Connect[1]: /dev/ippp1, fd: 8
Apr  9 19:14:18 virusnix ibod[5032]: Parameter FILTER reconfigured to 10
Apr  9 19:14:18 virusnix kernel: ippp0: dialing 1 00718918898...
Apr  9 19:14:21 virusnix kernel: isdn_net: ippp0 connected
Apr  9 19:14:21 virusnix ipppd[5030]: Local number: , Remote number: 
00718918898, Type: outgoing
Apr  9 19:14:21 virusnix ipppd[5030]: PHASE_WAIT -> PHASE_ESTABLISHED, ifunit: 
0, linkunit: 0, fd: 7
Apr  9 19:14:21 virusnix ipppd[5030]: Remote message:
Apr  9 19:14:21 virusnix ipppd[5030]: MPPP negotiation, He: No We: No
Apr  9 19:14:21 virusnix ipppd[5030]: CCP enabled! Trying CCP.
Apr  9 19:14:21 virusnix ipppd[5030]: CCP: got ccp-unit 0 for link 0 
(Compression Control Protocol)
Apr  9 19:14:21 virusnix ipppd[5030]: ccp_resetci!
Apr  9 19:14:21 virusnix ipppd[5030]: local  IP address 212.68.32.62
Apr  9 19:14:21 virusnix ipppd[5030]: remote IP address 194.93.78.21
Apr  9 19:14:21 virusnix logger: Started device ippp0 with parameters ippp0 
/dev/ippp0 0 212.68.32.62 194.93.78.21 ippp0
Apr  9 19:16:14 virusnix ibod[5032]: added new link
Apr  9 19:16:14 virusnix kernel: ippp1: dialing 1 00718918898...
Apr  9 19:16:23 virusnix kernel: isdn_net: local hangup ippp1
Apr  9 19:16:23 virusnix kernel: ippp1: Chargesum is 0
Apr  9 19:16:23 virusnix ibod[5032]: added new link
Apr  9 19:16:23 virusnix kernel: ippp1: dialing 1 00718918898...
Apr  9 19:16:32 virusnix kernel: isdn_net: local hangup ippp1
Apr  9 19:16:32 virusnix kernel: ippp1: Chargesum is 0
Apr  9 19:16:32 virusnix ibod[5032]: added new link
Apr  9 19:16:32 virusnix kernel: ippp1: dialing 1 00718918898...
Apr  9 19:16:34 virusnix kernel: isdn_net: ippp1 connected
Apr  9 19:16:34 virusnix ipppd[5030]: Local number: , Remote number: 
00718918898, Type: outgoing
Apr  9 19:16:34 virusnix ipppd[5030]: PHASE_WAIT -> PHASE_ESTABLISHED, ifunit: 
1, linkunit: 1, fd: 8

Apr  9 17:34:29 virusnix syslogd 1.3-3: restart








-- 
Mr Arno Wilhelm
phion Information Technologies GmbH
System Engineer
Eduard-Bodem-Gasse 1
A-6020 Innsbruck
www.phion.com
tel: +43 512 39 45 45
fax: +43 512 39 45 45 20

