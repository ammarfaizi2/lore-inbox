Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbTDCANs>; Wed, 2 Apr 2003 19:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263234AbTDCANj>; Wed, 2 Apr 2003 19:13:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:15494 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263226AbTDCACR>; Wed, 2 Apr 2003 19:02:17 -0500
Date: Wed, 2 Apr 2003 16:14:56 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver changes for 2.5.66
Message-ID: <20030403001456.GA4973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more i2c driver changes for 2.5.66.  It adds two i2c chip
drivers, and converts all of them to the sysfs interface.  In doing so,
I've ripped out all of the old /proc and sysctl mess.  A number of small
bugfixes for some of the media i2c drivers are in here too.

I've also fixed up the bus_id of the i2c client devices, as the current
code can cause duplicate bus_ids which didn't play nice on some systems.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 Documentation/i2c/proc-interface  |   53 -
 drivers/i2c/i2c-proc.c            |  187 ---
 include/linux/i2c-proc.h          |  373 -------
 Documentation/i2c/sysfs-interface |  177 +++
 drivers/i2c/Kconfig               |   11 
 drivers/i2c/Makefile              |    2 
 drivers/i2c/busses/Kconfig        |   13 
 drivers/i2c/chips/Kconfig         |   70 +
 drivers/i2c/chips/Makefile        |    2 
 drivers/i2c/chips/adm1021.c       |  360 +++----
 drivers/i2c/chips/lm75.c          |  187 +--
 drivers/i2c/chips/via686a.c       | 1010 +++++++++++++++++++-
 drivers/i2c/chips/w83781d.c       | 1892 +++++++++++++++++++++++++++++++++++++-
 drivers/i2c/i2c-core.c            |  190 ---
 drivers/i2c/i2c-proc.c            |  550 -----------
 drivers/i2c/i2c-sensor.c          |  182 +++
 drivers/media/video/adv7175.c     |    2 
 drivers/media/video/tvmixer.c     |   20 
 include/linux/i2c-proc.h          |   43 
 include/linux/i2c-sensor.h        |  373 +++++++
 include/linux/i2c-vid.h           |   66 +
 21 files changed, 3975 insertions(+), 1788 deletions(-)
-----


<azarah@gentoo.org>:
  o i2c: w83781d i2c driver updated for 2.5.66-bk4 (with sysfs support, empty tree)

<j.dittmer@portrix.net>:
  o i2c: add i2c-via686a driver
  o i2c: fix compile bugs in tvmixer.c

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: remove old proc documentation and add sysfs file documentation
  o i2c: fix up broken drivers/i2c/busses build due to I2C_PROC now being gone
  o i2c: clean up previous w83781d patch due to changes I made to i2c core and build
  o i2c: remove all proc code from the i2c core, as it's no longer needed
  o i2c: move i2c-proc to i2c-sensor and clean up all usages of it
  o i2c: remove unused paramater in found_proc callback function
  o i2c: remove proc and sysctl code from i2c-proc as it is no longer used
  o i2c: remove sysctl and proc functions from via686a.c driver
  o i2c: convert adm1021 chip driver to use sysfs files
  o i2c: convert lm75 chip driver to use sysfs files
  o i2c: change the way i2c creates the bus ids to actually be unique now
  o i2c: fix memleak caused by my last patch fo the adv7175.c driver

