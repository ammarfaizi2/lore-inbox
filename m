Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUL3HfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUL3HfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUL3HfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:35:08 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:23455 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261561AbUL3Hev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:34:51 -0500
Date: Thu, 30 Dec 2004 07:34:50 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] drm core/personality split
Message-ID: <Pine.LNX.4.58.0412300733380.25314@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This brings the DRM core/personality split from the DRM CVS tree into the
kernel, this has been fairly well tested in both DRM CVS and in -mm for the
past month or so, any issues that turn up should be minor and easily
resolvable before 2.6.11 turns up. The diff is quite large as it renames a lot
of .h files to .c files and removes all the DRM() macros.

For everyone else the diff is up at:
	http://www.skynet.ie/~airlied/public_html/patches/dri/drm_core_split-26bk.diff
and it is > 500k.

Dave.

 drivers/char/drm/ati_pcigart.h      |  206 -----
 drivers/char/drm/drm_agpsupport.h   |  468 -------------
 drivers/char/drm/drm_auth.h         |  230 ------
 drivers/char/drm/drm_bufs.h         | 1269 -----------------------------------
 drivers/char/drm/drm_context.h      |  578 ----------------
 drivers/char/drm/drm_dma.h          |  181 -----
 drivers/char/drm/drm_drawable.h     |   56 -
 drivers/char/drm/drm_drv.h          | 1060 ------------------------------
 drivers/char/drm/drm_fops.h         |  156 ----
 drivers/char/drm/drm_init.h         |  128 ---
 drivers/char/drm/drm_ioctl.h        |  349 ---------
 drivers/char/drm/drm_irq.h          |  368 ----------
 drivers/char/drm/drm_lock.h         |  168 ----
 drivers/char/drm/drm_proc.h         |  547 ---------------
 drivers/char/drm/drm_scatter.h      |  231 ------
 drivers/char/drm/drm_stub.h         |  236 ------
 drivers/char/drm/drm_vm.h           |  667 ------------------
 drivers/char/drm/tdfx.h             |   50 -
 drivers/char/drm/Kconfig            |    3
 drivers/char/drm/Makefile           |    6
 drivers/char/drm/ati_pcigart.c      |  208 +++++
 drivers/char/drm/drmP.h             |  324 +++++----
 drivers/char/drm/drm_agpsupport.c   |  439 ++++++++++++
 drivers/char/drm/drm_auth.c         |  230 ++++++
 drivers/char/drm/drm_bufs.c         | 1270 ++++++++++++++++++++++++++++++++++++
 drivers/char/drm/drm_context.c      |  578 ++++++++++++++++
 drivers/char/drm/drm_core.h         |   28
 drivers/char/drm/drm_dma.c          |  182 +++++
 drivers/char/drm/drm_drawable.c     |   56 +
 drivers/char/drm/drm_drv.c          |  545 +++++++++++++++
 drivers/char/drm/drm_fops.c         |  449 ++++++++++++
 drivers/char/drm/drm_init.c         |   52 +
 drivers/char/drm/drm_ioctl.c        |  355 ++++++++++
 drivers/char/drm/drm_irq.c          |  370 ++++++++++
 drivers/char/drm/drm_lock.c         |  303 ++++++++
 drivers/char/drm/drm_memory.c       |  181 +++++
 drivers/char/drm/drm_memory.h       |  175 ----
 drivers/char/drm/drm_memory_debug.h |    2
 drivers/char/drm/drm_os_linux.h     |    5
 drivers/char/drm/drm_proc.c         |  539 +++++++++++++++
 drivers/char/drm/drm_scatter.c      |  231 ++++++
 drivers/char/drm/drm_stub.c         |  256 +++++++
 drivers/char/drm/drm_vm.c           |  670 ++++++++++++++++++
 drivers/char/drm/ffb_drv.c          |   26
 drivers/char/drm/gamma_dma.c        |   12
 drivers/char/drm/i810_dma.c         |   95 --
 drivers/char/drm/i810_drm.h         |   46 -
 drivers/char/drm/i810_drv.c         |  104 ++
 drivers/char/drm/i810_drv.h         |   35
 drivers/char/drm/i830_dma.c         |   85 --
 drivers/char/drm/i830_drm.h         |   43 -
 drivers/char/drm/i830_drv.c         |  112 +++
 drivers/char/drm/i830_drv.h         |   33
 drivers/char/drm/i830_irq.c         |    6
 drivers/char/drm/i915_dma.c         |   48 -
 drivers/char/drm/i915_drm.h         |   37 -
 drivers/char/drm/i915_drv.c         |  103 ++
 drivers/char/drm/i915_drv.h         |   24
 drivers/char/drm/i915_irq.c         |    6
 drivers/char/drm/i915_mem.c         |   21
 drivers/char/drm/mga_dma.c          |   34
 drivers/char/drm/mga_drv.c          |  103 ++
 drivers/char/drm/mga_drv.h          |   15
 drivers/char/drm/mga_irq.c          |    3
 drivers/char/drm/mga_state.c        |    1
 drivers/char/drm/mga_warp.c         |    1
 drivers/char/drm/r128_cce.c         |   17
 drivers/char/drm/r128_drv.c         |  111 +++
 drivers/char/drm/r128_drv.h         |   17
 drivers/char/drm/r128_irq.c         |    3
 drivers/char/drm/r128_state.c       |  101 +-
 drivers/char/drm/radeon_cp.c        |   13
 drivers/char/drm/radeon_drv.c       |  148 ++++
 drivers/char/drm/radeon_drv.h       |   21
 drivers/char/drm/radeon_irq.c       |   11
 drivers/char/drm/radeon_mem.c       |   21
 drivers/char/drm/radeon_state.c     |   33
 drivers/char/drm/sis_drm.h          |   21
 drivers/char/drm/sis_drv.c          |   86 ++
 drivers/char/drm/sis_drv.h          |   14
 drivers/char/drm/sis_ds.c           |   17
 drivers/char/drm/sis_mm.c           |   12
 drivers/char/drm/tdfx_drv.c         |   72 +-
 drivers/char/drm/tdfx_drv.h         |   50 +
 84 files changed, 8438 insertions(+), 7728 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/11/23 1.2026.14.326)
   drm: move the enable device before filling in device info

   This moves the pci_enable_device to before the device info is
   filled out as without routeirq this goes wrong..

   Thanks to Ralf Gerbig <rge@quengel.org> for testing this.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/11 1.2026.14.325)
   drm: in-correct locking in intel drms

   The locking in the intel drms is incorrect it doesn't check
   the current context owns the lock, just that someone does.
   This could allow strange things to happen with multiple clients.

   From: Stefan Dirsch <sndirsch@suse.de>
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/11 1.2026.14.324)
   drm: remove use of drm_agp use agp backend directly.

   This removes the inter module stuff between the DRM and AGP.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/11 1.2026.14.323)
   drm: fix Kconfig dependency

   fixup DRM/AGP Kconfig inter-dependency...

   From: Roman Zippel <zippel@linux-m68k.org>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/11 1.2026.14.322)
   drm: fix warning for missing vunmap

   In file included from drivers/char/drm/drmP.h:795,
                    from drivers/char/drm/drm_dma.c:36:
   drivers/char/drm/drm_memory.h: In function `drm_ioremapfree':
   drivers/char/drm/drm_memory.h:191: warning: implicit declaration of function
   `vunmap'

   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/10 1.2026.14.321)
   drm: move ati_pcigart into drm core

   This moves the ati_pcigart code into the drm core.

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/05 1.2026.14.320)
   drm: make pcigart functions inline

   with these unstatic uninline the kernel wouldn't build with both configured.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/04 1.2026.14.319)
   drm: rearrange some functions for new split

   This change moves some functions into different C files to align things
   a bit more correctly...

   From: Jon Smirl <jonsmirl@gmail.com>
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/04 1.2026.14.318)
   drm: move fops into drivers

   move the drm file operations into the driver.

   From: Jon Smirl <jonsmirl@gmail.com>
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/02 1.2026.14.315)
   drm: rename fn_tbl to driver as it is no longer a function table

   This renames the drm_driver_fn to drm_driver and fn_tbl to driver,
   this name is makes much more sense now.

   From: Jon Smirl <jonsmirl@gmail.com> and Dave Airlie <airlied@linux.ie>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/02 1.2026.14.314)
   drm: drm_memory.c missing from build

   Add drm_memory.c to build.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/11/02 1.2026.14.313)
   drm: core/personality split for 2.6 kernel

   This changeset gets rid of the DRM() macros and implements a core DRM module
   linked to a per graphics card personality module..

   Remove old 2.4 module parameters and switch to 2.6 module parameters

   From: Jon Smirl <jonsmirl@gmail.com> and Dave Airlie <airlied@linux.ie>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/10/27 1.2026.8.2)
   drm: device minor fixups and /proc fixups

   This patch fixes up the DRM to do better minor number accounting
   and /proc directory creation, the old code was buggy in a number
   of situations with multiple cards, and rather ugly. It is also
   a step on the way to the drm_core module.

   From: Jon Smirl and Dave Airlie
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/10/24 1.2026.8.1)
   drm: memory allocation patch

   This removes some unnecessary macros for allocating DRM memory.
   It doesn't change any functionality.

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/10/24 1.2026.7.1)
   drm: initial core move infrastructure change

   Initial infrastructure - move old H files to C files
   also Kconfig and Makefile changes

   Signed-off-by: Dave Airlie <airlied@linux.ie>

