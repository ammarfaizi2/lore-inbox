Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281009AbRK0PsJ>; Tue, 27 Nov 2001 10:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281128AbRK0PsA>; Tue, 27 Nov 2001 10:48:00 -0500
Received: from casbah.gatech.edu ([130.207.165.18]:50844 "EHLO
	casbah.gatech.edu") by vger.kernel.org with ESMTP
	id <S281009AbRK0Prx>; Tue, 27 Nov 2001 10:47:53 -0500
Subject: netgear ga621 / ns83820
From: Rob Myers <rob.myers@gtri.gatech.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 10:49:25 -0500
Message-Id: <1006876165.12853.22.camel@ransom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

im having trouble with a netgear ga621, which is a fiber gigabit card
that uses the ns83820 chipset [1].  currently i am using kernel
2.4.9+XFS and the netgear provided driver.  i would like to switch to
2.4.16, but the netgear driver does not compile.  i presume the problems
with that driver are due to the mm changes in 2.4.10.[2]  while the
ns83820 driver seems to load properly the card does not seem to be able
to communicate with the switch [3].  tcpdump does not show any traffic
being recieved by the card. 

am i wrong in thinking that the ns83820 driver in 2.4.16 should support
this card?

has anyone else had any success making this card work with the netgear
driver since 2.4.10?

thanks and any help/education appreciated

rob.

[1] output of lspci:
01:0a.0 Ethernet controller: National Semiconductor Corporation: Unknown
device 0022
        Subsystem: Netgear: Unknown device 621a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at feb00000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at fe800000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[2] netgear driver compilation errors:
kgcc -D__KERNEL__ -D__SMP__ -DMODULE -DCLONE -D__NO_VERSION__ -D_DUMP
-DSINGLE_PACKET -D_GA621_ -DINTR_HOLDOFF -DMEMMAPPED_IO -D_DBG
-DPHY_INTR -DFAILURE_MESSAGES -DSTATISTICS -DASSERTION -DCHECKSUM
-DERRDEBUG -O -Wall -I/usr/src/linux/include -g -w  sp.c
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_fast':
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from nsmtypes.h:22,
                 from sp.c:18:
/usr/src/linux/include/asm/pgalloc.h:68: `cpu_data_Rsmp_d3b73c3c'
undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h:68: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/pgalloc.h:68: for each function it appears
in.)
/usr/src/linux/include/asm/pgalloc.h: In function `free_pgd_fast':
/usr/src/linux/include/asm/pgalloc.h:79: `cpu_data_Rsmp_d3b73c3c'
undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one_fast':
/usr/src/linux/include/asm/pgalloc.h:111: `cpu_data_Rsmp_d3b73c3c'
undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_free_fast':
/usr/src/linux/include/asm/pgalloc.h:121: `cpu_data_Rsmp_d3b73c3c'
undeclared (first use in this function)

[3]ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
eth%d: enabling 64 bit PCI.
eth1: ns83820.c v0.13: DP83820 00:40:f4:29:e9:ef pciaddr=0xfeb00000
irq=21 rev 0x103
eth1: link now 1000(?) mbps, full duplex and up.



