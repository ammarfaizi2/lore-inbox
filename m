Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSGTQVh>; Sat, 20 Jul 2002 12:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSGTQVh>; Sat, 20 Jul 2002 12:21:37 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:9865 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317435AbSGTQVg>; Sat, 20 Jul 2002 12:21:36 -0400
Date: Sat, 20 Jul 2002 18:20:44 +0200
From: damsnet@free.fr
To: ivangurdiev@linuxfreemail.com, rl@hellgate.ch, ShingChuang@via.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: problem with via-rhine driver and VT6103 chipset
Message-Id: <20020720182044.550f2cf0.damsnet@free.fr>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I would like to report a bug, appearing in kernels 2.4.18 
to 2.4.19-rc3 (I have not tested with previous ones). 

It concerns the VIA-Rhine (ethernet) driver. I use it with
a VT6103 ethernet adaptator, which seems not to be supported
by the driver, but almost works.

When I use this driver in 10Mbps mode (not 100Mbps), it resets the
ethernet card every few seconds and at the ends I have to reboot, 
because the card does not work anymore. These are the messages
I see with repetition:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
[etc, etc, ...]


In 100Mbps mode, everything work perfectly. But the problem appears
all the time in 10Mbps mode. I made many tests, with differents 
motherboards (the card is integrated in it) in different situations, 
and it always appens.

The weird thing is that it only happens when the data go to this 
card, I mean if I copy a file *to* the computer with this card, it 
happens. If I copy a file *from* it (to an other computer), it does
not happen. I tested with ftp (proftpd running on the computer) by 
uploading files, and with scp.

My ethernet card is integrated to the VIA Mini-ITX motherboard, aimed
at embedded systems. The manual says it is a "VIA VT6103 Ethernet PHY".

lspci shows this:

00:12.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 51)
        Subsystem: VIA Technologies, Inc.: Unknown device 0102
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



The processor is:

processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Ezra
stepping        : 8
cpu MHz         : 800.047
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1595.80


I compiled everything into the kernel, no modules support.
I tested with and without MMIO support, and the result is the same.



Thanks in advance,
regards.

Damien
