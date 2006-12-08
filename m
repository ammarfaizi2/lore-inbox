Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164198AbWLHANi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164198AbWLHANi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164195AbWLHANi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:13:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58304 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164192AbWLHANg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:13:36 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4578AE0D.4090301@s5r6.in-berlin.de>
Date: Fri, 08 Dec 2006 01:13:01 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ieee1394 updates post 2.6.19
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from the for-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git for-linus

to receive IEEE 1394 subsystem updates as listed further below.


What's in there:  Alas not as many bug fixes as in previous submissions...

 - partial support for suspend/ resume*
 - locking fixes in the ieee1394 core
 - leftovers from 2.6.19: handle sysfs error returns
 - code cleanups, the bulk of it in sbp2
 - defer removal of some obsolete ABI features of raw1394 once more
 - announce deprecation of dv1394 and of some less relevant bits**


   *) There is still some high-level functionality missing for full suspend/
      resume support.

  **) The functionality of the dv1394 driver is now provided by raw1394 +
      libiec61883.


Most of it has been in -mm for a while; the bulk has been around since
September... early November.

I pulled your master branch a few hours ago and built the for-linus branch
on top of it, so I hope you can apply it without intervention.

 Documentation/feature-removal-schedule.txt |   38
 drivers/ieee1394/Kconfig                   |   26
 drivers/ieee1394/Makefile                  |    5
 drivers/ieee1394/csr.c                     |    8
 drivers/ieee1394/dv1394.c                  |   24
 drivers/ieee1394/eth1394.c                 |    4
 drivers/ieee1394/highlevel.h               |    1
 drivers/ieee1394/hosts.c                   |   41 -
 drivers/ieee1394/ieee1394_core.c           |    4
 drivers/ieee1394/nodemgr.c                 |  465 ++++--
 drivers/ieee1394/nodemgr.h                 |    7
 drivers/ieee1394/ohci1394.c                |  140 +-
 drivers/ieee1394/pcilynx.c                 |    3
 drivers/ieee1394/raw1394-private.h         |   10
 drivers/ieee1394/raw1394.c                 |   23
 drivers/ieee1394/sbp2.c                    | 2190 ++++++++++------------------
 drivers/ieee1394/sbp2.h                    |  311 ++--
 drivers/ieee1394/video1394.c               |   54 -
 18 files changed, 1444 insertions(+), 1910 deletions(-)


Alexey Dobriyan:
      ohci1394: shortcut irq printing

Ben Collins:
      ieee1394: Consolidate driver registering

Bernhard Kaindl:
      ohci1394: steps to implement suspend/resume

Daniel Drake:
      video1394: small optimizations to frame retrieval codepath
      video1394: remove BKL contention

Eric Sesterhenn:
      drivers/ieee1394/*: use kmemdup()

Luca Tettamanti:
      sbp2: make 1bit bitfield unsigned

Randy Dunlap:
      ieee1394: fix printk format warning
      ieee1394: only build OUI database files if config enabled

Stefan Richter:
      ieee1394: remove unused struct member from highlevel API
      ieee1394: sbp2: slightly reorder sbp2scsi_abort
      ieee1394: raw1394: add comments on lock usage
      ieee1394: ohci1394: suspend/resume cosmetics
      ieee1394: usecs_to_jiffies takes unsigned int argument
      ieee1394: lock smaller region by host_num_alloc mutex
      ieee1394: coding style in hosts.c
      ieee1394: handle sysfs errors
      dv1394: remove BKL contention
      ieee1394: nodemgr: small fix after sysfs errors patch
      ieee1394: nodemgr: reflect which return values are errors
      ieee1394: nodemgr: revise semaphore protection of driver core data
      ieee1394: ohci1394: revert fail on error in suspend
      ieee1394: ohci1394: proper log messages in suspend and resume
      ieee1394: nodemgr: take it easy if bus_rescan_devices fails
      ieee1394: sbp2: remove irritating log message
      ieee1394: sbp2: clean up function declarations
      ieee1394: sbp2: remove dead code
      ieee1394: sbp2: remove duplicate code
      ieee1394: sbp2: consolidate log levels
      ieee1394: sbp2: remove debug macros
      ieee1394: sbp2: coding style of some macros
      ieee1394: sbp2: delayed_work -> work_struct
      ieee1394: sbp2: remove superfluous comments
      ieee1394: sbp2: some conditions in queue_command are unlikely
      ieee1394: sbp2: clean up sbp2_ namespace
      ieee1394: sbp2: proper unit in module parameter description
      ieee1394: sbp2: remove unused struct members
      ieee1394: sbp2: more concise names for types and variables
      ieee1394: sbp2: use list_move_tail()
      ieee1394: sbp2: update comment on things to do
      ieee1394: sbp2: wrap two functions into one
      ieee1394: ohci1394: add PPC_PMAC platform code to driver probe
      ieee1394: ohci1394: reformat PPC_PMAC platform code
      ieee1394: ohci1394: call PMac code in shutdown only for proper machines
      ieee1394: raw1394: defer feature removal of old isoch interface
      ieee1394: dv1394: schedule for feature removal
      ieee1394: schedule unused symbol exports for removal
      ieee1394: schedule *_oui sysfs attributes for removal
      ieee1394: nodemgr: remove duplicate assignment
      ieee1394: nodemgr: fix deadlock in shutdown
      ieee1394: nodemgr: spaces to tabs
      ieee1394: sbp2: convert from PCI DMA to generic DMA
      ieee1394: conditionally export ieee1394_bus_type
      ieee1394: nodemgr: remove a kcalloc
      ieee1394: sbp2: code formatting around work_struct stuff


-- 
Stefan Richter
-=====-=-==- ==-- -=---
http://arcgraph.de/sr/
