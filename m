Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266935AbUKAXBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266935AbUKAXBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S380187AbUKAXAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:00:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:8865 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323213AbUKAVzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:55:09 -0500
Date: Mon, 1 Nov 2004 13:54:18 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041101215418.GA16500@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some driver core patches for 2.6.10-rc1.  The majority of them
have all been in the -mm tree for a while.  They contain:
	- bugfix for the hotplug calls that was breaking all firmware
	  downloads.
	- sysfs backing patches.  Finally Maneesh can rest...
	- add a "driver" symlink in devices to make it easier to
	  determine what driver is bound to a specific device.
	- other bugfixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/bus.c             |   61 +++---
 drivers/base/power/main.c      |   11 -
 drivers/base/power/power.h     |    5 
 drivers/base/power/resume.c    |   16 +
 drivers/base/power/suspend.c   |   44 ++--
 drivers/input/input.c          |    2 
 drivers/input/serio/serio.c    |    7 
 drivers/pnp/pnpbios/core.c     |    2 
 drivers/s390/crypto/z90main.c  |    1 
 fs/sysfs/bin.c                 |   60 ++----
 fs/sysfs/dir.c                 |  379 +++++++++++++++++++++++++++++++++++------
 fs/sysfs/file.c                |   98 +++++-----
 fs/sysfs/group.c               |    4 
 fs/sysfs/inode.c               |  102 ++++++++---
 fs/sysfs/mount.c               |   12 +
 fs/sysfs/symlink.c             |   65 ++++---
 fs/sysfs/sysfs.h               |   81 ++++++++
 include/linux/device.h         |    4 
 include/linux/kmod.h           |    4 
 include/linux/kobject_uevent.h |    5 
 include/linux/sysfs.h          |   19 ++
 kernel/cpu.c                   |    1 
 kernel/kmod.c                  |   23 --
 kernel/sysctl.c                |    2 
 lib/kobject_uevent.c           |   48 +++--
 25 files changed, 742 insertions(+), 314 deletions(-)
-----

Dmitry Torokhov:
  o Driver core: add driver symlink to device
  o Driver core: add driver_probe_device
  o Driver core: export device_attach

Kay Sievers:
  o take me home, hotplug_path[]
  o kobject: fix hotplug bug with seqnum

Maneesh Soni:
  o sysfs backing store: stop pinning dentries/inodes for leaf entries
  o sysfs backing store: use sysfs_dirent based tree in dir file operations
  o sysfs backing store: use sysfs_dirent based tree in file removal
  o sysfs backing store - add sysfs_direct structure
  o fix oops with firmware loading
  o sysfs backing store - prepare sysfs_file_operations helpers

Paul Mackerras:
  o Fix deadlocks on dpm_sem

Simon Derr:
  o Possible race in sysfs_read_file() and sysfs_write_file()
  o Fix race in sysfs_read_file() and sysfs_write_file()

