Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSGIKHS>; Tue, 9 Jul 2002 06:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGIKHR>; Tue, 9 Jul 2002 06:07:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:42987 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313181AbSGIKHQ>; Tue, 9 Jul 2002 06:07:16 -0400
Date: Tue, 9 Jul 2002 12:09:54 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: akpm@zip.com.au, <jgarzik@mandrakesoft.com>,
       <linux-kernel@vger.kernel.org>
Subject: 2.5: smc9194.c + smc-ircc.c: multiple definition of `smc_init'
Message-ID: <Pine.NEB.4.44.0207091203270.20908-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile error in 2.5.25-dj1 (most likely the problem
is also present in 2.5.25):

<--  snip  -->

...
   ld -m elf_i386  -r -o built-in.o slhc.o e100/built-in.o
e1000/built-in.o plip.o rrunner.o sunhme.o sungem.o dgrs.o rcpci.o 3c59x.o
ne2k-pci.o 8390.o pcnet32.o mii.o eepro100.o tlan.o epic100.o sis900.o
yellowfin.o acenic.o natsemi.o ns83820.o fealnx.o tg3.o sk98lin/built-in.o
skfp/built-in.o via-rhine.o starfire.o aironet4500_core.o
aironet4500_card.o aironet4500_proc.o sundance.o hamachi.o Space.o setup.o
net_init.o loopback.o ethertap.o sb1000.o shaper.o hp100.o smc9194.o
3c503.o ne.o ne2.o hp.o hp-plus.o smc-ultra.o smc-mca.o smc-ultra32.o
e2100.o es3210.o lne390.o ne3210.o ppp_generic.o ppp_async.o ppp_synctty.o
ppp_deflate.o bsd_comp.o pppox.o pppoe.o slip.o strip.o dummy.o bonding.o
de600.o de620.o lance.o defxx.o at1700.o 3c501.o 3c507.o 3c523.o sk_mca.o
ibmlana.o 3c527.o 3c509.o 3c515.o eexpress.o eepro.o 8139cp.o 8139too.o
arlan.o arlan-proc.o depca.o ewrk3.o atp.o ni5010.o ni52.o ni65.o 3c505.o
ac3200.o 82596.o lp486e.o eth16i.o eql.o cs89x0.o tun.o dl2k.o
fc/built-in.o appletalk/built-in.o tokenring/built-in.o wan/built-in.o
arcnet/built-in.o pcmcia/built-in.o wireless/built-in.o tulip/built-in.o
hamradio/built-in.o irda/built-in.o
irda/built-in.o: In function `smc_init':
irda/built-in.o(.text.init+0x1624): multiple definition of `smc_init'
smc9194.o(.text.init+0x0): first defined here
ld: Warning: size of symbol `smc_init' changed from 101 to 10 in
irda/built-in.o
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.25-full/drivers/net'

<--  snip  -->


The following shows the files that cause this problem:


<--  snip  -->

drivers/net$ grep -r smc_init *
Space.c:extern int smc_init( struct net_device * );
Space.c:        {smc_init, 0},
Binary file Space.o matches
irda/smc-ircc.c:int __init smc_init(void)
irda/smc-ircc.c:module_init(smc_init);
Binary file irda/smc-ircc.o matches
Binary file irda/built-in.o matches
smc9194.c:int smc_init(struct net_device *dev);
smc9194.c: | smc_init( struct net_device * dev )
smc9194.c:int __init smc_init(struct net_device *dev)
smc9194.c:      devSMC9194.init         = smc_init;
Binary file smc9194.o matches

<--  snip  -->


It seems the solution is to rename one of the two?


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

