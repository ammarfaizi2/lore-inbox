Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264847AbRF3Fgl>; Sat, 30 Jun 2001 01:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbRF3Fgb>; Sat, 30 Jun 2001 01:36:31 -0400
Received: from prograine2.raster.krakow.pl ([212.160.153.165]:21121 "EHLO
	procomnet2.prograine.net") by vger.kernel.org with ESMTP
	id <S264847AbRF3Fg1>; Sat, 30 Jun 2001 01:36:27 -0400
Date: Sat, 30 Jun 2001 07:41:38 +0200 (CEST)
From: <pt@procomnet2.prograine.net>
To: <linux-kernel@vger.kernel.org>
Subject: Intel SRCU3-1 RAID (I2O) and 2.4.5-ac18
Message-ID: <Pine.LNX.4.33.0106300635050.1166-100000@procomnet2.prograine.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have configured a RAID5 volume, partitioned it and created
ext2 on it. I can mount it and everything seems to be ok, but
trying to copy a large (+-500MB) file from one directory on
the filesystem on the RAID to another results in something like:

i2o/iop0: No handler for event (0x00000400)
i2o/iop0 requires user configuration
Driver "I2O Block OSM" did not release device!
i2ob_del_device called, but not in dev table!
Driver "I2O Block OSM" did not release device!

and the copying process is frozen. After that I can read
some data from the filesystem (tried to ls some directories)
but cannot umount it and cannot kill the copying process.
The event code in the message's first line sometimes has different
values (0x00000020 for example), the first line happens to
be repeated a few times as well.
The problem is fully reproducible with my system.

The system is RedHat 7.1, the kernel is compiled with SMP,
I2O block OSM, I2O PCI support and without I2O SCSI and I2O net OSMs.
SCSI support is also off. I enabled the enhanced RTC because a
somewhat dated document from Intel concerning support for this
controller with RH62 says it has to be on.
GCC and binutils versions are: egcs-2.91.66 (stock RH71 "kgcc"),
binutils-2.10.91.0.2 (stock RH71).

I have the controller working in an Intel L440GX+ board with
two PIII 700MHz processors. The board specs are: 82440GX chipset,
Cirrus Logic CLGD5480 VGA, Adaptec AIC-7896 SCSI (unused), Intel 82559
EtherPro100 (unused). The SRCU31 controller works in an ordinary PCI
slot (32bit/33mhz), the only other PCI card in the system (apart
from the on-board devices) is an Intel EtherPro100.
There are four IBM DDYS-T18350 drives on the controller, three of
them are in the raid. The controller has 32MB RAM as cache,
the system has 512MB of ECC RAM.

greetings,

Przemek Tomala

PS: if you need additional info or you can help with this,
    please CC me, as I am not subscribed to the list

