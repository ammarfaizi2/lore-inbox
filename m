Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTDXXtu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTDXXtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:49:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:5577 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264553AbTDXXpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:08 -0400
Date: Thu, 24 Apr 2003 16:58:36 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.68
Message-ID: <20030424235836.GA29888@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver changes for 2.5.68.  These include a lot of
cleanup patches, removing dead or duplicated code.  With these patches,
we are almost able to remove i2c-sensor.h and i2c-sensor.c, but not
quite there.  Also a new i2c chip driver has been added.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-viapro.c  |  321 +++++-------
 drivers/i2c/chips/Kconfig        |   14 
 drivers/i2c/chips/Makefile       |    1 
 drivers/i2c/chips/adm1021.c      |  130 -----
 drivers/i2c/chips/it87.c         |  976 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/chips/lm75.c         |    8 
 drivers/i2c/chips/via686a.c      |    8 
 drivers/i2c/chips/w83781d.c      |   10 
 drivers/i2c/i2c-core.c           |    8 
 drivers/i2c/i2c-sensor.c         |   46 -
 drivers/media/video/msp3400.c    |    6 
 drivers/media/video/saa5249.c    |    2 
 drivers/media/video/saa7111.c    |    2 
 drivers/media/video/tda7432.c    |    3 
 drivers/media/video/tda9840.c    |    2 
 drivers/media/video/tda9875.c    |    3 
 drivers/media/video/tda9887.c    |    3 
 drivers/media/video/tea6415c.c   |    2 
 drivers/media/video/tea6420.c    |    2 
 drivers/media/video/tuner-3036.c |    3 
 drivers/media/video/tuner.c      |    3 
 drivers/media/video/tvaudio.c    |    3 
 include/linux/i2c-sensor.h       |  152 +-----
 include/linux/i2c.h              |   25 
 24 files changed, 1216 insertions(+), 517 deletions(-)
-----

<florin@iucha.net>:
  o i2c: added it87 driver

Christoph Hellwig <hch@lst.de>:
  o i2c: bring i2c-viapro uptodate with the style guide
  o i2c: remove dead init code from i2c-sensors.c
  o i2c: remove dead code from adm1021
  o i2c: remove dead junk from i2c-sensors.h

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: remove a lot of dupliated macros from i2c-sensor.h and use the current values in i2c.h
  o i2c: removed unneeded typedef from i2c-sensor.h
  o i2c: fix up the media drivers due to removing flags paramater of callback function
  o i2c: removed unused flags paramater in found_proc callback
  o i2c: fix up it87.c check_region mess

