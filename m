Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbUKEAzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbUKEAzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUKEAyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:54:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:5343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262531AbUKEAt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:26 -0500
Date: Thu, 4 Nov 2004 16:47:46 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] More Driver Core patches for 2.6.10-rc1
Message-ID: <20041105004746.GB31842@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more driver core and sysfs fixes for 2.6.10-rc1.  They fix
a number of little bugs that people have been reporting over the past
week with the recent sysfs changes, and also the kevent changes.  The
kevent stuff also now has a proper MAINTAINERS entry, and we now export
a few more environment variables through the hotplug interface to make
userspace programs have an easier time trying to figure out how to deal
with devices properly.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 MAINTAINERS           |    6 ++
 drivers/base/bus.c    |  101 +++++++++++++++++++++++++++++---------------------
 drivers/base/class.c  |   26 ++++++++++++
 drivers/base/core.c   |    6 +-
 drivers/block/genhd.c |   40 +++++++++++++++++++
 fs/sysfs/dir.c        |    6 +-
 fs/sysfs/file.c       |    4 +
 fs/sysfs/inode.c      |    5 --
 fs/sysfs/mount.c      |    2 
 fs/sysfs/symlink.c    |   17 ++++----
 fs/sysfs/sysfs.h      |    2 
 lib/kobject.c         |    1 
 lib/kobject_uevent.c  |    8 +--
 13 files changed, 154 insertions(+), 70 deletions(-)
-----

Adrian Bunk:
  o small sysfs cleanups

Greg Kroah-Hartman:
  o kevent: fix build error if CONFIG_KOBJECT_UEVENT is not selected

Kay Sievers:
  o add the physical device and the bus to the hotplug environment

Maneesh Soni:
  o fix kernel BUG at fs/sysfs/dir.c:20!
  o sysfs: fix sysfs backing store error path confusion

Robert Love:
  o kobject_uevent: add MAINTAINER entry
  o kobject_uevent: fix init ordering

Tejun Heo:
  o driver-model: device_add() error path reference counting fix
  o driver-model: kobject_add() error path reference counting fix
  o driver-model: sysfs_release() dangling pointer reference fix
  o driver-model: bus_recan_devices() locking fix
  o driver-model: comment fix in bus.c

