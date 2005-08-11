Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVHKVSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVHKVSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVHKVSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:18:03 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:32779 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932488AbVHKVSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:18:03 -0400
Date: Thu, 11 Aug 2005 23:18:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (0/7) I2C: Kill i2c_algorithm.{name,id}
Message-Id: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here comes another patchset affecting the whole i2c subsystem. I am
posting it here mainly for the media/video folks to look at, as it
affects most of their drivers and may conflict with their own pending
patches. But comments from everyone are also welcome, of course.

The goal of this patchset is to get rid of the name and id members of
the i2c_algorithm struct. I believe that they are not useful enough to
justify their existence. "name" is filled by all drivers but not used
anywhere. "id" is filled by most drivers, and used at places, but all
uses can easily be replaced, and doing so is even benefical in term of
code quality. There were quite a significant number of cases where i2c
algorithm IDs were missing or misused, proving my point that we better
get rid of it.

This patchset is composed of 7 patches, which apply on top of each other
in order, and which I'll be posting as replies to this post.

This patchset is (obviously) not meant for 2.6.13 (maybe not even
2.6.14). It should go to -mm through Greg KH's i2c tree. BTW, it is
meant to be applied on top of Greg's current i2c tree, and may not apply
properly to -stable or -linus. It should hopefully apply properly to -mm
though.

Thanks.

 drivers/i2c/algos/i2c-algo-bit.c                  |    4 -
 drivers/i2c/algos/i2c-algo-ite.c                  |    4 -
 drivers/i2c/algos/i2c-algo-pca.c                  |    4 -
 drivers/i2c/algos/i2c-algo-pcf.c                  |    4 -
 drivers/i2c/algos/i2c-algo-sgi.c                  |    3 -
 drivers/i2c/algos/i2c-algo-sibyte.c               |    4 -
 drivers/i2c/busses/i2c-ali1535.c                  |    2 -
 drivers/i2c/busses/i2c-ali1563.c                  |    2 -
 drivers/i2c/busses/i2c-ali15x3.c                  |    2 -
 drivers/i2c/busses/i2c-amd756.c                   |    2 -
 drivers/i2c/busses/i2c-amd8111.c                  |    2 -
 drivers/i2c/busses/i2c-au1550.c                   |    2 -
 drivers/i2c/busses/i2c-i801.c                     |    2 -
 drivers/i2c/busses/i2c-ibm_iic.c                  |    4 -
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 -
 drivers/i2c/busses/i2c-isa.c                      |    3 -
 drivers/i2c/busses/i2c-keywest.c                  |    3 -
 drivers/i2c/busses/i2c-mpc.c                      |    4 -
 drivers/i2c/busses/i2c-mv64xxx.c                  |    4 -
 drivers/i2c/busses/i2c-nforce2.c                  |    2 -
 drivers/i2c/busses/i2c-piix4.c                    |    2 -
 drivers/i2c/busses/i2c-s3c2410.c                  |    1 -
 drivers/i2c/busses/i2c-sis5595.c                  |    2 -
 drivers/i2c/busses/i2c-sis630.c                   |    2 -
 drivers/i2c/busses/i2c-sis96x.c                   |    2 -
 drivers/i2c/busses/i2c-stub.c                     |    2 -
 drivers/i2c/busses/i2c-viapro.c                   |    2 -
 drivers/i2c/busses/scx200_acb.c                   |    4 -
 drivers/media/common/saa7146_i2c.c                |    4 -
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    3 -
 drivers/media/dvb/dvb-usb/cxusb.c                 |    2 -
 drivers/media/dvb/dvb-usb/dibusb-common.c         |    2 -
 drivers/media/dvb/dvb-usb/digitv.c                |    2 -
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c           |    1 -
 drivers/media/dvb/pluto2/pluto2.c                 |    1 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    3 -
 drivers/media/video/bt832.c                       |    2 
 drivers/media/video/bttv-i2c.c                    |    4 -
 drivers/media/video/ir-kbd-i2c.c                  |    4 
 drivers/media/video/ovcamchip/ov6x20.c            |    6 
 drivers/media/video/ovcamchip/ov6x30.c            |    4 
 drivers/media/video/ovcamchip/ovcamchip_core.c    |    8 
 drivers/media/video/saa7134/saa7134-i2c.c         |    4 -
 drivers/media/video/tda7432.c                     |    2 
 drivers/media/video/tda9840.c                     |    2 
 drivers/media/video/tda9875.c                     |    2 
 drivers/media/video/tda9887.c                     |    6 
 drivers/media/video/tea6415c.c                    |    2 
 drivers/media/video/tea6420.c                     |    2 
 drivers/media/video/tuner-3036.c                  |    2 
 drivers/media/video/tvaudio.c                     |   10 
 drivers/media/video/tveeprom.c                    |    2 
 drivers/media/video/tvmixer.c                     |    6 
 drivers/usb/media/w9968cf.c                       |    4 -
 drivers/video/aty/radeon_i2c.c                    |    2 
 drivers/video/matrox/matroxfb_maven.c             |    2 
 drivers/video/nvidia/nv_i2c.c                     |    3 -
 drivers/video/riva/rivafb-i2c.c                   |    3 -
 drivers/video/savage/savagefb-i2c.c               |    3 -
 include/linux/i2c-id.h                            |  192 ++++++++--------------
 include/linux/i2c-isa.h                           |    6 
 include/linux/i2c.h                               |    3 -
 include/media/id.h                                |    5 -
 63 files changed, 119 insertions(+), 266 deletions(-)


-- 
Jean Delvare
