Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270009AbVBETsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbVBETsu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270117AbVBETst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:48:49 -0500
Received: from vsmtp1.tin.it ([212.216.176.141]:12982 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S273738AbVBETnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:43:16 -0500
From: Andrea Merello <andreamrl@tiscali.it>
Reply-To: andreamrl@tiscali.it
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops - 2.6.10 - USB/SCSI
Date: Sat, 5 Feb 2005 20:43:38 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502052043.38890.andreamrl@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was writing a DVD trought USB/IDE adapter box. Writing crashes.. after a lot 
of kill -9 and a copule of cable unplug/plug I run dmesg and discovered oops

the command run was
[root@bloodymary dvd+rw-tools-5.21.4.10.8]# ./growisofs -Z /dev/scd0 
-JrU /home/user/mp3_lutz2/


sb 1-1: USB disconnect, address 5
slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free all 
objects
 [<c0144c68>] kmem_cache_destroy+0xd8/0x130
 [<c02d9b72>] scsi_destroy_command_freelist+0x62/0x90
 [<c02daa42>] scsi_host_dev_release+0x32/0xa0
 [<c02a5399>] device_release+0x19/0x60
 [<c0118a10>] default_wake_function+0x0/0x20
 [<c022a0d8>] kobject_cleanup+0x98/0xa0
 [<c022a0e0>] kobject_release+0x0/0x10
 [<c022abe9>] kref_put+0x39/0xa0
 [<c022a10e>] kobject_put+0x1e/0x30
 [<c022a0e0>] kobject_release+0x0/0x10
 [<c0335b58>] usb_stor_release_resources+0x68/0xf0
 [<c033603c>] storage_disconnect+0x9c/0xa9
 [<c03179a6>] usb_unbind_interface+0x86/0x90
 [<c02a69c6>] device_release_driver+0x86/0x90
 [<c02a6c77>] bus_remove_device+0x87/0xd0
 [<c02a588c>] device_del+0x6c/0xb0
 [<c031f168>] usb_disable_device+0xb8/0x100
 [<c031a088>] usb_disconnect+0xc8/0x180
 [<c031b3ef>] hub_port_connect_change+0x3ef/0x420
 [<c0318c97>] clear_port_feature+0x57/0x60
 [<c031b6c2>] hub_events+0x2a2/0x3f0
 [<c031b845>] hub_thread+0x35/0x130
 [<c0130d00>] autoremove_wake_function+0x0/0x60
 [<c01030f2>] ret_from_fork+0x6/0x14
 [<c0130d00>] autoremove_wake_function+0x0/0x60
 [<c031b810>] hub_thread+0x0/0x130
 [<c01012e5>] kernel_thread_helper+0x5/0x10
usb 1-1: new high speed USB device using ehci_hcd and address 6
kmem_cache_create: duplicate cache scsi_cmd_cache
------------[ cut here ]------------
kernel BUG at mm/slab.c:1445!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: sr_mod
CPU:    0
EIP:    0060:[<c0144800>]    Not tainted VLI
EFLAGS: 00010202   (2.6.10)
EIP is at kmem_cache_create+0x410/0x590
eax: 00000032   ebx: df40e0f0   ecx: c04b11ec   edx: c04b11ec
esi: c04658b6   edi: c04658b6   ebp: cf587f80   esp: c15dfd14
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 128, threadinfo=c15df000 task=c15dea60)
Stack: c044b1c0 c04658a7 00000040 00002000 c15dfd48 cf587fbc c0333e5d ffffffff
       01baff85 00000409 000000c0 00000246 ffffffc0 000000c0 c0500e00 deacd000
       deacd00c c05048a0 c02d9a80 c04658a7 00000180 00000040 00002000 00000000
Call Trace:
 [<c0333e5d>] usb_stor_msg_common+0x14d/0x180
 [<c02d9a80>] scsi_setup_command_freelist+0x80/0x110
 [<c02dac4d>] scsi_host_alloc+0x19d/0x2c0
 [<c0334a87>] usb_stor_Bulk_max_lun+0x57/0xa0
 [<c0335a53>] usb_stor_acquire_resources+0x93/0x130
 [<c0335f14>] storage_probe+0x134/0x1c0
 [<c0193cee>] sysfs_add_file+0x6e/0xa0
 [<c0317902>] usb_probe_interface+0x72/0x90
 [<c02a67bf>] driver_probe_device+0x2f/0x80
 [<c02a684f>] device_attach+0x3f/0xa0
 [<c022a02a>] kobject_get+0x1a/0x30
 [<c02a6b99>] bus_add_device+0x79/0xd0
 [<c02a9b4f>] device_pm_add+0x6f/0xb0
 [<c02a5716>] device_add+0xc6/0x150
 [<c031f863>] usb_set_configuration+0x303/0x470
 [<c031a2c4>] usb_new_device+0xb4/0x150
 [<c031b25b>] hub_port_connect_change+0x25b/0x420
 [<c031b6c2>] hub_events+0x2a2/0x3f0
 [<c031b845>] hub_thread+0x35/0x130
 [<c0130d00>] autoremove_wake_function+0x0/0x60
 [<c01030f2>] ret_from_fork+0x6/0x14
 [<c0130d00>] autoremove_wake_function+0x0/0x60
 [<c031b810>] hub_thread+0x0/0x130
 [<c01012e5>] kernel_thread_helper+0x5/0x10
Code: 04 00 74 ec e9 8b 01 00 00 89 f6 c7 04 24 c0 b1 44 c0 8b 4c 24 4c 89 4c 
24 04 e8 fc 7c fd ff ff 05 c8 18 5d c0 0f 8e 5f 18 00 00 <0f> 0b a5 05 bd a9 
44 c0 8b 0b e9 6b ff ff ff 90 c7 04 24 00 b2



Other infos:

[root@bloodymary dvd+rw-tools-5.21.4.10.8]# uname -r
2.6.10
[root@bloodymary dvd+rw-tools-5.21.4.10.8]#

cat /proc/scsi/scsi
Attached devices:
[root@bloodymary dvd+rw-tools-5.21.4.10.8]#


[root@bloodymary dvd+rw-tools-5.21.4.10.8]# lsmod
Module                  Size  Used by
sr_mod                 14304  0
[root@bloodymary dvd+rw-tools-5.21.4.10.8]#


[root@bloodymary dvd+rw-tools-5.21.4.10.8]# lspci -vvv
00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] #09 [a105]

00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control 
Registers (rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration Process 
Registers (rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics 
Device (rev 02) (prog-if 00 [VGA])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at 1800 [size=8]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device 
(rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e0080000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1820 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1860 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 
03) (prog-if 20 [EHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at e0100000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0200000-e02fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1810 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio 
Controller (rev 03)
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at e0100c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at e0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03) 
(prog-if 00 [Generic])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61) (prog-if 
10 [OHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (3000ns min, 6000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0202000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Unknown device 17c0:1082
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0200000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:06.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI 
Adapter (rev 04)
        Subsystem: Intel Corp.: Unknown device 2527
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0203000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:09.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

[root@bloodymary dvd+rw-tools-5.21.4.10.8]#


Regards
Andrea
