Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUCPAEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbUCPAD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:5295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262877AbUCPACA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:00 -0500
Date: Mon, 15 Mar 2004 15:55:58 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core update for 2.6.4
Message-ID: <20040315235558.GA23280@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few driver core changes for 2.6.3.  They have all been in the -mm
tree with the exception of the kref patch, which has been reviewed on lkml.
These patches add a few more sysfs class entries, clean up the cdev interface
and add the kref structure.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/Makefile                  |    5 ++
 drivers/base/bus.c                     |    4 -
 drivers/base/class.c                   |   16 ++++--
 drivers/base/class_simple.c            |    4 -
 drivers/base/core.c                    |    4 -
 drivers/base/driver.c                  |    4 -
 drivers/base/power/Makefile            |    4 +
 drivers/base/power/main.c              |    4 -
 drivers/base/power/shutdown.c          |    4 -
 drivers/base/sys.c                     |    4 -
 drivers/char/drm/drm_stub.h            |   35 +++++++++++++-
 drivers/char/lp.c                      |   16 +++++-
 drivers/char/misc.c                    |    1 
 drivers/char/tty_io.c                  |   80 ++++++++++++++++++---------------
 drivers/ieee1394/amdtp.c               |    3 -
 drivers/ieee1394/dv1394.c              |    4 -
 drivers/ieee1394/raw1394.c             |    4 -
 drivers/ieee1394/video1394.c           |    3 -
 drivers/input/input.c                  |    4 +
 drivers/net/ppp_generic.c              |   21 ++++++++
 drivers/pci/hotplug/pci_hotplug_core.c |   14 -----
 drivers/s390/char/tape_class.c         |    7 --
 drivers/scsi/sg.c                      |    7 +-
 drivers/scsi/st.c                      |   39 ++++++++++------
 fs/char_dev.c                          |   26 +++-------
 include/linux/cdev.h                   |    4 -
 include/linux/kobject.h                |    8 +++
 include/linux/kref.h                   |   32 +++++++++++++
 lib/Makefile                           |    3 +
 lib/kref.c                             |   60 ++++++++++++++++++++++++
 net/netlink/netlink_dev.c              |   20 +++++++-
 31 files changed, 301 insertions(+), 143 deletions(-)
-----

Andrew Morton:
  o cdev: warning fix

Chris Wright:
  o class_simple cleanup in sg
  o class_simple cleanup in misc
  o class_simple cleanup in input
  o class_simple clean up in lp
  o Patch to hook up PPP to simple class sysfs support

Greg Kroah-Hartman:
  o kref: add kref structure to kernel tree
  o remove cdev_set_name completely as it is not needed
  o PCI Hotplug: use the new decl_subsys_name() macro instead of rolling our own
  o Kobject: add decl_subsys_name() macro for users who want to set the subsystem name
  o Driver core: make CONFIG_DEBUG_DRIVER implementation a whole lot cleaner

Jonathan Corbet:
  o cdev 2/2: hide cdev->kobj
  o cdev 1/2: Eliminate /sys/cdev

Leann Ogasawara:
  o add sysfs simple class support for DRI char device
  o Fix class_register() always returns 0
  o Add sysfs simple class support for netlink

