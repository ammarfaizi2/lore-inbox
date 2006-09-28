Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWI1SXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWI1SXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWI1SXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:23:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9961 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964932AbWI1SXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:23:41 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 28 Sep 2006 20:22:07 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [GIT PULL] ieee1394 updates post 2.6.18
To: Linus Torvalds <torvalds@osdl.org>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <tkrat.33121604711a7251@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from the upstream-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git upstream-linus

to receive IEEE 1394 subsystem updates as listed further below.

What's in there:

  - bug fixes to sbp2
  - locking fixes in ieee1394 and in raw1394
  - other small bug fixes across the subsystem, code cleanups
  - API conversions: replacements of semaphores by mutexes or
    waitqueues, replacements of kernel_thread()
  - new feature: support of poll operation on /dev/video1349

All patches lived in -mm for a while, most of them since about their
authorship date.

Caution, I am now committing to this tree too, besides Ben C.
I hope I handled git correctly. Things to watch out for:

  - Merge commit 9b4f2e9576658c4e52d95dc8d309f51b2e2db096 contains a
    conflict resolution in ieee1394_core.c.
  - Patch "ieee1394: sbp2: enable auto spin-up for Maxtor disks" was
    applied as a mailed patch to your tree in parallel to
    linux1394-2.6.git, thus shows up in 'git log' although it isn't
    effectively in the diff.
  - 'git diff -M --stat --summary mainline..upstream-linus' gives
    slightly different results than a diff between checkouts of mainline
    and upstream-linus. (I have branch mainline only local, not on
    kernel.org.) I cross-checked the checkout with a separate quilt-
    managed tree and it is fine.

Stat from git diff:

 Documentation/feature-removal-schedule.txt |    9 -
 MAINTAINERS                                |   37 +-
 drivers/ieee1394/Kconfig                   |   11 +
 drivers/ieee1394/csr.c                     |   31 +-
 drivers/ieee1394/csr.h                     |  109 +++---
 drivers/ieee1394/dma.c                     |    7 
 drivers/ieee1394/dma.h                     |   90 +++--
 drivers/ieee1394/dv1394-private.h          |    6 
 drivers/ieee1394/dv1394.c                  |   47 +--
 drivers/ieee1394/eth1394.c                 |   12 -
 drivers/ieee1394/highlevel.h               |  201 ++++++------
 drivers/ieee1394/hosts.c                   |   23 +
 drivers/ieee1394/hosts.h                   |   51 +--
 drivers/ieee1394/ieee1394-ioctl.h          |    9 -
 drivers/ieee1394/ieee1394.h                |  316 +++++++++---------
 drivers/ieee1394/ieee1394_core.c           |    9 -
 drivers/ieee1394/ieee1394_core.h           |   28 +-
 drivers/ieee1394/ieee1394_hotplug.h        |   30 --
 drivers/ieee1394/ieee1394_transactions.c   |  114 ++++---
 drivers/ieee1394/ieee1394_transactions.h   |   41 +-
 drivers/ieee1394/ieee1394_types.h          |   68 +---
 drivers/ieee1394/iso.c                     |    5 
 drivers/ieee1394/iso.h                     |   87 +++--
 drivers/ieee1394/nodemgr.c                 |  227 +++++--------
 drivers/ieee1394/nodemgr.h                 |   27 +-
 drivers/ieee1394/ohci1394.c                |   73 ++--
 drivers/ieee1394/raw1394-private.h         |    3 
 drivers/ieee1394/raw1394.c                 |  138 +++++---
 drivers/ieee1394/sbp2.c                    |  481 ++++++++++++++--------------
 drivers/ieee1394/sbp2.h                    |   37 +-
 drivers/ieee1394/video1394.c               |   52 +++
 31 files changed, 1210 insertions(+), 1169 deletions(-)

The log, sans merge commits:

Adrian Bunk:
    the scheduled removal of drivers/ieee1394/sbp2.c:force_inquiry_hack

Alexey Dobriyan:
    CONFIG_PM=n slim: drivers/ieee1394/ohci1394.c

Pavel Machek:
    set power state of firewire host during suspend

Andi Kleen:
    Initialize ieee1394 early when built in

David Moore:
    video1394: add poll file operation support

Stefan Richter:
    ieee1394: raw1394: arm functions slept in atomic context
    ieee1394: sbp2: enable auto spin-up for all SBP-2 devices
    MAINTAINERS: updates to IEEE 1394 subsystem maintainership
    ieee1394: ohci1394: check for errors in suspend or resume
    ieee1394: ohci1394: more obvious endianess handling
    ieee1394: ohci1394: fix endianess bug in debug message
    ieee1394: sbp2: don't prefer MODE SENSE 10
    ieee1394: nodemgr: grab class.subsys.rwsem in nodemgr_resume_ne
    ieee1394: nodemgr: fix rwsem recursion
    ieee1394: sbp2: more help in Kconfig
    ieee1394: sbp2: prevent rare deadlock in shutdown
    ieee1394: sbp2: update includes
    ieee1394: sbp2: better handling of transport errors
    ieee1394: sbp2: recheck node generation in sbp2_update
    ieee1394: sbp2: safer agent reset in error handlers
    ieee1394: sbp2: handle "sbp2util_node_write_no_wait failed"
    ieee1394: safer definition of empty macros
    ieee1394: sbp2: convert sbp2util_down_timeout to waitqueue
    ieee1394: sbp2: more checks of status block
    ieee1394: sbp2: safer initialization of status fifo
    ieee1394: sbp2: optimize DMA direction of command ORBs
    ieee1394: sbp2: discard return value of sbp2_link_orb_command
    ieee1394: sbp2: safer last_orb and next_ORB handling
    ieee1394: remove #include <asm/semaphore.h>
    ieee1394: shrink tlabel pools, remove tpool semaphores
    [PATCH] ieee1394: fix kerneldoc of hpsb_alloc_host
    [PATCH] ieee1394: nodemgr: convert nodemgr_serialize semaphore to mutex
    [PATCH] ieee1394: nodemgr: switch to kthread api, replace reset semaphore
    [PATCH] ieee1394: nodemgr: make module parameter ignore_drivers writable
    [PATCH] ieee1394: nodemgr: do not spawn kernel_thread for sysfs rescan
    [PATCH] ieee1394: nodemgr: remove unnecessary includes
    [PATCH] ieee1394: raw1394: remove redundant counting semaphore
    [PATCH] ieee1394: dv1394: sem2mutex conversion
    [PATCH] ieee1394: clean up declarations of hpsb_*_config_rom
    [PATCH] ieee1394: remove unused macros HPSB_PANIC and HPSB_TRACE
    [PATCH] ieee1394: remove redundant code from ieee1394_hotplug.h
    [PATCH] ieee1394: update #include directives in midlayer header files
    [PATCH] ieee1394: coding style and comment fixes in midlayer header files
    [PATCH] ieee1394: replace __inline__ by inline
    [PATCH] ieee1394: skip dummy loop in build_speed_map
    [PATCH] ieee1394: fix calculation of csr->expire
    [PATCH] ieee1394: fix cosmetic problem in speed probe

-- 
Stefan Richter
-=====-=-==- =--= ===--
http://arcgraph.de/sr/

