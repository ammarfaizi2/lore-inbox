Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUEMXRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUEMXRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUEMXRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:17:03 -0400
Received: from ls413.htnet.hr ([195.29.150.117]:63648 "EHLO ls413.htnet.hr")
	by vger.kernel.org with ESMTP id S265245AbUEMXQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:16:03 -0400
To: <linux-kernel@vger.kernel.org>
Cc: <pavel@ucw.cz>
Subject: ethernet/b44: Bug in b44.c:v0.93 (Mar, 2004) ethernet driver in
 2.6.6
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: ENAMETOOLONG
X-Real-Mail-Base64: PG12ekBuaW1pdW0uY29tPg==
X-Operating-System: GNU/Linux 2.6.5
Mail-Copies-To: never
From: Miroslav Zubcic <mvz@nimium.com>
Date: Fri, 14 May 2004 01:17:46 +0200
Message-ID: <lzekpnlxwl.fsf@nimiumvax.nimium.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: ls413.htnet.hr 1084490161 15916 194.152.194.94 (Fri, 14 May 2004 01:16:01 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

After reading Changelog for 2.6.6, I have seen b44 driver was updated,
and it should support new HP/compaq laptops now. I tried 2.6.6 kernel,
but I have a problem: b44 module does not work(TM).

System info:

Laptop compaq nx5000
kernel 2.6.6
gcc 3.2.3
binutils-2.14.90.0.4
module-init-tools 2.4.26


lspci:

--------------
00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 01)
01:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
01:06.0 CardBus bridge: Texas Instruments: Unknown device ac8e
01:06.1 CardBus bridge: Texas Instruments: Unknown device ac8e
01:06.3 Unknown mass storage controller: Texas Instruments: Unknown device ac8f
01:0d.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
01:0e.0 Ethernet controller: Broadcom Corporation: Unknown device 170c (rev 02)
--------------
Verbose lspci of the last entry:

01:0e.0 Ethernet controller: Broadcom Corporation: Unknown device 170c (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 08bc
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 90080000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
--------------

modprobe b44 and `ip link set dev eth0 up' gives this in dmesg:

--------------
b44.c:v0.93 (Mar, 2004)
PCI: Guessed IRQ 11 for device 0000:01:0e.0
divert: allocating divert_blk for eth0
eth0: Broadcom 4400 10/100BaseT Ethernet 00:08:02:e2:2d:ba
b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to clear.
b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to clear.
b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to clear.
b44: eth0: Link is down.
b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to clear.
b44: eth0: BUG!  Timeout waiting for bit 80000000 of register 428 to clear.
--------------

Host pinging on network timeouts with icmp destination host
unreachable, pinging of my own address (on the nx5000 laptop) works,
lsmod always shows b44 is zero used, even when link is up and local
ping works. It is not possible to ping any other address on the link.
If I remove b44 from kernel eth0 dissapears, even if it has IP address
on it.

loaded modules: rtc and b44 (single user mode). Kernel is vanilla
2.6.6 from kernel.org.

Output from "/sbin/ip addr list" looks perfectly normal BTW. :-\

It works OK with 2.4.21 kernel and bcm4401 driver from broadcom
www site. It does not work with 2.6.5 in any way.


-- 
		Miroslav


