Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUENXbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUENXbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbUENXaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:30:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:51172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264542AbUENX2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:28:32 -0400
Date: Fri, 14 May 2004 16:27:55 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C update for 2.6.6
Message-ID: <20040514232755.GA18395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver patches for 2.6.6.  The majority of them have
been in the -mm kernels for a few weeks.  They do the following:
	- rename a driver
	- add a new driver
	- fix some bugs
	- standardize on the proper way to specify i2c devices and
	  buses across all i2c users.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/i2c-ixp42x.c           |  176 -------------
 Documentation/i2c/porting-clients         |    8 
 arch/i386/pci/irq.c                       |    8 
 drivers/i2c/algos/i2c-algo-bit.c          |   10 
 drivers/i2c/busses/Kconfig                |   12 
 drivers/i2c/busses/Makefile               |    2 
 drivers/i2c/busses/i2c-ali1535.c          |    4 
 drivers/i2c/busses/i2c-ali1563.c          |    4 
 drivers/i2c/busses/i2c-ali15x3.c          |    4 
 drivers/i2c/busses/i2c-amd756.c           |    4 
 drivers/i2c/busses/i2c-amd8111.c          |    4 
 drivers/i2c/busses/i2c-i801.c             |   30 +-
 drivers/i2c/busses/i2c-isa.c              |    4 
 drivers/i2c/busses/i2c-ixp4xx.c           |  285 +++++++++++++++++----
 drivers/i2c/busses/i2c-keywest.c          |    1 
 drivers/i2c/busses/i2c-nforce2.c          |    4 
 drivers/i2c/busses/i2c-parport-light.c    |    4 
 drivers/i2c/busses/i2c-parport.c          |    4 
 drivers/i2c/busses/i2c-piix4.c            |    5 
 drivers/i2c/busses/i2c-sis5595.c          |    4 
 drivers/i2c/busses/i2c-sis630.c           |    4 
 drivers/i2c/busses/i2c-sis96x.c           |    4 
 drivers/i2c/busses/i2c-via.c              |    4 
 drivers/i2c/busses/i2c-viapro.c           |    4 
 drivers/i2c/busses/i2c-voodoo3.c          |    4 
 drivers/i2c/busses/scx200_acb.c           |    1 
 drivers/i2c/busses/scx200_i2c.c           |    1 
 drivers/i2c/chips/Kconfig                 |   18 +
 drivers/i2c/chips/Makefile                |    1 
 drivers/i2c/chips/adm1021.c               |    4 
 drivers/i2c/chips/asb100.c                |   12 
 drivers/i2c/chips/fscher.c                |    4 
 drivers/i2c/chips/gl518sm.c               |    4 
 drivers/i2c/chips/it87.c                  |   82 ++++++
 drivers/i2c/chips/lm75.c                  |    4 
 drivers/i2c/chips/lm78.c                  |    4 
 drivers/i2c/chips/lm80.c                  |    4 
 drivers/i2c/chips/lm83.c                  |    4 
 drivers/i2c/chips/lm90.c                  |   53 ++--
 drivers/i2c/chips/rtc8564.c               |  396 ++++++++++++++++++++++++++++++
 drivers/i2c/chips/rtc8564.h               |   78 +++++
 drivers/i2c/chips/via686a.c               |  123 +++------
 drivers/i2c/chips/w83781d.c               |   38 +-
 drivers/i2c/chips/w83l785ts.c             |    4 
 drivers/ide/pci/piix.c                    |    8 
 drivers/ide/pci/piix.h                    |    2 
 drivers/media/video/bt832.c               |    2 
 drivers/media/video/bttv-i2c.c            |    8 
 drivers/media/video/cx88/cx88-i2c.c       |    4 
 drivers/media/video/dpc7146.c             |    2 
 drivers/media/video/hexium_gemini.c       |    2 
 drivers/media/video/hexium_orion.c        |    2 
 drivers/media/video/msp3400.c             |    4 
 drivers/media/video/mxb.c                 |    2 
 drivers/media/video/saa5246a.c            |    2 
 drivers/media/video/saa5249.c             |    2 
 drivers/media/video/saa7111.c             |   59 ++++
 drivers/media/video/saa7134/saa6752hs.c   |    2 
 drivers/media/video/saa7134/saa7134-i2c.c |    4 
 drivers/media/video/tda7432.c             |    4 
 drivers/media/video/tda9875.c             |    4 
 drivers/media/video/tda9887.c             |    4 
 drivers/media/video/tuner.c               |    4 
 drivers/media/video/tvaudio.c             |    4 
 drivers/media/video/tvmixer.c             |    4 
 drivers/usb/media/w9968cf.c               |    2 
 include/linux/i2c-id.h                    |    2 
 include/linux/i2c.h                       |   18 -
 include/linux/pci_ids.h                   |   24 +
 include/linux/video_decoder.h             |    7 
 sound/oss/i810_audio.c                    |   10 
 71 files changed, 1147 insertions(+), 477 deletions(-)
-----

<bjorn:mork.no>:
  o I2C: "probe" module param broken for it87 in Linux 2.6.6

<jdgaston:snoqualmie.dp.intel.com>:
  o I2C: ICH6/6300ESB i2c support

<kevin:koconnor.net>:
  o I2C: support I2C_M_NO_RD_ACK in i2c-algo-bit

Deepak Saxena:
  o I2C: Missed ixp42x -> ixp4xx conversion
  o I2C: Update IXP4xx I2C bus driver

Greg Kroah-Hartman:
  o I2C: rename i2c-ip4xx.c driver

Jean Delvare:
  o I2C: Rename hardware monitoring I2C class
  o I2C: kill duplicate includes in i2c bus drivers
  o I2C: Fix memory leaks in w83781d and asb100
  o I2C: Rewrite temperature conversions in via686a driver
  o I2C: Invert as99127f beep bits in kernel space
  o I2C: Sensors (W83627HF) in Tyan S2882
  o I2C: Voltage conversions in via686a
  o I2C: Add LM99 support to the lm90 driver

Michael Hunold:
  o I2C: add .class to i2c drivers

Ronald S. Bultje:
  o I2C: new i2c video decoder calls: saa7111 driver
  o I2C: new i2c video decoder calls

Stefan Eletzhofer:
  o I2C: add I2C epson 8564 RTC chip driver

