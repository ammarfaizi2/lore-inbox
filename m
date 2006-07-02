Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWGBWxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWGBWxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWGBWxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:53:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9941 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751036AbWGBWxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:53:19 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 00:53:01 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 00/19] ieee1394: misc updates
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.902) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

here are a few new, updated, or resent patches, most of them janitorial.
I created them against 2.6.17-git18 but tested on 2.6.16.x. If they are
OK with you, please apply them to your 1394 tree (after you resynced from
Linus) for Andrew to pull eventually.

small fixes
-----------
01/19 (old) ieee1394: sbp2: enable auto spin-up for Maxtor disks
02/19 (old) ieee1394: fix calculation of csr->expire
03/19 (new) ieee1394: fix cosmetic problem in speed probe

cleanups
--------
05/19 (new) ieee1394: replace __inline__ by inline
06/19 (new) ieee1394: coding style and comment fixes in midlayer header files
07/19 (new) ieee1394: update #include directives in midlayer header files
08/19 (new) ieee1394: remove redundant code from ieee1394_hotplug.h
09/19 (new) ieee1394: remove unused macros HPSB_PANIC and HPSB_TRACE
10/19 (new) ieee1394: clean up declarations of hpsb_*_config_rom

API conversions and related cleanups
------------------------------------
11/19 (old) ieee1394: dv1394: sem2mutex conversion
12/19 (upd) ieee1394: raw1394: remove redundant counting semaphore
13/19 (old) ieee1394: nodemgr: remove unnecessary includes
14/19 (old) ieee1394: nodemgr: do not spawn kernel_thread for sysfs rescan
15/19 (old) ieee1394: nodemgr: make module parameter ignore_drivers writable
16/19 (upd) ieee1394: nodemgr: switch to kthread api, replace reset semaphore
17/19 (old) ieee1394: nodemgr: convert nodemgr_serialize semaphore to mutex
18/19 (new) ieee1394: fix kerneldoc of hpsb_alloc_host

API conversion, struct hpsb_host size reduction
-----------------------------------------------
19/19 (upd) ieee1394: shrink tlabel pools, remove tpool semaphores

Patch 11/19 is trivial but untested except for loading the driver,
writing into its character device, and unloading it.

Patch 16/19 was condensed from two previously posted patches.  I merged
them because the first stage of the two used kthread_stop_sem() which
may vanish from the kernel API at some point.

Patch 19/19 replaces four previously posted patches.  They all touched
the same code regions, so there was not much point to keep them
separate.  Among other , this updated version incorporates your
suggestion to make tlabel related sysfs attributes only conditionally
available as debug code.

The patches are mostly stand-alone WRT what they do; however they apply
most easily in above order.  After this patch series, the 1394 drivers
are completely converted to the kthread API, and all semaphores are
removed except for some last few RW semaphores (hl_drivers_sem in
highlevel.c, driver core's subsys RW semaphores in nodemgr.c).

 drivers/ieee1394/csr.c                   |   31 --
 drivers/ieee1394/csr.h                   |  107 ++++---
 drivers/ieee1394/dma.c                   |    7
 drivers/ieee1394/dma.h                   |   88 ++++--
 drivers/ieee1394/dv1394-private.h        |    6
 drivers/ieee1394/dv1394.c                |   43 +--
 drivers/ieee1394/eth1394.c               |   11
 drivers/ieee1394/highlevel.h             |  207 +++++++--------
 drivers/ieee1394/hosts.c                 |    7 -
 drivers/ieee1394/hosts.h                 |   51 +--
 drivers/ieee1394/ieee1394-ioctl.h        |    9
 drivers/ieee1394/ieee1394.h              |  314 +++++++++++------------
 drivers/ieee1394/ieee1394_core.c         |    4
 drivers/ieee1394/ieee1394_core.h         |   27 +
 drivers/ieee1394/ieee1394_hotplug.h      |   30 --
 drivers/ieee1394/ieee1394_transactions.c |  114 ++++----
 drivers/ieee1394/ieee1394_transactions.h |   41 +--
 drivers/ieee1394/ieee1394_types.h        |   66 +---
 drivers/ieee1394/iso.c                   |    5
 drivers/ieee1394/iso.h                   |   87 +++---
 drivers/ieee1394/nodemgr.c               |  216 ++++++---------
 drivers/ieee1394/nodemgr.h               |   27 -
 drivers/ieee1394/ohci1394.c              |    5
 drivers/ieee1394/raw1394-private.h       |    3
 drivers/ieee1394/raw1394.c               |  102 ++++---
 drivers/ieee1394/sbp2.c                  |    7
 drivers/ieee1394/video1394.c             |   12
 27 files changed, 811 insertions(+), 816 deletions(-)

-- 
Stefan Richter
-=====-=-==- -=== ---==
http://arcgraph.de/sr/

