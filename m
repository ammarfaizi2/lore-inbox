Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbSKQHuj>; Sun, 17 Nov 2002 02:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267464AbSKQHuj>; Sun, 17 Nov 2002 02:50:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50916 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S267457AbSKQHuh>;
	Sun, 17 Nov 2002 02:50:37 -0500
Date: Sun, 17 Nov 2002 08:59:45 +0100
From: ksardem@linux01.gwdg.de
X-Mailer: The Bat! (v1.60q) Personal
Reply-To: ksardem@linux01.gwdg.de
Organization: KKI
X-Priority: 3 (Normal)
Message-ID: <981227431.20021117085945@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: bug in via-rhine network-driver (transmit timed out)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my Linux-PC (Kernel 2.4.19, SuSE 8.1)
has two PCI D-LINK DFE530-TX network card (10/100mbit) using driver via-rhine.o
Sometimes one or both of the interfaces (eth0/eth1) "time out", which means I
cannot send or transmit any more packets on this interface.

When I do a 'dmesg' I get these error-messages:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
eth0: Setting half-duplex based on MII #8 link partner capability of 0021.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
...and so on

or:
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 782d, resetting...
eth1: reset did not complete in 10 ms.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 782d, resetting...
eth1: reset did not complete in 10 ms.
...

I had the same problem with the D-LINK DFE-530TX-cards some time ago
with earlier releases of the 2.4.x-Kernel.
If I do a 'ifconfig eth0/eth1 down', 'rmmod via-rhine' and then
again 'modprove via-rhine' and 'ifconfig up...' it works again but
this is no real solution - I think it's a bug in the driver, isn't it?

This is my version of the via-rhine module:
V_NAME        "via-rhine"
DRV_VERSION     "1.1.14"
DRV_RELDATE     "May-3-2002"

Here are some informations about my system which may be helpful:

/proc/modules:
via-rhine              13612   2
mii                     1232   0 [via-rhine]

/proc/version:
Linux version 2.4.19-my (root@geeko) (gcc version 3.2)

/proc/cpuinfo: 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 349.968
cache size      : 512 KB

/proc/ioports:
e400-e4ff : PCI device 1106:3065
  e400-e4ff : via-rhine
e800-e8ff : PCI device 1106:3065
  e800-e8ff : via-rhine
f000-f00f : PCI device 8086:7111

/proc/iomem:
e2000000-e20000ff : PCI device 1106:3065
  e2000000-e20000ff : via-rhine
e2001000-e20010ff : PCI device 1106:3065
  e2001000-e20010ff : via-rhine

lspci -vvv:
00:09.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at e2001000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at e0000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
 Expansion ROM at e1000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
01:00.0


Thanks for any help.
Bye.

