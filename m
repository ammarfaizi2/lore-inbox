Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbVCDXIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbVCDXIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVCDWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:15:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:41121 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263114AbVCDUyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:18 -0500
Date: Fri, 4 Mar 2005 12:35:32 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] I2C patches for 2.6.11
Message-ID: <20050304203531.GA31644@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a I2C update for 2.6.11.  It includes a number of fixes, and
some new i2c drivers.  All of these patches have been in the past few
-mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Patches will be posted to linux-kernel and sensors as a follow-up thread
for those who want to see them.

thanks,

greg k-h

 Documentation/i2c/porting-clients                 |    6 
 Documentation/i2c/writing-clients                 |    6 
 MAINTAINERS                                       |    4 
 drivers/acorn/char/i2c.c                          |    2 
 drivers/acorn/char/pcf8583.c                      |    1 
 drivers/i2c/algos/i2c-algo-ite.c                  |    4 
 drivers/i2c/algos/i2c-algo-pca.c                  |   30 
 drivers/i2c/algos/i2c-algo-pcf.c                  |    2 
 drivers/i2c/algos/i2c-algo-sgi.c                  |    2 
 drivers/i2c/busses/Kconfig                        |   12 
 drivers/i2c/busses/Makefile                       |    1 
 drivers/i2c/busses/i2c-au1550.c                   |    2 
 drivers/i2c/busses/i2c-elektor.c                  |    1 
 drivers/i2c/busses/i2c-ibm_iic.c                  |    2 
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 
 drivers/i2c/busses/i2c-ixp4xx.c                   |    4 
 drivers/i2c/busses/i2c-keywest.c                  |    2 
 drivers/i2c/busses/i2c-mpc.c                      |    2 
 drivers/i2c/busses/i2c-mv64xxx.c                  |  596 ++++++++++++++++
 drivers/i2c/busses/i2c-nforce2.c                  |    6 
 drivers/i2c/busses/i2c-s3c2410.c                  |    5 
 drivers/i2c/chips/Kconfig                         |   46 +
 drivers/i2c/chips/Makefile                        |    4 
 drivers/i2c/chips/adm1021.c                       |    9 
 drivers/i2c/chips/adm1025.c                       |   12 
 drivers/i2c/chips/adm1026.c                       |   87 --
 drivers/i2c/chips/adm1031.c                       |    9 
 drivers/i2c/chips/asb100.c                        |    9 
 drivers/i2c/chips/ds1621.c                        |    9 
 drivers/i2c/chips/eeprom.c                        |    4 
 drivers/i2c/chips/fscher.c                        |   11 
 drivers/i2c/chips/fscpos.c                        |  643 +++++++++++++++++
 drivers/i2c/chips/gl518sm.c                       |   12 
 drivers/i2c/chips/gl520sm.c                       |  754 ++++++++++++++++++++
 drivers/i2c/chips/isp1301_omap.c                  |    1 
 drivers/i2c/chips/it87.c                          |   76 +-
 drivers/i2c/chips/lm63.c                          |    5 
 drivers/i2c/chips/lm75.c                          |    9 
 drivers/i2c/chips/lm77.c                          |    9 
 drivers/i2c/chips/lm78.c                          |   58 -
 drivers/i2c/chips/lm80.c                          |   30 
 drivers/i2c/chips/lm83.c                          |   12 
 drivers/i2c/chips/lm85.c                          |   14 
 drivers/i2c/chips/lm87.c                          |   12 
 drivers/i2c/chips/lm90.c                          |   12 
 drivers/i2c/chips/m41t00.c                        |  247 ++++++
 drivers/i2c/chips/max1619.c                       |   13 
 drivers/i2c/chips/pc87360.c                       |    4 
 drivers/i2c/chips/pcf8574.c                       |    4 
 drivers/i2c/chips/pcf8591.c                       |    4 
 drivers/i2c/chips/rtc8564.c                       |   18 
 drivers/i2c/chips/sis5595.c                       |  794 ++++++++++++++++++++++
 drivers/i2c/chips/smsc47b397.c                    |    5 
 drivers/i2c/chips/smsc47m1.c                      |    9 
 drivers/i2c/chips/via686a.c                       |    6 
 drivers/i2c/chips/w83627hf.c                      |   26 
 drivers/i2c/chips/w83781d.c                       |   29 
 drivers/i2c/chips/w83l785ts.c                     |   12 
 drivers/i2c/i2c-core.c                            |   81 +-
 drivers/i2c/i2c-dev.c                             |    9 
 drivers/i2c/i2c-sensor-detect.c                   |    7 
 drivers/macintosh/therm_windtunnel.c              |    4 
 drivers/media/common/saa7146_i2c.c                |    8 
 drivers/media/dvb/b2c2/skystar2.c                 |    2 
 drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c      |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 
 drivers/media/video/adv7170.c                     |    5 
 drivers/media/video/adv7175.c                     |    5 
 drivers/media/video/bt819.c                       |   11 
 drivers/media/video/bt856.c                       |    5 
 drivers/media/video/bttv-i2c.c                    |    3 
 drivers/media/video/cx88/cx88-i2c.c               |    1 
 drivers/media/video/ovcamchip/ovcamchip_core.c    |    1 
 drivers/media/video/saa5246a.c                    |    1 
 drivers/media/video/saa5249.c                     |    1 
 drivers/media/video/saa7110.c                     |    5 
 drivers/media/video/saa7111.c                     |    5 
 drivers/media/video/saa7114.c                     |    5 
 drivers/media/video/saa7134/saa7134-i2c.c         |    3 
 drivers/media/video/saa7185.c                     |    5 
 drivers/media/video/tda7432.c                     |    1 
 drivers/media/video/tda9840.c                     |    4 
 drivers/media/video/tda9875.c                     |    1 
 drivers/media/video/tea6415c.c                    |    4 
 drivers/media/video/tea6420.c                     |    4 
 drivers/media/video/tuner-3036.c                  |    1 
 drivers/media/video/vpx3220.c                     |   19 
 include/linux/i2c-id.h                            |   18 
 include/linux/i2c.h                               |   63 -
 include/linux/mv643xx.h                           |   17 
 include/linux/pci_ids.h                           |    1 
 include/media/saa7146.h                           |    4 
 sound/oss/dmasound/dac3550a.c                     |    4 
 sound/ppc/keywest.c                               |    2 
 94 files changed, 3503 insertions(+), 521 deletions(-)
