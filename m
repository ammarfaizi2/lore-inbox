Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757642AbWK0SPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbWK0SPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758504AbWK0SPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:15:31 -0500
Received: from smtp.cesky-hosting.cz ([89.235.3.16]:45054 "EHLO
	smtp.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S1757642AbWK0SPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:15:30 -0500
Message-ID: <456B2B4B.4050605@thinline.cz>
Date: Mon, 27 Nov 2006 19:15:39 +0100
From: Martin Korous <korous@thinline.cz>
User-Agent: Mail/News 1.5.0.7 (X11/20060925)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sky2, tx timeout
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want report a bug in sky2 driver. Sky2 will shutdown every 5-6 days.
Result is reboot or "rmmod sky2 && modprobe sky2"
I have changed eth0 for eth1 (sky2 is on intranet now) because there is 
smaller traffic, but
sky2 will shutdown again in 5-6 days.
follow some info from logs and about network card

NOTICE: I dont have subscribe LKML, if you want more info from me, 
answer to my e-mail.

regards
Martin Korous

uname -a
Linux archie 2.6.18.2 #1 SMP Tue Nov 14 11:07:47 CET 2006 i686 pentium4 
i386 GNU/Linux

/var/log/syslog
Nov 27 17:25:46 archie kernel: sky2 eth1: tx timeout
Nov 27 17:31:11 archie kernel: sky2 eth1: tx timeout
Nov 27 17:31:31 archie kernel: sky2 eth1: tx timeout
Nov 27 17:34:08 archie kernel: OUTPUT packet died: IN= OUT=eth0 
SRC=10.0.0.18 DST=10.0.0.8 LEN=60 TOS=0x10 PREC=0x00 TTL=64 ID=41315 DF 
PROTO=TCP SPT=43946 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0
Nov 27 17:34:09 archie kernel: OUTPUT packet died: IN= OUT=eth0 
SRC=10.0.0.18 DST=10.0.0.5 LEN=60 TOS=0x10 PREC=0x00 TTL=64 ID=16666 DF 
PROTO=TCP SPT=55772 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0
Nov 27 17:34:14 archie kernel: OUTPUT packet died: IN= OUT=eth0 
SRC=10.0.0.18 DST=10.0.0.8 LEN=60 TOS=0x10 PREC=0x00 TTL=64 ID=41316 DF 
PROTO=TCP SPT=43946 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0

dmesg (time is around shutdown eth1, perhaps)

sky2 eth1: disabling interface
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
sky2 eth1: enabling interface
sky2 eth1: Link is up at 1000 Mbps, full duplex, flow control none
NETDEV WATCHDOG: eth1: transmit timed out
sky2 eth1: tx timeout
sky2 eth1: transmit ring 507 .. 484 report=507 done=507
sky2 hardware hung? flushing
NETDEV WATCHDOG: eth1: transmit timed out
sky2 eth1: tx timeout
sky2 eth1: transmit ring 484 .. 461 report=507 done=507
sky2 status report lost?
NETDEV WATCHDOG: eth1: transmit timed out
sky2 eth1: tx timeout
sky2 eth1: transmit ring 507 .. 484 report=507 done=507
sky2 hardware hung? flushing
sky2 eth1: disabling interface
OUTPUT packet died: IN= OUT=eth0 SRC=10.0.0.18 DST=10.0.0.8 LEN=60 
TOS=0x10 PREC=0x00 TTL=64 ID=41315 DF PROTO=TCP SPT=43946 DPT=22 
WINDOW=5840 RES=0x00 SYN URGP=0
OUTPUT packet died: IN= OUT=eth0 SRC=10.0.0.18 DST=10.0.0.5 LEN=60 
TOS=0x10 PREC=0x00 TTL=64 ID=16666 DF PROTO=TCP SPT=55772 DPT=22 
WINDOW=5840 RES=0x00 SYN URGP=0
OUTPUT packet died: IN= OUT=eth0 SRC=10.0.0.18 DST=10.0.0.8 LEN=60 
TOS=0x10 PREC=0x00 TTL=64 ID=41316 DF PROTO=TCP SPT=43946 DPT=22 
WINDOW=5840 RES=0x00 SYN URGP=0
ACPI: PCI interrupt for device 0000:02:00.0 disabled
PCI: Enabling device 0000:02:00.0 (0140 -> 0143)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v1.5 addr 0xdedfc000 irq 16 Yukon-EC (0xb6) rev 2
sky2 eth1: addr 00:0e:0c:6a:c3:64
sky2 eth1: enabling interface
sky2 eth1: Link is up at 1000 Mbps, full duplex, flow control none

lspci -vvv
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8050 PCI-E 
ASF Gigabit Ethernet Controller (rev 18)
        Subsystem: Intel Corporation Unknown device 3466
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at dedfc000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at cf00 [size=256]
        Expansion ROM at dedc0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 3
                Link: Latency L0s <256ns, L1 unlimited
                Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1

