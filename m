Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTBJXjT>; Mon, 10 Feb 2003 18:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTBJXjT>; Mon, 10 Feb 2003 18:39:19 -0500
Received: from hermes.epita.fr ([163.5.255.10]:38100 "EHLO epita.fr")
	by vger.kernel.org with ESMTP id <S265675AbTBJXjS>;
	Mon, 10 Feb 2003 18:39:18 -0500
Date: Tue, 11 Feb 2003 00:47:12 +0100
From: Nicolas Baradakis <nicolas.baradakis@prologin.org>
To: linux-kernel@vger.kernel.org
Subject: Incompatibility between 'Local APIC' and '8139too'
Message-ID: <20030210234712.GA10979@prologin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
-------

Activating the option 'Local APIC support on uniprocessors' prevents
the network device '8139too' from transmitting any packet.


Full description
----------------

In a  kernel 2.4.20  compiled with the  option 'Local APIC  support on
uniprocessors' I  can successfully load  the module '8139too'  but the
network device doesn't work at all, I can't even do a single ping.

I also see numerous times messages like :

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

The  workaround is  to boot  the kernel  with the  option  'noapic' or
recompile it  without the  option 'Local APIC',  and then  the network
device works perfectly.


Kernel version
--------------

Linux version 2.4.20 (nico@kurumi) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Feb 10 03:27:37 CET 2003
>From the debian package 'kernel-source-2.4.20_2.4.20-5_all.deb'.


Messages from syslog
--------------------

Feb 10 23:14:01 kurumi kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb 10 23:14:01 kurumi kernel: eth0: Tx queue start entry 4  dirty entry 0.
Feb 10 23:14:01 kurumi kernel: eth0:  Tx descriptor 0 is 00002000. (queue head)
Feb 10 23:14:01 kurumi kernel: eth0:  Tx descriptor 1 is 00002000.
Feb 10 23:14:01 kurumi kernel: eth0:  Tx descriptor 2 is 00002000.
Feb 10 23:14:01 kurumi kernel: eth0:  Tx descriptor 3 is 00002000.
Feb 10 23:14:01 kurumi kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.


Network device
--------------

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e3005000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


CPU info
--------

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 7
cpu MHz         : 2019.922
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4023.91


-- 
Nicolas Baradakis
