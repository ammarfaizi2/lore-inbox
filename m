Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbTCYBZC>; Mon, 24 Mar 2003 20:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTCYBZC>; Mon, 24 Mar 2003 20:25:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7184 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261317AbTCYBZA>;
	Mon, 24 Mar 2003 20:25:00 -0500
Date: Mon, 24 Mar 2003 17:35:31 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.66
Message-ID: <20030325013531.GA11158@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver changes for 2.5.66.  These include changes that
I previously sent, but didn't end up in 2.5.65.

They do the following:
	- hook up i2c devices with the driver core.
	- remove some redundant fields from i2c structures now that the
	  driver and device structures are being used.
	- fix up i2c drivers outside of the i2c tree.
	- fix some other minor bugs.

The i2c bus, drivers, and devices are now all hooked up to the driver
core.  On one of my boxes this looks like:

/sys/bus/i2c/
|-- devices
|   `-- i2c_dev_0 -> ../../../devices/pci0/00:1f.3/i2c-0/i2c_dev_0
`-- drivers
    `-- LM75 sensor
        `-- i2c_dev_0 -> ../../../../devices/pci0/00:1f.3/i2c-0/i2c_dev_0

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/acorn/char/i2c.c                  |    4 
 drivers/i2c/busses/i2c-ali15x3.c          |    8 -
 drivers/i2c/busses/i2c-amd756.c           |    6 -
 drivers/i2c/busses/i2c-amd8111.c          |    4 
 drivers/i2c/busses/i2c-i801.c             |    8 -
 drivers/i2c/busses/i2c-isa.c              |    4 
 drivers/i2c/busses/i2c-piix4.c            |    8 -
 drivers/i2c/chips/adm1021.c               |   21 +--
 drivers/i2c/chips/lm75.c                  |   14 +-
 drivers/i2c/i2c-algo-bit.c                |   13 +-
 drivers/i2c/i2c-algo-pcf.c                |   19 +--
 drivers/i2c/i2c-core.c                    |  108 +++++++++---------
 drivers/i2c/i2c-dev.c                     |   42 +++----
 drivers/i2c/i2c-elektor.c                 |   10 +
 drivers/i2c/i2c-elv.c                     |    6 -
 drivers/i2c/i2c-philips-par.c             |    4 
 drivers/i2c/i2c-proc.c                    |  180 +++++++-----------------------
 drivers/i2c/i2c-velleman.c                |    4 
 drivers/i2c/scx200_acb.c                  |   34 ++---
 drivers/ieee1394/pcilynx.c                |    4 
 drivers/media/video/adv7175.c             |   22 ++-
 drivers/media/video/bt819.c               |   33 +++--
 drivers/media/video/bt856.c               |   27 ++--
 drivers/media/video/bttv-if.c             |   22 ++-
 drivers/media/video/msp3400.c             |   32 ++---
 drivers/media/video/saa5249.c             |   13 +-
 drivers/media/video/saa7110.c             |   19 +--
 drivers/media/video/saa7111.c             |   21 ++-
 drivers/media/video/saa7134/saa7134-i2c.c |   10 +
 drivers/media/video/saa7185.c             |   19 +--
 drivers/media/video/tda7432.c             |   16 +-
 drivers/media/video/tda9875.c             |   16 +-
 drivers/media/video/tda9887.c             |   14 +-
 drivers/media/video/tuner-3036.c          |    6 -
 drivers/media/video/tuner.c               |   29 ++--
 drivers/media/video/tvaudio.c             |   44 +++----
 drivers/video/matrox/i2c-matroxfb.c       |   11 +
 include/linux/i2c.h                       |   33 +++--
 38 files changed, 444 insertions(+), 444 deletions(-)
-----


Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: set up a "generic" i2c driver to prevent oopses when devices are registering
  o i2c: fix typo that newer versions of gcc catch
  o i2c: fix up drivers/video/matrox/i2c-matroxfb.c due to previous i2c changes
  o i2c: fix up drivers/ieee1394/pcilynx.c due to previous i2c changes
  o i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes
  o i2c: fix up drivers/media/video/* due to previous i2c changes
  o i2c: ugh, clean up lindent mess in i2c-proc.c::i2c_detect()
  o i2c: fix up the chip driver names to play nice with sysfs
  o i2c: actually register the i2c client device with the driver core
  o i2c: Removed the name variable from i2c_client as the dev one should be used instead
  o i2c: remove the data field from struct i2c_client
  o i2c: add struct device to i2c_client structure
  o i2c: remove *data from i2c_adapter, as dev->data should be used instead
  o i2c: remove i2c_adapter->name and use dev->name instead

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix kobject_get oopses triggered by i2c in 2.5.65-bk

