Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280844AbRKBVgd>; Fri, 2 Nov 2001 16:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280846AbRKBVgY>; Fri, 2 Nov 2001 16:36:24 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:65032 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280844AbRKBVgE>; Fri, 2 Nov 2001 16:36:04 -0500
Date: Fri, 2 Nov 2001 22:35:58 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: possibly incorrect comparisons of jiffies in linux kernel
In-Reply-To: <20011102114833.J746@lynx.no>
Message-ID: <Pine.LNX.4.30.0111022218370.7911-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Andreas Dilger wrote:

[talking about hard freezes of my box after wraparound of the
 jiffie counter]

> AFAIK, in the 2.1 kernel development days there was an audit
> of all users of jiffies so that they properly used (there are macros
> time_before() and time_after() which are supposed to handle jiffies wrap).
> I imagine that if you did a grep on jiffies for the drivers you use, you
> would find that lots of code is again doing "time + foo > jiffies" or
> similar, which is broken for wrap.
>

Well, on a quick inspection of the sources I found 171 files where
jiffies are compared without using time_before() or time_after().
I didn't bother to find out whether or not they actually get the
wraparound wrong. IMHO for ease of audit all of these should use
the macros.
Maybe this audit is a candidate for the CHECKER project?

Unfortunately I currently don't have much time to spend on kernel hacking,
so listing these files is about all I can do.

Tim


Here comes the list. Don't beat me about false positives or false
negatives please, I was quite tired when assembling it. No flamewars were
intended by this post!

