Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUJVXQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUJVXQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUJVXQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:16:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:19107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268710AbUJVXKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:17 -0400
Date: Fri, 22 Oct 2004 16:09:00 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041022230900.GA27093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few minot driver core changes for 2.6.10-rc1 that were laying
around and didn't make it in the last big batch of merges.  Most of
these have been in the -mm tree for a while now.

No, they don't include the backing store sysfs patches, I'll get to
those next week.  I'll be in the same building as Maneesh, so I know
he'll be hounding me about them... :)

Oh, and these patches will cause the wait_for_sysfs program in udev to
start spiting out a lot more warnings.  It's not a bug in the kernel,
it's a userspace issue.  I'll get that fixed up in the next udev
release.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/base/bus.c                     |    4 +--
 drivers/base/class.c                   |    4 +--
 drivers/base/core.c                    |    2 -
 drivers/base/cpu.c                     |    2 +
 drivers/firmware/efivars.c             |    2 -
 drivers/pci/hotplug/pci_hotplug_core.c |    2 -
 fs/char_dev.c                          |    4 +--
 fs/sysfs/dir.c                         |    2 -
 include/linux/kobject_uevent.h         |    1 
 kernel/cpu.c                           |   35 ----------------------------
 kernel/module.c                        |    2 -
 lib/Kconfig.debug                      |    7 +++++
 lib/Makefile                           |    7 ++++-
 lib/kobject.c                          |    4 ---
 lib/kobject_uevent.c                   |   40 ++++++++++++++++++++-------------
 15 files changed, 53 insertions(+), 65 deletions(-)
-----

Andrew Morton:
  o kobject_uevent warning fix
  o kobject_hotplug: permit no hotplug_ops

Anil Keshavamurthy:
  o remove cpu_run_sbin_hotplug()

Greg Kroah-Hartman:
  o hotplug: prevent skips in sequence number from happening
  o kobject: add CONFIG_DEBUG_KOBJECT

Stephen Hemminger:
  o avoid problems with kobject_set_name and name with %
  o cdev: protect against buggy drivers

