Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVCJAzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVCJAzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVCJAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:50:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:59295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262633AbVCJAme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:34 -0500
Date: Wed, 9 Mar 2005 16:34:03 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver core and kobject updates for 2.6.11
Message-ID: <20050310003403.GA32215@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some driver core and kobject/kref updates for 2.6.11.  They
have all been in the -mm releases for some time now.  There is also a
documentation update for the schedule removal feature list.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/2.6.11/driver

Individual patches will follow, sent to the linux-kernel list.

thanks,

greg k-h

 Documentation/feature-removal-schedule.txt |   23 +++++-
 drivers/base/bus.c                         |    4 -
 drivers/base/class.c                       |   98 +++++++++++++----------------
 drivers/base/class_simple.c                |   21 ------
 drivers/base/driver.c                      |   13 +--
 drivers/base/map.c                         |   21 ++----
 drivers/base/platform.c                    |    2 
 drivers/base/sys.c                         |   39 +++++------
 drivers/block/floppy.c                     |   19 +----
 drivers/block/genhd.c                      |   55 ++++++++++------
 drivers/i2c/i2c-dev.c                      |    9 --
 drivers/media/video/videodev.c             |   11 ---
 drivers/usb/core/file.c                    |   64 +++++-------------
 fs/char_dev.c                              |   26 ++-----
 include/linux/device.h                     |    5 -
 include/linux/kobj_map.h                   |    2 
 include/linux/kobject.h                    |    2 
 include/linux/kref.h                       |    2 
 lib/kobject.c                              |   15 ++--
 lib/kref.c                                 |   11 ++-
 20 files changed, 202 insertions(+), 240 deletions(-)
-----


Arjan van de Ven:
  o Kobject: remove some unneeded exports

Dominik Brodowski:
  o cpufreq 2.4 interface removal schedule

Greg Kroah-Hartman:
  o class: add a semaphore to struct class, and use that instead of the subsystem rwsem
  o sysdev: remove the rwsem usage from this subsystem
  o sysdev: fix the name of the list of drivers to be a sane name
  o kmap: remove usage of rwsem from kobj_map
  o USB: move usb core to use class_simple instead of it's own class functions
  o kref: make kref_put return if this was the last put call
  o sysdev: make system_subsys static as no one else needs access to it
  o kset: make ksets have a spinlock, and use that to lock their lists

Kay Sievers:
  o floppy.c: pass physical device to device registration
  o Driver core: add "bus" symlink to class/block devices
  o videodev: pass dev_t to the class core
  o i2c: class driver pass dev_t to the class core
  o usb: class driver pass dev_t to the class core
  o class_simple: pass dev_t to the class core
  o block core: export MAJOR/MINOR to the hotplug env
  o class core: export MAJOR/MINOR to the hotplug env

Mike Waychison:
  o driver core: clean driver unload

Randy Dunlap:
  o Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule

Russell King:
  o driver core: Separate platform device name from platform device number