net/core/dev.c
net/core/neighbour.c
net/ipv4/arp.c
net/ipv4/route.c
net/ipv4/route.c
net/ipv4/igmp.c
net/ipv4/ip_gre.c
net/ipv4/ipmr.c
net/ipv4/tcp_timer.c
net/ipv4/tcp_ipv4.c
net/ipv4/ipconfig.c
net/ipv4/tcp_minisocks.c
net/decnet/af_decnet.c
net/decnet/dn_dev.c
net/decnet/dn_nsp_out.c
net/decnet/dn_route.c
net/decnet/dn_timer.c
net/econet/af_econet.c
net/sched/sch_generic.c
net/irda/discovery.c
net/irda/irnet/irnet_irda.c
drivers/net/slip.c
drivers/net/ne.c
drivers/net/cs89x0.c
drivers/net/atp.c
drivers/net/eexpress.c
drivers/net/apne.c
drivers/net/hp100.c
drivers/net/wan/sdla_fr.c
drivers/net/wan/sdla_ppp.c
drivers/net/wan/sdla_x25.c
drivers/net/wan/sdla_chdlc.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/lmc/lmc_debug.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/wan/dscc4.c
drivers/net/wan/hdlc.c
drivers/net/wan/sdla_ft1.c
drivers/net/wan/wanpipe_multppp.c
drivers/net/seeq8005.c
drivers/net/3c59x.c
drivers/net/3c523.c
drivers/net/eth16i.c
drivers/net/tokenring/olympic.c
drivers/net/tokenring/lanstreamer.c
drivers/net/hamradio/baycom_par.c
drivers/net/hamradio/baycom_ser_fdx.c
drivers/net/hamradio/mkiss.c
drivers/net/hamradio/soundmodem/sm.c
drivers/net/hamradio/soundmodem/sm_wss.c
drivers/net/hamradio/dmascc.c
drivers/net/hamradio/baycom_epp.c
drivers/net/hamradio/yam.c
drivers/net/shaper.c
drivers/net/es3210.c
drivers/net/oaknet.c
drivers/net/sis900.c
drivers/net/arlan.c
drivers/net/arcnet/arcnet.c
drivers/net/ppp_async.c
drivers/net/aironet4500_core.c
drivers/net/ne2k-pci.c
drivers/net/sb1000.c
drivers/net/dmfe.c
drivers/net/rrunner.c
drivers/net/ariadne2.c
drivers/net/ne2.c
drivers/net/tulip/pnic.c
drivers/net/fc/iph5526.c
drivers/net/pcmcia/3c589_cs.c
drivers/net/pcmcia/pcnet_cs.c
drivers/net/pcmcia/netwave_cs.c
drivers/net/pcmcia/smc91c92_cs.c
drivers/net/pcmcia/wavelan_cs.c
drivers/net/aironet4500_card.c
drivers/net/mac89x0.c
drivers/net/appletalk/cops.c
drivers/block/floppy.c
drivers/block/paride/pseudo.h
drivers/char/lp.c
drivers/char/esp.c
drivers/char/serial.c
drivers/char/tpqic02.c
drivers/char/rtc.c
drivers/char/synclink.c
drivers/char/mxser.c
drivers/char/ip2main.c
drivers/char/ip2/i2lib.c
drivers/char/moxa.c
drivers/char/drm/i810_dma.c
drivers/char/agp/agpgart_be.c
drivers/scsi/eata.c
drivers/scsi/53c7,8xx.c
drivers/scsi/ppa.c
drivers/scsi/eata_generic.h
drivers/scsi/qlogicfc.c
drivers/scsi/BusLogic.c
drivers/scsi/megaraid.c
drivers/scsi/wd7000.c
drivers/scsi/53c7xx.c
drivers/scsi/qlogicfas.c
drivers/scsi/u14-34f.c
drivers/scsi/scsi_obsolete.c
drivers/scsi/gdth_proc.c
drivers/scsi/imm.c
drivers/scsi/mac_scsi.c
drivers/scsi/i91uscsi.c
drivers/scsi/i60uscsi.c
drivers/scsi/sym53c416.c
drivers/scsi/sym53c8xx_defs.h
drivers/scsi/sun3_scsi.c
drivers/scsi/cpqfcTSstructs.h
drivers/scsi/osst.c
drivers/sound/pss.c
drivers/sound/sb_common.c
drivers/sound/ymfpci.c
drivers/sound/vwsnd.c
drivers/cdrom/sonycd535.c
drivers/isdn/isdn_net.c
drivers/isdn/isdn_tty.c
drivers/isdn/eicon/eicon_idi.c
drivers/isdn/eicon/eicon_isa.c
drivers/isdn/tpam/tpam_commands.c
drivers/sbus/char/aurora.c
drivers/ide/ide-cd.c
drivers/ide/ide-features.c
drivers/ide/ide-probe.c
drivers/ide/ide-proc.c
drivers/ide/ide-tape.c
drivers/ide/ide.c
drivers/sgi/char/ds1286.c
drivers/fc4/fc.c
drivers/acorn/net/ether3.c
drivers/usb/usb-uhci.c
drivers/usb/serial/digi_acceleport.c
drivers/usb/serial/keyspan.c
drivers/usb/storage/isd200.c
drivers/tc/zs.c
drivers/atm/iphase.c
drivers/atm/fore200e.c
drivers/pcmcia/i82365.c
drivers/i2c/i2c-algo-bit.c
drivers/i2c/i2c-adap-ite.c
drivers/s390/misc/chandev.c
drivers/media/radio/radio-aimslab.c
drivers/media/video/c-qcam.c
drivers/media/video/w9966.c
drivers/media/video/zr36067.c
drivers/acpi/ospm/processor/prpower.c
drivers/mtd/chips/sharp.c
drivers/mtd/devices/doc1000.c
drivers/md/md.c
drivers/message/fusion/mptscsih.c
drivers/message/i2o/i2o_core.c
arch/i386/kernel/apm.c
arch/i386/kernel/io_apic.c
arch/alpha/kernel/traps.c
arch/alpha/kernel/time.c
arch/mips/jazz/reset.c
arch/mips/baget/vacserial.c
arch/mips/au1000/common/serial.c
arch/ppc/8xx_io/uart.c
arch/ppc/8260_io/uart.c
arch/sparc64/kernel/binfmt_aout32.c
arch/ia64/kernel/irq_ia64.c
arch/ia64/kernel/unaligned.c
arch/cris/drivers/ethernet.c
arch/cris/drivers/ide.c
arch/cris/drivers/serial.c
arch/cris/drivers/usb-host.c

