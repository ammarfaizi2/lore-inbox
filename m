Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVCJLzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVCJLzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 06:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCJLzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 06:55:24 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:28889 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262534AbVCJLyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 06:54:51 -0500
Date: Thu, 10 Mar 2005 11:54:50 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] drm tree for 2.6.12
Message-ID: <Pine.LNX.4.58.0503101146020.455@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The latest DRM tree is ready (bit late but I got there..), it contains
updated radeon driver, splitting of drm structure to allow for multi-head
(no drivers just internal structure changes, credits updates, static
function updates and pci ids update.

The patch is up at

http://www.skynet.ie/~airlied/patches/lk_drm/drm_2_6_12_heads_fixes.patch

The BK Tree is at:
	bk pull bk://drm.bkbits.net/drm-linus

This will include the latest DRM changes and will update the following files:

 CREDITS                           |    5
 MAINTAINERS                       |    4
 drivers/char/drm/drmP.h           |   42 +++---
 drivers/char/drm/drm_agpsupport.c |   16 +-
 drivers/char/drm/drm_auth.c       |    4
 drivers/char/drm/drm_bufs.c       |   20 +--
 drivers/char/drm/drm_context.c    |   12 -
 drivers/char/drm/drm_drv.c        |   48 ++-----
 drivers/char/drm/drm_fops.c       |   20 +--
 drivers/char/drm/drm_ioctl.c      |   12 +
 drivers/char/drm/drm_irq.c        |    6
 drivers/char/drm/drm_lock.c       |    4
 drivers/char/drm/drm_os_linux.h   |    2
 drivers/char/drm/drm_pciids.h     |    2
 drivers/char/drm/drm_proc.c       |    6
 drivers/char/drm/drm_scatter.c    |    4
 drivers/char/drm/drm_stub.c       |  166 +++++++++++++++++--------
 drivers/char/drm/drm_vm.c         |   16 +-
 drivers/char/drm/i810_dma.c       |  130 ++++++++++----------
 drivers/char/drm/i810_drv.c       |    3
 drivers/char/drm/i810_drv.h       |   46 -------
 drivers/char/drm/i830_dma.c       |  142 ++++++++++------------
 drivers/char/drm/i830_drv.c       |    3
 drivers/char/drm/i830_drv.h       |   40 ------
 drivers/char/drm/i830_irq.c       |    4
 drivers/char/drm/i915_drv.c       |    2
 drivers/char/drm/mga_dma.c        |   61 ---------
 drivers/char/drm/mga_drv.c        |    2
 drivers/char/drm/mga_drv.h        |   13 --
 drivers/char/drm/mga_state.c      |   44 +++---
 drivers/char/drm/r128_cce.c       |    4
 drivers/char/drm/r128_drv.c       |    2
 drivers/char/drm/r128_drv.h       |   16 --
 drivers/char/drm/r128_state.c     |   62 ++++-----
 drivers/char/drm/radeon_cp.c      |    5
 drivers/char/drm/radeon_drm.h     |    9 +
 drivers/char/drm/radeon_drv.c     |    2
 drivers/char/drm/radeon_drv.h     |   35 +----
 drivers/char/drm/radeon_irq.c     |   10 -
 drivers/char/drm/radeon_state.c   |  245 +++++++++++++++++++++++++++-----------
 drivers/char/drm/sis_drv.c        |    2
 drivers/char/drm/sis_drv.h        |    7 -
 drivers/char/drm/sis_ds.c         |   84 -------------
 drivers/char/drm/sis_ds.h         |   19 --
 drivers/char/drm/sis_mm.c         |   41 +++---
 drivers/char/drm/tdfx_drv.c       |    2
 46 files changed, 651 insertions(+), 773 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (05/03/10 1.2011)
   drm: fix setversion ioctl zeroing

   Egbert Eich reported a bug 2673 on bugs.freedesktop.org and tracked it
   down to a missing memset in the setversion ioctl, this causes X server
   crashes so I would like to see the fix in a 2.6.11.x tree if possible..

   From: Egbert Eich <eich@pdx.freedesktop.org>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/10 1.1994.21.4)
   drm: upgrade radeon driver to 1.15

   add support for texture micro tiling on radeon/r200.
   Add support for r100 cube maps (since it also requires a version bump).

   From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/10 1.1994.21.3)
   drm: cleanup i810/i830 drivers

   Cleanup patch for i810/i830

   From: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/10 1.1994.21.2)
   drm: cleanup patch

   This makes a lot of functions static and cleans up a few
   other minor things.

   From: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/10 1.1994.21.1)
   drm: fix radeon pci id

   fd.o bug #2576: Add support for ATI RN50/ES1000. (ATI Technologies Inc.)

   From: Michel Daenzer <michel@daenzer.net>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/10 1.1994.20.1)
   drm: split out structure into heads

   This patch splits out the main drm structures for future multi-head support.
   It just sets up the structures and the stub functions for putting/getting heads

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/09 1.1994.9.3)
   drm: fixup CREDITS and MAINTAINERS

   Add myself to MAINTAINERS for drm, and fixup my CREDITS.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

