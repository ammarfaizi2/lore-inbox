Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282928AbRK0UNi>; Tue, 27 Nov 2001 15:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282931AbRK0UNe>; Tue, 27 Nov 2001 15:13:34 -0500
Received: from casbah.gatech.edu ([130.207.165.18]:52111 "EHLO
	casbah.gatech.edu") by vger.kernel.org with ESMTP
	id <S282928AbRK0UNR>; Tue, 27 Nov 2001 15:13:17 -0500
Subject: Re: netgear ga621 / ns83820
From: Rob Myers <rob.myers@gtri.gatech.edu>
To: Jason Holmes <jholmes@psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C03BD1C.93BD8740@psu.edu>
In-Reply-To: <1006876165.12853.22.camel@ransom>  <3C03BD1C.93BD8740@psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 15:14:45 -0500
Message-Id: <1006892085.12853.24.camel@ransom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jason-

thanks for your speedy and helpful response.  the card is now working
with 2.4.16-xfs and the netgear driver.  to be honest i dont know why, i
simply blew away /usr/src/linux and started over.

thanks again

rob.

On Tue, 2001-11-27 at 11:19, Jason Holmes wrote:
> Sure, I have it up using the netgear driver version 1.02 on 2.4.16.  I
> didn't have any problems with compiling the driver against 2.4.16 with
> the same options that you list.  Previous to this it was working fine on
> 2.4.11-pre6.  The only obvious difference I can see is that you are
> using modversions and I am not.
> 
> --
> Jason Holmes
> 
> Rob Myers wrote:
> > 
> > hello
> > 
> > im having trouble with a netgear ga621, which is a fiber gigabit card
> > that uses the ns83820 chipset [1].  currently i am using kernel
> > 2.4.9+XFS and the netgear provided driver.  i would like to switch to
> > 2.4.16, but the netgear driver does not compile.  i presume the problems
> > with that driver are due to the mm changes in 2.4.10.[2]  while the
> > ns83820 driver seems to load properly the card does not seem to be able
> > to communicate with the switch [3].  tcpdump does not show any traffic
> > being recieved by the card.
> > 
> > am i wrong in thinking that the ns83820 driver in 2.4.16 should support
> > this card?
> > 
> > has anyone else had any success making this card work with the netgear
> > driver since 2.4.10?
> > 
> > thanks and any help/education appreciated
> > 
> > rob.
> > 
> > [1] output of lspci:
> > 01:0a.0 Ethernet controller: National Semiconductor Corporation: Unknown
> > device 0022
> >         Subsystem: Netgear: Unknown device 621a
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Interrupt: pin A routed to IRQ 21
> >         Region 0: I/O ports at cc00 [size=256]
> >         Region 1: Memory at feb00000 (32-bit, non-prefetchable)
> > [size=4K]
> >         Expansion ROM at fe800000 [disabled] [size=64K]
> >         Capabilities: [40] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> > PME(D0+,D1+,D2+,D3hot+,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > 
> > [2] netgear driver compilation errors:
> > kgcc -D__KERNEL__ -D__SMP__ -DMODULE -DCLONE -D__NO_VERSION__ -D_DUMP
> > -DSINGLE_PACKET -D_GA621_ -DINTR_HOLDOFF -DMEMMAPPED_IO -D_DBG
> > -DPHY_INTR -DFAILURE_MESSAGES -DSTATISTICS -DASSERTION -DCHECKSUM
> > -DERRDEBUG -O -Wall -I/usr/src/linux/include -g -w  sp.c
> > /usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_fast':
> > In file included from /usr/src/linux/include/linux/highmem.h:5,
> >                  from /usr/src/linux/include/linux/skbuff.h:27,
> >                  from /usr/src/linux/include/linux/netdevice.h:146,
> >                  from nsmtypes.h:22,
> >                  from sp.c:18:
> > /usr/src/linux/include/asm/pgalloc.h:68: `cpu_data_Rsmp_d3b73c3c'
> > undeclared (first use in this function)
> > /usr/src/linux/include/asm/pgalloc.h:68: (Each undeclared identifier is
> > reported only once
> > /usr/src/linux/include/asm/pgalloc.h:68: for each function it appears
> > in.)
> > /usr/src/linux/include/asm/pgalloc.h: In function `free_pgd_fast':
> > /usr/src/linux/include/asm/pgalloc.h:79: `cpu_data_Rsmp_d3b73c3c'
> > undeclared (first use in this function)
> > /usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one_fast':
> > /usr/src/linux/include/asm/pgalloc.h:111: `cpu_data_Rsmp_d3b73c3c'
> > undeclared (first use in this function)
> > /usr/src/linux/include/asm/pgalloc.h: In function `pte_free_fast':
> > /usr/src/linux/include/asm/pgalloc.h:121: `cpu_data_Rsmp_d3b73c3c'
> > undeclared (first use in this function)
> > 
> > [3]ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
> > eth%d: enabling 64 bit PCI.
> > eth1: ns83820.c v0.13: DP83820 00:40:f4:29:e9:ef pciaddr=0xfeb00000
> > irq=21 rev 0x103
> > eth1: link now 1000(?) mbps, full duplex and up.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/


