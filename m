Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWDNUBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWDNUBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWDNUBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:01:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:39388 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965096AbWDNUBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:01:42 -0400
Date: Fri, 14 Apr 2006 13:00:37 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core and sysfs patches for 2.6.17-rc1
Message-ID: <20060414200037.GA5478@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core and sysfs patches for 2.6.17-rc1.  They contain
the following changes:
	- allow sysfs files to be polled (this missed the initial
	  2.6.16-git merge due to the patch being reworked by Neil.  It
	  has been included in the -mm tree for a number of months now
	  with no reported issues.  Sorry for missing this one the first
	  time around this cycle)
	- fix bug in manual binding of devices to drivers.
	- report the offending driver when suspend fails
	- fix partition scanning and reporting to userspace (was being
	  reported before the scanning was finished, which isn't very
	  nice.)
	- few other minor bugfixes and build fixes.

All of these patches have been in the -mm tree for a number of weeks, if
not months (in the case of the sysfs poll patch).

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 arch/i386/kernel/Makefile    |    2 -
 arch/ia64/kernel/Makefile    |    3 -
 arch/x86_64/kernel/Makefile  |    4 --
 drivers/base/bus.c           |    5 ++
 drivers/base/class.c         |   13 +++----
 drivers/base/dd.c            |    2 -
 drivers/base/power/suspend.c |   12 ++++++
 drivers/firmware/Makefile    |    3 +
 drivers/firmware/dmi_scan.c  |   12 +++---
 drivers/md/md.c              |    1 
 drivers/pci/pci-driver.c     |    6 ++-
 drivers/pci/pci.c            |    6 ++-
 drivers/usb/core/hcd-pci.c   |    7 +--
 fs/partitions/check.c        |   38 ++++++++++++++++-----
 fs/sysfs/dir.c               |    1 
 fs/sysfs/file.c              |   76 +++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/sysfs.h             |    1 
 include/linux/genhd.h        |    1 
 include/linux/kobject.h      |    2 +
 include/linux/pm.h           |    8 ++++
 include/linux/sysfs.h        |    6 +++
 lib/kobject.c                |    1 
 22 files changed, 173 insertions(+), 37 deletions(-)

---------------

Alan Stern:
      driver core: safely unbind drivers for devices not on a bus

Andrew Morton:
      pm: print name of failed suspend function

Bjorn Helgaas:
      DMI: move dmi_scan.c from arch/i386 to drivers/firmware/

Jayachandran C:
      driver core: fix unnecessary NULL check in drivers/base/class.c

Kay Sievers:
      BLOCK: delay all uevents until partition table is scanned

NeilBrown:
      sysfs: Allow sysfs attribute files to be pollable

Ryan Wilson:
      driver core: driver_bind attribute returns incorrect value

