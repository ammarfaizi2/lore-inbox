Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSGQV0e>; Wed, 17 Jul 2002 17:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSGQV0e>; Wed, 17 Jul 2002 17:26:34 -0400
Received: from ip68-100-183-147.nv.nv.cox.net ([68.100.183.147]:9686 "HELO
	ascellatech.com") by vger.kernel.org with SMTP id <S316723AbSGQV0c>;
	Wed, 17 Jul 2002 17:26:32 -0400
Subject: Re: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
From: Amith Varghese <amith@xalan.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Jul 2002 17:29:24 -0400
Message-Id: <1026941364.4547.91.camel@viper>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting similar results, but I haven't tried anyting in 2.4.19
series yet... this is my situation

I am trying to put together a new machine using the promise sx6000
raid card and I am having some problems with getting the OS to
recognize the raid array.  Here are the facts

* dual athlon 1900
* asus a7m266-d motherboard w/ latest bios (A006)
* 1GB RAM
* Realtek RTL-8139 ethernet card
* Promise SX6000

* using 6 120GB western digital HD's
* total array size is 600GB defined as RAID 5
* using the latest bios (Revision 77) for the promise sx6000
* have the OS set to "Other"

The redhat 7.3 doesn't seem to load the i20 block driver on boot and
therefore it can't find any drives when trying to install the OS.  So
what I have done is compiled a new kernel on my other linux machine
that has the i2o support, i2o pci support, and i2o block support.  I
then replaced the vmlinuz file within the boot.img file provided by
redhat.  When I boot the machine it looks promising.  I get the
following messages:

Loading I2O core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software
i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 2 at 49.
i2o: PCI I2O controller at 0xF3000000 size=4194304
I2O: Promise workarounds activated.
i2o/iop0: Installed at IRQ 10
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Reset rejected, trying to clear
i2o/iop0: LCT has 5 entries
i2o/iop0: Configuration dialog desired.
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
  (C) Copyright 1999-2001 Red Hat Software
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2ob: Installing tid 11 device at unit 0
i2o/hda: Max segments 28, queue def 32, byte limit 14336.
i2o/hda: Type 128: 572366MB, 512 byte sectors.
i2o/hda: Maximum sectors/read set 2 256.
Partitition check:
  i2o/hda:

However, it hangs here and does nothing.  I left it on all night and
no change.  Does anyone have any ideas why it might be hanging?  Is
there something else I should try?  Do I need to pass any arguments to
the kernel?  If anyone needs more info I would be glad to give it. 
Any help would be greatly appreciated.

Thanks
Amith  



Viktors Rotanovs <Viktors@Rotanovs.com> wrote in message
news:<linux.kernel.9016512704.20020717045236@Rotanovs.com>...
> Hi,
> 
> I've found numerious reports that Promise SX6000 works fine with
> 2.4.18+ kernels, and tried it with 2.4.18 and 2.4.19-rc1-ac4 kernels
> with i2o support.
> 
> Here are the results:
> 
> 2.4.18: finds controller, but doesn't find disk device on it.
> 2.4.19-rc1-ac4: loads i2o_block and i2o_core fine and doesn't load
> i2o_pci. When I try to load i2o_pci manually, it shows a lot of
> timeouts.
> 
> I seem to have PDC20276 chip (if i'm not mistaken) marked as new
> by Alan Cox.
> 
> OS type on the RAID is set to Other.
> 
> When I try to run original driver Promise's driver instead of i2o on
> 2.4.18, it starts showing SCSI timeouts after some time when working
> under heavy load.
> 
> I use RAID with ReiserFS.
> 
> Thanks for any help and have a nice day!
> 
> Best Wishes,
> Viktors
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/





