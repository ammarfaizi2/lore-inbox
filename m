Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSFTNvh>; Thu, 20 Jun 2002 09:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSFTNvg>; Thu, 20 Jun 2002 09:51:36 -0400
Received: from euclid.dsl.wisc.edu ([128.104.121.75]:48309 "EHLO
	euclid.dsl.wisc.edu") by vger.kernel.org with ESMTP
	id <S314500AbSFTNvc>; Thu, 20 Jun 2002 09:51:32 -0400
Date: Thu, 20 Jun 2002 08:51:30 -0500
From: Abraham David Smith <abrahamsmith@students.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: machine hangs with journal and tulip error/bug message.
Message-ID: <20020620085130.A12938@euclid.dsl.wisc.edu>
Reply-To: abrahamsmith@students.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Mailer: Mutt 1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the first time I've reported what appears to be a kernel bug,
so I apologize if the information I provide is insufficient or if my
recipient is the wrong person.

The Problem in a nutshell: Machine locks up.  It can be remotely
pinged, but keyboard and mouse show no response.  Kernel message dumps
to screen, pertaining to tulip and journal code.  Has to be reset.

Some Details: 

This has happend only two times so far, withing 24 hours of each
other.  I know of no software operating which was out of the ordinary.
The machine is a Pentium-III 450 running RedHat 7.2.  The filesystem
is ext3, the harddrive controller is a Promise Ultra66.  Most updates
provided by redhat have been applied, the exceptions being the newest
apache packages.  No customiziation to the default redhat kernel has
been done.

here's some more info, which is identical or "close to" (no
intentional changes on my part) the configuration at the time of the
crash:

[root@katie root]# uname -a
Linux katie 2.4.9-34 #1 Sat Jun 1 06:25:16 EDT 2002 i686 unknown

[root@katie root]# lsmod
Module                  Size  Used by    Not tainted
emu10k1                49668   0  (autoclean)
soundcore               4452   4  (autoclean) [emu10k1]
binfmt_misc             6436   1 
tulip                  39328   1 
ide-scsi                8288   0 
scsi_mod               98616   1  [ide-scsi]
ide-cd                 27072   0 
cdrom                  28576   0  [ide-cd]
scanner                 7776   0  (unused)
usb-uhci               21668   0  (unused)
usbcore                51808   1  [scanner usb-uhci]
ext3                   62624   3 
jbd                    41092   3  [ext3]

[root@katie root]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host
bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
	ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: de000000-e1dfffff
        Prefetchable memory behind bridge: e1f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
		PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 05)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at a800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
        PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Unknown mass storage controller: Promise Technology,
