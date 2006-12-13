Return-Path: <linux-kernel-owner+w=401wt.eu-S965096AbWLMTwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWLMTwu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWLMTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:52:50 -0500
Received: from mail.suse.de ([195.135.220.2]:45381 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965096AbWLMTwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:52:49 -0500
Date: Wed, 13 Dec 2006 11:52:26 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061213195226.GA6736@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more driver core patches for 2.6.19

They contain:
	- minor driver core bugfixes and memory savings
	- debugfs bugfixes and inotify support added.
	- userspace io driver interface added.  This allows the ability
	  to write userspace drivers for some types of hardware much
	  easier than before, going through a simple interface to get
	  accesses to irqs and memory regions.  A small kernel portion
	  is still needed to handle the irq properly, but that is it.
	- other minor cleanups and fixes.

All of these patches have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h

 Documentation/DocBook/kernel-api.tmpl |    4 +
 Documentation/DocBook/uio-howto.tmpl  |  434 +++++++++++++++++++++++
 drivers/Kconfig                       |    1 +
 drivers/Makefile                      |    1 +
 drivers/base/class.c                  |    2 +
 drivers/base/platform.c               |    4 +-
 drivers/uio/Kconfig                   |   39 ++
 drivers/uio/Makefile                  |    4 +
 drivers/uio/uio.c                     |  618 +++++++++++++++++++++++++++++++++
 drivers/uio/uio_dummy.c               |  174 +++++++++
 drivers/uio/uio_events.c              |  119 +++++++
 drivers/uio/uio_irq.c                 |   86 +++++
 drivers/uio/uio_parport.c             |   84 +++++
 fs/debugfs/inode.c                    |   39 ++-
 include/linux/platform_device.h       |    2 +-
 include/linux/uio_driver.h            |   71 ++++
 kernel/module.c                       |   25 ++
 kernel/power/Kconfig                  |    9 +-
 18 files changed, 1700 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/DocBook/uio-howto.tmpl
 create mode 100644 drivers/uio/Kconfig
 create mode 100644 drivers/uio/Makefile
 create mode 100644 drivers/uio/uio.c
 create mode 100644 drivers/uio/uio_dummy.c
 create mode 100644 drivers/uio/uio_events.c
 create mode 100644 drivers/uio/uio_irq.c
 create mode 100644 drivers/uio/uio_parport.c
 create mode 100644 include/linux/uio_driver.h

---------------

Akinobu Mita (1):
      driver core: delete virtual directory on class_unregister()

Andrew Morton (1):
      Driver core: "platform_driver_probe() can save codespace": save codespace

David Brownell (1):
      Driver core: deprecate PM_LEGACY, default it to N

Hans J. Koch (4):
      UIO: Add the User IO core code
      UIO: Documentation
      UIO: dummy test module for the uio core
      UIO: irq test module for the uio core

Kay Sievers (1):
      Driver core: show "initstate" of module

Mathieu Desnoyers (5):
      DebugFS : inotify create/mkdir support
      DebugFS : coding style fixes
      DebugFS : file/directory creation error handling
      DebugFS : more file/directory creation error handling
      DebugFS : file/directory removal fix

Scott Wood (1):
      Driver core: Make platform_device_add_data accept a const pointer

