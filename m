Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318429AbSGSDIP>; Thu, 18 Jul 2002 23:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318431AbSGSDIO>; Thu, 18 Jul 2002 23:08:14 -0400
Received: from ip68-100-183-147.nv.nv.cox.net ([68.100.183.147]:47505 "HELO
	ascellatech.com") by vger.kernel.org with SMTP id <S318429AbSGSDIN>;
	Thu, 18 Jul 2002 23:08:13 -0400
Subject: Re: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
From: Amith Varghese <amith@xalan.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1026966681.4537.119.camel@viper>
References: <1026941364.4547.91.camel@viper> 
	<1026966681.4537.119.camel@viper>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 23:11:07 -0400
Message-Id: <1027048267.4537.185.camel@viper>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I am still having problems booting 2.4.19-rc2-ac2.... I get an APIC
error on CPU0 (and CPU1).  However, I tried 2.4.19-rc2 with my Promise
SX6000 and get a slightly different result than 2.4.18.  It almost looks
like the hard drives attached to the promise sx6000 are being
initialized before it gets to the i2o code and the i2o block driver is
unable to initialize /dev/i2o/hda (but thats a wild guess from my
limited knowledge).  If someone has any ideas, please let me know.

Thanks
Amith

Here is output from dmesg (the important parts - i can provide more if
needed)

PDC20276: IDE controller on PCI bus 03 dev 00
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
PDC20276: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20276: simplex device:  DMA disabled
ide2: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: simplex device:  DMA disabled
ide3: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: IDE controller on PCI bus 03 dev 08
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
PDC20276: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20276: simplex device:  DMA disabled
ide4: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: simplex device:  DMA disabled
ide5: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: IDE controller on PCI bus 03 dev 10
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
PDC20276: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20276: simplex device:  DMA disabled
ide6: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: simplex device:  DMA disabled
ide7: PDC20276 Bus-Master DMA disabled (BIOS)

[snip]

I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 8
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 2 at 49.
i2o: PCI I2O controller at 0xF3000000 size=4194304
I2O: Promise workarounds activated.
I2O: MTRR workaround for Intel i960 processor
i2o/iop0: Installed at IRQ17
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Reset rejected, trying to clear
i2o/iop0: LCT has 5 entries.
i2o/iop0: Configuration dialog desired.
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2ob: Installing tid 11 device at unit 0
i2o/hda: Max segments 28, queue depth 8, byte limit 49152.
i2o/hda: Type 255: 572366MB, 512 byte sectors.
i2o/hda: Maximum sectors/read set to 96.
 i2o/hda:<3>
/dev/i2o/hda error: Device is not ready.
end_request: I/O error, dev 50:00 (i2o block), sector 0

/dev/i2o/hda error: Device is not ready.
end_request: I/O error, dev 50:00 (i2o block), sector 0
 unable to read partition table

[snip]

i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.
i2o_post_wait event completed after timeout.

On Thu, 2002-07-18 at 00:31, Amith Varghese wrote:
> Just for more information... I too have the PDC20276 chip which Alan had
> mentioned in in linux 2.4.19rc1-ac3 changelog as the following:
> 
> o	Newer SX6000 has PDC20276 chips. Handle this	(me)
> 
> I tried 2.4.19rc2 and 2.4.19rc1-ac7 with no success.  I'm willing to try
> and debug this, but i don't have a really good idea how to.  If someone
> can give me some ideas that would be great.
> 
> Thanks
> Amith  
> 
> On Wed, 2002-07-17 at 17:29, Amith Varghese wrote:
> > I'm getting similar results, but I haven't tried anyting in 2.4.19
> > series yet... this is my situation
> > 
> > I am trying to put together a new machine using the promise sx6000
> > raid card and I am having some problems with getting the OS to
> > recognize the raid array.  Here are the facts
> > 
> > * dual athlon 1900
> > * asus a7m266-d motherboard w/ latest bios (A006)
> > * 1GB RAM
> > * Realtek RTL-8139 ethernet card
> > * Promise SX6000
> > 
> > * using 6 120GB western digital HD's
> > * total array size is 600GB defined as RAID 5
> > * using the latest bios (Revision 77) for the promise sx6000
> > * have the OS set to "Other"
> > 
> > The redhat 7.3 doesn't seem to load the i20 block driver on boot and
> > therefore it can't find any drives when trying to install the OS.  So
> > what I have done is compiled a new kernel on my other linux machine
> > that has the i2o support, i2o pci support, and i2o block support.  I
> > then replaced the vmlinuz file within the boot.img file provided by
> > redhat.  When I boot the machine it looks promising.  I get the
> > following messages:
> > 
> > Loading I2O core - (c) Copyright 1999 Red Hat Software
> > Linux I2O PCI support (c) 1999 Red Hat Software
> > i2o: Checking for PCI I2O controllers...
> > i2o: I2O controller on bus 2 at 49.
> > i2o: PCI I2O controller at 0xF3000000 size=4194304
> > I2O: Promise workarounds activated.
> > i2o/iop0: Installed at IRQ 10
> > i2o: 1 I2O controller found and installed.
> > Activating I2O controllers...
> > This may take a few minutes if there are many devices
> > i2o/iop0: Reset rejected, trying to clear
> > i2o/iop0: LCT has 5 entries
> > i2o/iop0: Configuration dialog desired.
> > I2O configuration manager v 0.04.
> >   (C) Copyright 1999 Red Hat Software
> > I2O Block Storage OSM v0.9
> >   (C) Copyright 1999-2001 Red Hat Software
> > i2o_block: Checking for Boot device...
> > i2o_block: Checking for I2O Block devices...
> > i2ob: Installing tid 11 device at unit 0
> > i2o/hda: Max segments 28, queue def 32, byte limit 14336.
> > i2o/hda: Type 128: 572366MB, 512 byte sectors.
> > i2o/hda: Maximum sectors/read set 2 256.
> > Partitition check:
> >   i2o/hda:
> > 
> > However, it hangs here and does nothing.  I left it on all night and
> > no change.  Does anyone have any ideas why it might be hanging?  Is
> > there something else I should try?  Do I need to pass any arguments to
> > the kernel?  If anyone needs more info I would be glad to give it. 
> > Any help would be greatly appreciated.
> > 
> > Thanks
> > Amith  


