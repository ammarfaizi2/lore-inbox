Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTIYVud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIYVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:50:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:22172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261898AbTIYVuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:50:18 -0400
Date: Thu, 25 Sep 2003 14:48:38 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver fixes for 2.6.0-test5
Message-ID: <20030925214838.GA30072@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more i2c driver fixes and additions for 2.6.0-test5.  I've
fixed up the check_region/request_region logic for isa drivers and moved
the i2c algorithms into their own subdirectory, both as recommended by
Christoph, and added the eeprom i2c chip driver (ported from the 2.4
tree and converted to use the sysfs binary file interface).

There are a also a few other minor i2c cleanups and fixes in here.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

thanks,

greg k-h

 drivers/i2c/i2c-algo-bit.c        |  567 ------------------------
 drivers/i2c/i2c-algo-ite.c        |  872 --------------------------------------
 drivers/i2c/i2c-algo-pcf.c        |  479 --------------------
 drivers/i2c/i2c-ite.h             |  117 -----
 drivers/i2c/i2c-pcf8584.h         |   78 ---
 Documentation/i2c/sysfs-interface |    5 
 drivers/i2c/Kconfig               |   38 -
 drivers/i2c/Makefile              |    5 
 drivers/i2c/algos/Kconfig         |   45 +
 drivers/i2c/algos/Makefile        |    7 
 drivers/i2c/algos/i2c-algo-bit.c  |  567 ++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-ite.c  |  872 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-ite.h  |  117 +++++
 drivers/i2c/algos/i2c-algo-pcf.c  |  479 ++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-pcf.h  |   78 +++
 drivers/i2c/busses/i2c-elektor.c  |    2 
 drivers/i2c/chips/Kconfig         |   12 
 drivers/i2c/chips/Makefile        |    1 
 drivers/i2c/chips/eeprom.c        |  290 ++++++++++++
 drivers/i2c/i2c-sensor.c          |    5 
 20 files changed, 2469 insertions(+), 2167 deletions(-)
-----

Greg Kroah-Hartman:
  o I2C: remove unneeded #defines in the eeprom chip driver
  o I2C: add eeprom i2c chip driver
  o I2C: move the i2c algorithm drivers to drivers/i2c/algos
  o I2C: remove the isa address check alltogether

