Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUIVQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUIVQHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUIVQHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:07:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65028 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266193AbUIVQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:07:09 -0400
Date: Wed, 22 Sep 2004 17:06:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Fwd: [Bug 3441] New: Kernel panic after getting error on inserting pcmcia card and then removing it
Message-ID: <20040922170659.E2347@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm throwing this over the wall to sysfs people (gregkh?) or maybe
people who have been flidding with pci.

At a guess the complete lack of error checking in pci_alloc_child_bus()
isn't helping.  Wha'd'ya mean class_device_register can fail?

----- Forwarded message from bugme-daemon@osdl.org -----

Date: Wed, 22 Sep 2004 08:55:43 -0700
From: bugme-daemon@osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 3441] New: Kernel panic after getting error on inserting pcmcia card and then removing it

http://bugme.osdl.org/show_bug.cgi?id=3441

           Summary: Kernel panic after getting error on inserting pcmcia
                    card and then removing it
    Kernel Version: 2.6.8.1
            Status: NEW
          Severity: high
             Owner: rmk@arm.linux.org.uk
         Submitter: benjamin@voetterle.de


Distribution: Debain GNU/Linux 3.1 (Sarge)

Hardware Environment:
lspci -vvv:

0000:00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
        Subsystem: Fujitsu Limited.: Unknown device 107f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

0000:00:00.1 Multimedia audio controller: Intel Corp. 82440MX AC'97 Audio Controller
        Subsystem: Fujitsu Limited. QSound_SigmaTel Stac97 PCI Audio
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1000 [size=256]
        Region 1: I/O ports at 1400 [size=64]

0000:00:07.0 Bridge: Intel Corp. 82440MX ISA Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Intel Corp. 82440MX EIDE Controller (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1480 [size=16]

0000:00:07.2 USB Controller: Intel Corp. 82440MX USB Universal Host Controller
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 14a0 [size=32]

0000:00:07.3 Bridge: Intel Corp. 82440MX Power Management Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Fujitsu Limited.: Unknown device 1070
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1440 [size=64]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:11.0 Communication controller: Lucent Microelectronics F-1156IV WinModem
(V90, 56KFlex) (rev 01)
        Subsystem: Fujitsu Limited. LB Global LT Modem
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe101000 (32-bit, non-prefetchable) [disabled]
[size=256]
        Region 1: I/O ports at 1490 [disabled] [size=8]
        Region 2: I/O ports at 1800 [disabled] [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:13.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Subsystem: Fujitsu Limited.: Unknown device 10c6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:00:14.0 VGA compatible controller: Trident Microsystems Cyber 9525 (rev 49)
(prog-if 00 [VGA])
        Subsystem: Fujitsu Limited. Lifebook C6155
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
        Region 1: Memory at fe120000 (32-bit, non-prefetchable) [size=128K]
        Region 2: Memory at fe400000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [80] AGP version 1.0
                Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [90] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-




Software Environment:

Linux lfb2131 2.6.8.1 #1 Thu Sep 9 12:37:45 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ipv6 ds apm af_packet yenta_socket pcmcia_core edd
vsxxxaa tsdev mousedev evdev lbtouch ide_cd cdrom rtc unix

Problem Description:

After inserting my com 3crwe154g72 wlan card in the slot when yenta_socket is
loaded i get the following output:

 PCI: 0000:01:00.0: class 1 doesn't match header type 01. Ignoring class. 
Unable to handle kernel NULL pointer dereference at virtual address
00000008 
  printing eip: 
c0191fbb 
*pde = 00000000 
Oops: 0000 [#1] 
PREEMPT 
Modules linked in: ipv6 ds apm af_packet yenta_socket pcmcia_core tsdev
mousedev evdev lbtouch sermouse ide_cd cdrom rtc unix 
CPU:    0 
EIP:    0060:[sysfs_add_file+27/176]    Not tainted 
EIP is at sysfs_add_file+0x1b/0xb0 
eax: 00000000   ebx: cbc5c920   ecx: c03ed208   edx: cbc5c960 
esi: cbc5c8e0   edi: 00000000   ebp: c03b51dc   esp: cb4b7ebc 
ds: 007b   es: 007b   ss: 0068 
Process pccardd (pid: 822, threadinfo=cb4b6000 task=cba8f220) 
: Stack: cbc5c9a8 c020aee9 cbc5c960 cbc5c920 cbc5c8e0 cbfdee40 00000000
c020aa53 
        00000000 c03b51dc c01c69f3 cbc5c958 c03b51dc 00000000 00000000
cb11b400 
        00000000 00000001 00000000 c01c6c98 cbfdee40 cb11b400 00000000
00000001 
Call Trace: 
  [class_device_add+281/304] class_device_add+0x119/0x130 
  [class_device_create_file+35/48] class_device_create_file+0x23/0x30 
  [pci_alloc_child_bus+147/224] pci_alloc_child_bus+0x93/0xe0 
  [pci_scan_bridge+520/592] pci_scan_bridge+0x208/0x250 
  [__crc_atapi_output_bytes+623555/2523336] cb_alloc+0xd6/0xe0
[pcmcia_core] 
  [__crc_atapi_output_bytes+611238/2523336] socket_insert+0xa9/0x150
[pcmcia_core] 
  [__crc_atapi_output_bytes+611997/2523336]
socket_detect_change+0x60/0x90 [pcmcia_core] 
[__crc_atapi_output_bytes+612499/2523336] pccardd+0x1c6/0x230
[pcmcia_core] 
[default_wake_function+0/32] default_wake_function+0x0/0x20 
  [ret_from_fork+6/20] ret_from_fork+0x6/0x14 
  [default_wake_function+0/32] default_wake_function+0x0/0x20 
  [__crc_atapi_output_bytes+612045/2523336] pccardd+0x0/0x230
[pcmcia_core] 
  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18 
Sep 10 14:00:01 localhost kernel: Code: 8b 47 08 8d 48 68 ff 48 68 0f 88
a0 01 00 00 8b 45 00 89 3c 

When i remove my card then i get this:

When i then remove the card from the pcmcia slot, i get the following
kernel panic:

Code: Bad EIP value. 
<0>Kernel panic: Fatal Exception in interrupt 
In interrupt handle - net syncing


Steps to reproduce:
Insert the 3com 3crwe154g72 wlan card when yenta_socket is loaded

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

----- End forwarded message -----

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
