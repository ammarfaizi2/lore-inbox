Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUIAE4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUIAE4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUIAE4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:56:42 -0400
Received: from warcloud.net ([216.254.102.229]:16562 "EHLO www.warcloud.net")
	by vger.kernel.org with ESMTP id S267380AbUIAE4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:56:36 -0400
Date: Wed, 1 Sep 2004 00:56:34 -0400 (EDT)
From: Matt <odinson@warcloud.net>
To: linux-kernel@vger.kernel.org
Subject: Promise SX-6000 Pro on 2.6.8.1
Message-ID: <Pine.LNX.4.21.0408312351250.13904-100000@www.warcloud.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

	I have recently attempted to upgrade my kernel from 2.4.20 with
the cryptography patches to 2.6.8.1.  My promise card as addressed by the
i2o device does not seem to get set up correctly during boot or respond
once initialized.  This card was working fine before the upgrade.

I use the following statement in my lilo.conf, as probing the resulting
raid drive, removing it seems to have no effect on the 2.6 outcome. 

append="hde=noprobe hdf=noprobe hdg=noprobe hdh=noprobe hdi=noprobe
hdj=noprobe hdc=ide-scsi"

lspci and cat /proc/pci (I compiled that in too.) reveal nothing about the
card.

dmesg from boot says...

input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 299
i2o: Checking for PCI I2O controllers...
PCI: Found IRQ 12 for device 0000:00:0b.1
PCI: Sharing IRQ 12 with 0000:00:02.1
i2o: I2O controller on bus 0 at 89.
I2O: Promise workarounds activated.
i2o: PCI I2O controller at CD800000 size=4194304
i2o/iop0: Installed at IRQ12
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Reset rejected, trying to clear
i2o/iop0: SysTab setup timed out.
i2o/iop0: Get status timeout.
i2o/iop0: Get status timeout.
IOP reset timeout.
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ d7dbd8a0
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
md: raid1 personality registered as nr 3

I included the surrounding lines for context.  The pertinant lines seem to
be;

i2o/iop0: Reset rejected, trying to clear

about a three min pause here  normally 1 sec.

i2o/iop0: SysTab setup timed out.
i2o/iop0: Get status timeout.

about a 30-45 second pause here.

i2o/iop0: Get status timeout.


My relevant? kernel options are...

# I2O device support
#
CONFIG_I2O=y
# CONFIG_I2O_CONFIG is not set
CONFIG_I2O_BLOCK=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y

When it functions normally 2.4.20(crypt) it looks like this (with context)

USB Mass Storage support registered.
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 9
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
PCI: Found IRQ 12 for device 00:0b.1
i2o: I2O controller on bus 0 at 89.
i2o: PCI I2O controller at 0xCD800000 size=4194304
I2O: Promise workarounds activated.
i2o/iop0: Installed at IRQ12
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Reset rejected, trying to clear
i2o/iop0: LCT has 7 entries.
i2o/iop0: Configuration dialog desired.
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2ob: Installing tid 11 device at unit 0
i2o/hda: Max segments 12, queue depth 8, byte limit 49152.
i2o/hda: Type 1: 152587MB, 512 byte sectors.
i2o/hda: Maximum sectors/read set to 96.
 i2o/hda: i2o/hda1 i2o/hda2
i2o_scsi.c: Version 0.0.1
  chain_pool: 2048 bytes @ c1466800
  (512 byte buffers X 4 can_queue X 1 i2o controllers)
md: raid1 personality registered as nr 3

during normal boot there are no delays more than a second.
Also in 2.4.20, cat /proc/pci reveals the following.

  Bus  0, device  11, function  1:
    I2O: Intel Corp. 80960RM [i960RM Microprocessor] (rev 2).
      IRQ 12.
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xcd800000 [0xcdbfffff].

My motherboard is a K7S5A running bios 3/25/2002S

My card bios version is currently 1.10.0 but they are up to 1.20.0.27.  I
am going to hold off on upgrading for now because it didn't seem to solve
the two other writers problems, and I'd be happy to test against this
older version if you like.

As I mentioned two other people have written to the list about this,

Matt H. (lkml@lpbproductions.com)
and Alex Murphy (murphy@sgtp.samara.ru) 

I couldn't seem to find a response upon googling.

Please CC to odinson@warcloud.net.  Thanks to anybody who can help with
this.  Thank you for your time.

Matt
-------------------------------------------------------------------------------
Matthew Newhall
President of LILUG
Long Island Linux Users Group
president@lilug.org
http://lilug.org

It is by the fortune of God that, in this country, we have three benefits: 
freedom of speech, freedom of thought, and the wisdom never to use either.
                -- Mark Twain
-------------------------------------------------------------------------------