Inc. 20262 (rev 01)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a400 [size=8]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9400 [size=4]
        Region 4: I/O ports at 9000 [size=64]
        Region 5: Memory at dd800000 (32-bit, non-prefetchable)
	[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Communication controller: CONEXANT 56K Winmodem (rev 08)
        Subsystem: Diamond Multimedia Systems: Unknown device 0abe
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dd000000 (32-bit, non-prefetchable)
        [size=64K]
        Region 1: I/O ports at 8800 [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
        PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip
21041 [Tulip Pass 3] (rev 21)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
	>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8400 [size=128]
        Region 1: Memory at dc800000 (32-bit, non-prefetchable)
	[size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo
Banshee (rev 03) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Monster Fusion AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at de000000 (32-bit, non-prefetchable)
	[size=32M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at d800 [size=256]
        Expansion ROM at e1ff0000 [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
		PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Finally, what I deem the important part, is the message log at the
time of failure.  Obviosuly the first 20 lines or so are just standard
network traffic, but then....

[root@katie tmp]# tail -f /var/log/messages
Jun 19 17:13:55 katie sshd(pam_unix)[1602]: session closed for user kt
Jun 19 17:15:20 katie su(pam_unix)[1698]: authentication failure; logname=kt uid=500 euid=0 tty= ruser= rhost=  user=root
Jun 19 17:15:30 katie su(pam_unix)[1699]: session opened for user root by kt(uid=500)
Jun 19 17:15:39 katie su(pam_unix)[1699]: session closed for user root
Jun 19 17:15:43 katie su(pam_unix)[1450]: session closed for user root
Jun 19 17:19:09 katie sshd(pam_unix)[1781]: session opened for user root by (uid=0)
Jun 19 17:19:33 katie sshd(pam_unix)[1839]: session opened for user root by (uid=0)
Jun 19 17:21:49 katie sshd(pam_unix)[1923]: session opened for user kt by (uid=0)
Jun 19 17:22:08 katie sshd(pam_unix)[1977]: session opened for user kt by (uid=0)
Jun 19 17:23:14 katie sshd(pam_unix)[1839]: session closed for user root
Jun 19 17:43:34 katie sshd(pam_unix)[2063]: session opened for user root by (uid=0)
Jun 19 17:46:42 katie sshd(pam_unix)[2063]: session closed for user root
Jun 19 17:46:46 katie sshd(pam_unix)[2144]: session opened for user root by (uid=0)
Jun 19 18:14:16 katie sshd(pam_unix)[1977]: session closed for user kt
Jun 19 20:03:12 katie sshd(pam_unix)[1923]: session closed for user kt
Jun 19 20:31:16 katie portsentry[968]: attackalert: SYN/Normal scan from host: ppp-62-123-0-111.dial.ipervia.it/62.123.0.111 to TCP port: 23
Jun 19 22:29:25 katie portsentry[968]: attackalert: SYN/Normal scan from host: 218.55.100.145/218.55.100.145 to TCP port: 21
Jun 19 23:31:07 katie portsentry[968]: attackalert: SYN/Normal scan from host: 203.251.224.254/203.251.224.254 to TCP port: 21

Jun 20 04:02:14 katie syslogd 1.4.1: restart.
Jun 20 05:06:43 katie portsentry[972]: attackalert: UDP scan from host: trigger.doit.wisc.edu/144.92.254.242 to UDP port: 68
Jun 20 07:14:41 katie kernel: hde: timeout waiting for DMA
Jun 20 07:14:41 katie kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Jun 20 07:14:41 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Jun 20 07:14:41 katie kernel: hde: read_intr: status=0x51 { DriveReady SeekComplete Error }
Jun 20 07:14:41 katie kernel: hde: read_intr: error=0x04 { DriveStatusError }
Jun 20 07:14:41 katie kernel: hde: read_intr: status=0x51 { DriveReady SeekComplete Error }
Jun 20 07:14:41 katie kernel: hde: read_intr: error=0x04 { DriveStatusError }
Jun 20 07:14:41 katie kernel: hde: read_intr: status=0x51 { DriveReady SeekComplete Error }
Jun 20 07:14:41 katie kernel: hde: read_intr: error=0x04 { DriveStatusError }
Jun 20 07:14:41 katie kernel: hde: read_intr: status=0x51 { DriveReady SeekComplete Error }
Jun 20 07:14:41 katie kernel: hde: read_intr: error=0x04 { DriveStatusError }
Jun 20 07:14:41 katie kernel: ide2: reset: success
Jun 20 07:14:41 katie kernel: hde: lost interrupt
Jun 20 07:15:01 katie kernel: hde: irq timeout: status=0x80 { Busy }
Jun 20 07:15:01 katie kernel: ide2: reset: success
Jun 20 07:15:01 katie kernel: hde: lost interrupt
Jun 20 07:15:01 katie kernel: hde: irq timeout: status=0x80 { Busy }
Jun 20 07:15:01 katie kernel: ide2: reset: success
Jun 20 07:15:01 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Jun 20 07:15:01 katie kernel: hde: timeout waiting for DMA
Jun 20 07:15:01 katie kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Jun 20 07:15:01 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Message from syslogd@katie at Thu Jun 20 07:15:26 2002 ...
katie kernel: Assertion failure in __journal_remove_journal_head() at journal.c:1634: "buffer_jbd(bh)"
Jun 20 07:15:01 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Jun 20 07:15:26 katie kernel: attempt to access beyond end of device
Jun 20 07:15:26 katie kernel: 21:08: rw=1, want=2047081284, limit=22917352
Jun 20 07:15:26 katie kernel: attempt to access beyond end of device
Jun 20 07:15:26 katie kernel: 21:08: rw=1, want=2047080964, limit=22917352
Jun 20 07:15:26 katie kernel: attempt to access beyond end of device
Jun 20 07:15:26 katie kernel: 21:08: rw=1, want=2047080964, limit=22917352
Jun 20 07:15:26 katie kernel: Assertion failure in __journal_remove_journal_head() at journal.c:1634: "buffer_jbd(bh)"
Jun 20 07:15:26 katie kernel: ------------[ cut here ]------------
Jun 20 07:15:26 katie kernel: kernel BUG at journal.c:1634!
Jun 20 07:15:26 katie kernel: invalid operand: 0000
Jun 20 07:15:26 katie kernel: Kernel 2.4.9-34
Jun 20 07:15:26 katie kernel: CPU:    0
Jun 20 07:15:26 katie kernel: EIP:    0010:[tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-587847/96]    Not tainted
Jun 20 07:15:26 katie kernel: EIP:    0010:[<d08067b9>]    Not tainted
Jun 20 07:15:26 katie kernel: EFLAGS: 00010296
Jun 20 07:15:26 katie kernel: EIP is at journal_blocks_per_page_R14f9ec43 [jbd] 0x3c9 
Jun 20 07:15:26 katie kernel: eax: 0000001e   ebx: cf2d9720   ecx: 00000001   edx: 00002704
Jun 20 07:15:26 katie kernel: esi: cbe3fe50   edi: cf2d9720   ebp: ce49df20   esp: cee81e5c
Jun 20 07:15:26 katie kernel: ds: 0018   es: 0018   ss: 0018
Jun 20 07:15:26 katie kernel: Process kjournald (pid: 209, stackpage=cee81000)
Jun 20 07:15:26 katie kernel: Stack: d08096af 00000662 cf2d9720 cbe3fe50 d080688a cf2d9720 00000009 d0802b48 
Jun 20 07:15:26 katie kernel:        cbe3fe50 c17bbae4 00000000 00000fac c3fcf054 00000000 ce49df20 cdc5ae60 
Jun 20 07:15:26 katie kernel:        cbe3fe50 00000282 00000282 00000001 c02b62a8 cf2d9ae0 cf2d9ea0 cf2d9960
Jun 20 07:15:26 katie kernel: Call Trace: [tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-575825/96] __insmod_jbd_S.rodata_L96 [jbd] 0x2a8f 
Jun 20 07:15:26 katie kernel: Call Trace: [<d08096af>] __insmod_jbd_S.rodata_L96 [jbd] 0x2a8f 
Jun 20 07:15:26 katie kernel: [tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-587638/96] journal_blocks_per_page_R14f9ec43 [jbd] 0x49a 
Jun 20 07:15:26 katie kernel: [<d080688a>] journal_blocks_per_page_R14f9ec43 [jbd] 0x49a 
Jun 20 07:15:26 katie kernel: [tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-603320/96] journal_flushpage_R40b21025 [jbd] 0xd08 
Jun 20 07:15:26 katie kernel: [<d0802b48>] journal_flushpage_R40b21025 [jbd] 0xd08 
Jun 20 07:15:26 katie kernel: [schedule+612/960] schedule [kernel] 0x264 
Jun 20 07:15:26 katie kernel: [<c01150f4>] schedule [kernel] 0x264 
Jun 20 07:15:26 katie kernel: [tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-594266/96] journal_revoke_R67623458 [jbd] 0x606 
Jun 20 07:15:26 katie kernel: [<d0804ea6>] journal_revoke_R67623458 [jbd] 0x606 
Jun 20 07:15:26 katie kernel: [tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-594576/96] journal_revoke_R67623458 [jbd] 0x4d0 
Jun 20 07:15:26 katie kernel: [<d0804d70>] journal_revoke_R67623458 [jbd] 0x4d0 
Jun 20 07:15:26 katie kernel: [kernel_thread+38/48] kernel_thread [kernel] 0x26 
Jun 20 07:15:26 katie kernel: [<c0105726>] kernel_thread [kernel] 0x26 
Jun 20 07:15:26 katie kernel: [tulip:__insmod_tulip_O/lib/modules/2.4.9-34/kernel/drivers/net/tu+-594544/96] journal_revoke_R67623458 [jbd] 0x4f0 
Jun 20 07:15:26 katie kernel: [<d0804d90>] journal_revoke_R67623458 [jbd] 0x4f0 
Jun 20 07:15:26 katie kernel: 
Jun 20 07:15:26 katie kernel: 
Jun 20 07:15:26 katie kernel: Code: 0f 0b 58 5a 39 1e 74 34 68 d5 98 80 d0 68 63 06 00 00 68 af 
Jun 20 07:20:20 katie kernel:  hde: timeout waiting for DMA
Jun 20 07:20:20 katie kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Jun 20 07:20:20 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Jun 20 07:20:20 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Jun 20 07:34:45 katie kernel: hde: timeout waiting for DMA
Jun 20 07:34:45 katie kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Jun 20 07:34:45 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb (mask 0xffffffff)
Jun 20 08:03:19 katie login(pam_unix)[1006]: session opened for user kt by LOGIN(uid=0)
Jun 20 08:03:19 katie  -- kt[1006]: LOGIN ON tty5 BY kt
Read from remote host katie: Connection reset by peer






thanks for your help!
please let me know if you require any other information.

-abe

-- 
# Abraham David Smith, UW--Madison Mathematics/Physics Undergraduate #
# <abrahamsmith@wisc.edu>  Y!:abrahamdavidsmith  AOL-IM:abrahamsmith #

