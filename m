Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWBFU2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWBFU2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWBFU2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:28:17 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:59043
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964784AbWBFU2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:28:15 -0500
Date: Mon, 6 Feb 2006 12:28:30 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core fixes for 2.6.16-rc2
Message-ID: <20060206202830.GA5202@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core fixes for 2.6.16-rc2.  They have all been in
the last -mm with no problems.  They contain the following things:
	- buffer overflow from input MODALIAS expansion
	- spi Kconfig fixes
	- fix IB and DRM's usage of sysfs dev files (both acked by the
	  various subsystem maintainers).
	- oops fix in driver core with power files
	- build warning fixes
	- make it harder to use kobjects incorrectly (fixes an oops).

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The full patch set will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/spi/butterfly   |   23 +++++--
 drivers/base/base.h           |    4 +
 drivers/base/bus.c            |    3 
 drivers/base/power/resume.c   |    3 
 drivers/base/power/shutdown.c |    2 
 drivers/base/power/suspend.c  |    3 
 drivers/base/power/sysfs.c    |   24 +++++--
 drivers/base/sys.c            |    3 
 drivers/char/drm/drmP.h       |   10 +--
 drivers/char/drm/drm_stub.c   |    2 
 drivers/char/drm/drm_sysfs.c  |  129 +++++++++---------------------------------
 drivers/infiniband/core/ucm.c |   13 ----
 drivers/spi/Kconfig           |   10 ---
 drivers/spi/spi_butterfly.c   |   36 +++++------
 fs/debugfs/file.c             |    6 -
 lib/kobject.c                 |    9 ++
 lib/kobject_uevent.c          |    2 
 17 files changed, 111 insertions(+), 171 deletions(-)
Adrian Bunk:
      drivers/base/: proper prototypes

Benjamin Herrenschmidt:
      Fix uevent buffer overflow in input layer

Chuck Ebbert:
      kobject: don't oops on null kobject.name

David Brownell:
      SPI: spi_butterfly, restore lost deltas

Greg Kroah-Hartman:
      DRM: fix up classdev interface for drm core
      IB: fix up major/minor sysfs interface for IB core
      kobject_add() must have a valid name in order to succeed.

Pavel Machek:
      Fix Userspace interface breakage in power/state

Russell King:
      Fix compiler warning in driver core for CONFIG_HOTPLUG=N

Vincent Hanquez:
      debugfs: trivial comment fix

