Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVBALoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVBALoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVBALoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:44:39 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40108 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261992AbVBALo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:44:26 -0500
Date: Tue, 1 Feb 2005 11:44:24 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] drm tree 
Message-ID: <Pine.LNX.4.58.0502011143260.5748@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The latest drm tree for 2.6 is ready, this stuff is all fairly trivial, it
a) cleans up unneeded header files
b) add drms specific sysfs support
c) updates radeon driver to version 1.13
d) fixes a problem in setversion ioctl (this is needed before 2.6.11...)

The patch is large as the file removals are quite big: so the it is available
at http://www.skynet.ie/~airlied/patches/lk_drm/bk_drm_010204.patch

If you don't trust this tree, let me know and I can generate a tree from a & d
but I don't think there should be any issues with it. most of it has been
in CVS for months..

Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/ffb.h          |   12 -
 drivers/char/drm/gamma.h        |   77 -------
 drivers/char/drm/i810.h         |   77 -------
 drivers/char/drm/i830.h         |   83 --------
 drivers/char/drm/i915.h         |   53 -----
 drivers/char/drm/mga.h          |   63 ------
 drivers/char/drm/r128.h         |   75 -------
 drivers/char/drm/radeon.h       |  112 ----------
 drivers/char/drm/sis.h          |   61 -----
 drivers/char/drm/Makefile       |    3
 drivers/char/drm/drmP.h         |   22 +-
 drivers/char/drm/drm_drv.c      |    6
 drivers/char/drm/drm_ioctl.c    |   21 +-
 drivers/char/drm/drm_memory.h   |    2
 drivers/char/drm/drm_pci.c      |  140 +++++++++++++
 drivers/char/drm/drm_pciids.h   |  128 ++++++------
 drivers/char/drm/drm_stub.c     |   15 -
 drivers/char/drm/drm_sysfs.c    |  208 ++++++++++++++++++++
 drivers/char/drm/i810_dma.c     |   20 +
 drivers/char/drm/i810_drv.c     |   23 --
 drivers/char/drm/i830_dma.c     |   19 +
 drivers/char/drm/i830_drv.c     |   22 --
 drivers/char/drm/i915_dma.c     |   28 ++
 drivers/char/drm/i915_drv.c     |   20 -
 drivers/char/drm/mga_drv.c      |   18 -
 drivers/char/drm/mga_state.c    |   14 +
 drivers/char/drm/r128_drv.c     |   31 --
 drivers/char/drm/r128_drv.h     |    6
 drivers/char/drm/r128_state.c   |   21 ++
 drivers/char/drm/radeon_cp.c    |  388 ++++++++++++++++++++++++++++++++++---
 drivers/char/drm/radeon_drm.h   |   32 ++-
 drivers/char/drm/radeon_drv.c   |   68 ------
 drivers/char/drm/radeon_drv.h   |  122 +++++++++++
 drivers/char/drm/radeon_state.c |  414 +++++++++++++++++++++++++++++++++++++++-
 drivers/char/drm/sis_drv.c      |   14 -
 drivers/char/drm/sis_mm.c       |   11 +
 36 files changed, 1519 insertions(+), 910 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (05/02/01 1.1966.87.16)
   drm_memory.h doesn't need to #include tlbflush.h

   The flush_tlb_kernel_range call in drm_memory.h was removed in 2003, so
   there's no more reason for this #include.

   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/02/01 1.1966.87.15)
   drm: fix drm_sysfs lock initializer...

   unify the initializer.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.14)
   drm: update pci ids..

   add missing radeon pci id
   add i915gm pci ids.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.12)
   drm: add radeon framebuffer tiling support and surface management

   Add support to the radeon drm for framebuffer tiling, requires
   a new DDX and 3D driver.

   From: Stephane Marchesin <marchesin@icps.u-strasbg.fr> and
   Roland Scheidegger <rscheidegger_lists@hispeed.sh>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.11)
   drm: radeon hyperz support..

   HyperZ is an undocumented feature (outside of ATI) of the radeon
   chips, this is a reverse engineered implementation.

   From: Roland Scheidegger <rscheidegger_lists@hispeed.ch> and
   Stephane Marchesin <marchesin@icps.u-strasbg.fr>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.10)
   drm: add R200_EMIT_TCL_POINT_SPRITE_CNTL

   add support for new packet. won't be used until hyper-z version
   number increase.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.9)
   drm: fix minor bug on X recycling with freeing io buffer

   The previous checkin missed an issue on X recycling.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.8)
   drm: add support for radeon flags

   Add flags to the radeon driver, needed for HyperZ patch.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/27 1.1966.87.7)
   drm: fix setversion in drm core model

   Setversion ioctl was broken for drm core, fix this.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/16 1.1966.66.5)
   drm: add drm specific sysfs support

   Switch the drm from using class simple to its own sysfs
   interface.

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/16 1.1966.66.4)
   drm: add drm_pci interface and make i915 use it

   This adds the drm_pci interface, originally designed for mach64
   but used by the i915 driver now for doing cross platform.

   From: Jose Fonseca, Leif Delglass (drm_pci.c)
   From: Eric Anholt (i915 changes).
   Signed-off-by: Dave Airlie

<airlied@starflyer.(none)> (05/01/16 1.1966.66.3)
   drm: fix mga ioctls..

   The mga cut-n-paste typo...

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/16 1.1966.66.2)
   drm: move ioctls to shared file and move interface history to correct place

   This patch moves the ioctls into a file which is shared with
   the BSD drm, so we don't duplicate them across both trees,
   it also fixes up the radeon/r128 interface histories so
   they are with the driver version strings...

   It also removes the old interface files that no longer needed.

   From: Eric Anholt <anholt@freebsd.org> and Dave Airlie <airlied@linux.ie>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/01/16 1.1966.66.1)
   drm: add r300 microcode support and radeon chip flags

   This patch adds radeon chip families to the pci ids (they aren't used
   by this patch - future work will), and also adds support for r300 microcode...

   The r300 project has work for use the CP for 2D operations in Xorg
   so this is useful even without 3D.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

