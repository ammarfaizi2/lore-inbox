Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUENXGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUENXGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUENXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:06:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:23260 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262422AbUENXGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:06:46 -0400
Date: Fri, 14 May 2004 16:06:10 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core patches for 2.6.6
Message-ID: <20040514230610.GA17907@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are lots of fun changes related to the driver core and sysfs for
2.6.6.  They include adding the module param info to sysfs, more
class_simple changes, a smbios driver, and some sysfs bug fixes.

All of these patches have been in the -mm tree for a number of releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/bus.c           |   32 +++-
 drivers/base/class.c         |    6 
 drivers/base/map.c           |    7 
 drivers/base/platform.c      |    5 
 drivers/base/sys.c           |    5 
 drivers/block/paride/pg.c    |   48 +++++-
 drivers/block/paride/pt.c    |   54 ++++++-
 drivers/char/ip2main.c       |   44 +++++-
 drivers/char/ppdev.c         |   45 +++++-
 drivers/char/tipar.c         |   49 +++++-
 drivers/firmware/Kconfig     |   16 ++
 drivers/firmware/Makefile    |    1 
 drivers/firmware/smbios.c    |  310 ++++++++++++++++++++++++++++++++++++++-----
 drivers/firmware/smbios.h    |   53 +++++++
 drivers/macintosh/adb.c      |   19 +-
 drivers/misc/Kconfig         |    8 -
 drivers/misc/ibmasm/module.c |    7 
 drivers/net/wan/cosa.c       |   41 ++++-
 fs/sysfs/bin.c               |    2 
 fs/sysfs/dir.c               |   19 +-
 fs/sysfs/file.c              |    2 
 fs/sysfs/sysfs.h             |   13 +
 include/linux/device.h       |    2 
 include/linux/kobject.h      |    2 
 include/linux/module.h       |   25 +++
 include/linux/moduleparam.h  |    4 
 include/linux/sysfs.h        |    2 
 kernel/module.c              |  194 ++++++++++++++++++++++++--
 kernel/params.c              |    2 
 lib/kobject.c                |   10 -
 net/core/dev.c               |   18 +-
 31 files changed, 917 insertions(+), 128 deletions(-)
-----

<kenn:linux.ie>:
  o Re: Platform device matching

Daniele Bellucci:
  o missing audit in bus_register()

Greg Kroah-Hartman:
  o Module attributes: fix build error if CONFIG_MODULE_UNLOAD=n
  o Add modules to sysfs
  o Driver core: handle error if we run out of memory in kmap code
  o My cleanups to the smbios driver

Hanna V. Linder:
  o Add class support to drivers/net/wan/cosa.c
  o add class support to drivers/char/tipar.c
  o add class support to drivers/block/paride/pt.c
  o add class support to drivers/block/paride/pg.c
  o Add class support to drivers/char/ip2main.c

James Bottomley:
  o fix dev_printk to work even in the absence of an attached driver

Maneesh Soni:
  o sysfs_rename_dir-cleanup
  o kobject/sysfs race fix
  o kobject_set_name - error handling

Marcel Sebek:
  o Class support for ppdev.c

Max Asbock:
  o add ibmasm driver warning message

Michael E. Brown:
  o add SMBIOS tables to sysfs -- UPDATED

Olaf Hering:
  o add simple class for adb

