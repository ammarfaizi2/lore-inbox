Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267660AbRGWUH5>; Mon, 23 Jul 2001 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGWUHr>; Mon, 23 Jul 2001 16:07:47 -0400
Received: from krs-dhcp336.studby.uio.no ([129.240.107.113]:42679 "EHLO
	ilm.nlc.no") by vger.kernel.org with ESMTP id <S267660AbRGWUHe>;
	Mon, 23 Jul 2001 16:07:34 -0400
Date: Mon, 23 Jul 2001 22:07:57 +0200
To: linux-kernel@vger.kernel.org
Subject: 3-order allocation failed
Message-ID: <20010723220757.B22625@ilm.nlc.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
From: =?iso-8859-1?Q?Dagfinn_Ilmari_Manns=E5ker?= <ilmari@ilm.nlc.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

My computer is serving stuff via Apache over an ssh tunnel. Since
2.4.5-ac-something (I thint it was -ac5, not quite sure), I've been getting
lots of these messages in the kernel log (up to 1200/min, less with later
kernels, it seems):

Jul 23 21:06:01 ilm kernel: __alloc_pages: 3-order allocation failed.

This only occurs when there has been considerable traffic (over 200kB/s) for
some time, and only when it's Apache over SSH. I can push >800kB/s for hours
with samba without getting these messages. I haven't tried apache without SSH,
but I'll try that tomoroow.
The data is being served from a 36GB ReiserFS sw-raid0 array on 2 UltraWide
SCSI drives on a Tekram 390F controller.

I'm currently using a RealTek 8139 NIC (8139too driver); but it also occured
with a RealTek 8029 (ne2k-pci).

When this occurs, transfers stall after a few hundred kilobytes (but directory
indices and small documents work just fine), and X programs are unable to
connect to the X server. As soon as I stop the transfers, everything is OK.

Some system information:
Linux version 2.4.7 (ilmari@ilm.nlc.no) (gcc version 2.95.4 20010703
(Debian prerelease)) #2 Sat Jul 21 19:03:00 CEST 2001

Relevant devices:
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at e400 [size=32]

00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
        Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4250ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at db004000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at db005000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Kingston Technologies EtheRx
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at db006000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Related packages:
ii  gcc       2.95.4-4  The GNU C compiler.
ii  libc6     2.2.3-7   GNU C Library: Shared libraries and Timezone data
ii  apache    1.3.20-1  Versatile, high-performance HTTP server
ii  ssh       2.9p2-4   Secure rlogin/rsh/rcp replacement (OpenSSH)
ii  samba     2.2.1a-1  A LanManager like file and printer server for Unix.

-- 
Dagfinn I. Mannsåker
GPG Public Key ID: 0x51ECFAC6
Fingerprint:  48BB A64D CE9B 9A06 65DF  395C D42E CDC4 51EC FAC6