-----


<hfvogt:gmx.net>:
  o I2C i2c-nforce2: add support for nForce4 (patch against 2.6.11-rc4)

<maartendeprez:scarlet.be>:
  o I2C: add GL520SM Sensor Chip driver

<shawn.starr:rogers.com>:
  o I2C: lm80 driver improvement

<stefan:desire.ch>:
  o I2C: fix for fscpos voltage values
  o I2C: add fscpos chip driver

<yekkim:pacbell.net>:
  o I2C: Fix some gcc 4.0 compile failures and warnings

Adrian Bunk:
  o i2c-core.c: make some code static

Alexey Dobriyan:
  o I2C: use time_after instead of comparing jiffies

Andrew Morton:
  o I2C: saa7146 build fix

Aurelien Jarno:
  o I2C: New chip driver: sis5595
  o I2C: lm78 driver improvement

Ben Dooks:
  o I2C: S3C2410 missing I2C_CLASS_HWMON

Corey Minyard:
  o I2C: minor I2C cleanups

Greg Kroah-Hartman:
  o I2C: fixed up the i2c-id.h algo ids
  o I2C: just delete the id field, let's not delay it any longer
  o I2C: Fix up some build warnings in the fscpos driver

Ian Campbell:
  o I2C: fix typo in drivers/i2c/busses/i2c-ixp4xx.c
  o I2C: improve debugging output

Jean Delvare:
  o I2C: Trivial indentation fix in i2c/chips/Kconfig
  o I2C: Change of i2c co-maintainer
  o I2C: w83627hf needs i2c-isa
  o Add class definition to the elektor bus driver
  o I2C: Make i2c list terminators explicitely unsigned
  o I2C: Remove NULL client checks in rtc8564 driver
  o I2C: Kill unused includes in i2c-sensor-detect.c
  o I2C: Enable w83781d and w83627hf temperature channels
  o I2C: Kill i2c_client.id (5/5)
  o I2C: Kill i2c_client.id (4/5)
  o I2C: Kill i2c_client.id (3/5)
  o I2C: Kill i2c_client.id (2/5)
  o I2C: Kill i2c_client.id (1/5)
  o I2C: Allow it87 pwm reconfiguration

Maciej W. Rozycki:
  o I2C: Enable I2C_PIIX4 for 64-bit platforms

Mark A. Greer:
  o I2C: add Marvell mv64xxx i2c driver
  o I2C: add ST M41T00 I2C RTC chip driver

Mark M. Hoffman:
  o I2C: unnecessary #includes in asb100.c
  o I2C: i2c-dev namespace cleanup

