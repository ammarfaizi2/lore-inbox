Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313328AbSDYWEH>; Thu, 25 Apr 2002 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313448AbSDYWEG>; Thu, 25 Apr 2002 18:04:06 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:26891 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S313328AbSDYWEF>;
	Thu, 25 Apr 2002 18:04:05 -0400
Date: Fri, 26 Apr 2002 00:04:02 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
Message-ID: <20020425220402.GA3654@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been playing around with one of this machines and trying to get the net
to work seems quite difficult because the driver doesn't want to init the
card well, when you do a modprobe you get this:

riazor:~# modprobe pcnet32
pcnet32_probe_pci: found device 0x001022.0x002000
PCI: Enabling device 00:0c.0 (0140 -> 0143)
    ioaddr=0xbff400  resource_flags=0x000101
/lib/modules/2.4.18/kernel/drivers/net/pcnet32.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters
/lib/modules/2.4.18/kernel/drivers/net/pcnet32.o: insmod
/lib/modules/2.4.18/kernel/drivers/net/pcnet32.o failed
/lib/modules/2.4.18/kernel/drivers/net/pcnet32.o: insmod pcnet32 failed

Sometimes it works, but nearly none do, when it does I get:

pcnet32_probe_pci: found device 0x001022.0x002000
    ioaddr=0xbff400 resource_flags=0x000101
divert: allocating divert_blk for eth0
eth0: PCnet/FAST 79C971 at 0xbff400,csraddr: 00 04 ac 97 51 7e
promaddr:  00 04 ac 97 51 7e
 00 04 ac 97 51 7e
    tx_start_pt(0x0c00):~220 bytes, BCR18(68e2):BurstWrEn BurstRdEn DWordIO NoUFlow
    SRAMSIZE=0x7f00, SRAM_BND=0x4000,
pcnet32: pcnet32_private lp=cee53000 lp_dma_addr=0xee53000 assigned IRQ 22.
pcnet32.c:v1.25kf 17.11.2001 tsbogend@alpha.franken.de

lspci reports this:
00:0c.0 Class 0200: 1022:2000 (rev 26)
00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 26)

I saw a patch for solving this but it is old, so I supposed it should be on
this kernel (2.4.18), but it isn't, so I tried to apply it by hand as it
doesn't work like it is. The resulting code didn't work either, I'll try to
have a deeper look at it and see what I can find, but I think I did the
proper changes acording to the original patch :-(

If anybody has any clue on this I'd appreciate any help.

Thanks in advance!
-- 
Manty/BestiaTester -> http://manty.net
