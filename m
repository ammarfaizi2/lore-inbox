Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264601AbUEJKap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbUEJKap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUEJKap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:30:45 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:27009 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264601AbUEJKah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:30:37 -0400
Date: Mon, 10 May 2004 11:30:36 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PULL] DRM merge
Message-ID: <Pine.LNX.4.58.0405101122520.6165@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

These changes have been in -mm for a month or so, I think they are ready for
the bigtime!!, they bring the DRM in-line with the CVS tree on fd.o.

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drm.h              |   27 ++
 drivers/char/drm/drmP.h             |   85 +++----
 drivers/char/drm/drm_agpsupport.h   |    8
 drivers/char/drm/drm_bufs.h         |   12 -
 drivers/char/drm/drm_context.h      |   29 ++
 drivers/char/drm/drm_dma.h          |  303 --------------------------
 drivers/char/drm/drm_drv.h          |  264 ++++++++++++-----------
 drivers/char/drm/drm_fops.h         |    2
 drivers/char/drm/drm_ioctl.h        |  192 +++++++---------
 drivers/char/drm/drm_irq.h          |  371 ++++++++++++++++++++++++++++++++
 drivers/char/drm/drm_memory_debug.h |    1
 drivers/char/drm/drm_os_linux.h     |    6
 drivers/char/drm/drm_pciids.h       |  203 +++++++++++++++++
 drivers/char/drm/drm_sarea.h        |   14 +
 drivers/char/drm/drm_stub.h         |    4
 drivers/char/drm/drm_vm.h           |  148 ++++++++----
 drivers/char/drm/ffb.h              |    1
 drivers/char/drm/gamma.h            |    4
 drivers/char/drm/gamma_dma.c        |    8
 drivers/char/drm/gamma_drv.c        |    1
 drivers/char/drm/i810.h             |    3
 drivers/char/drm/i810_dma.c         |    4
 drivers/char/drm/i830.h             |    4
 drivers/char/drm/i830_dma.c         |    6
 drivers/char/drm/i830_drv.c         |    1
 drivers/char/drm/i830_irq.c         |    2
 drivers/char/drm/mga.h              |    2
 drivers/char/drm/mga_dma.c          |   12 -
 drivers/char/drm/mga_drm.h          |   35 ++-
 drivers/char/drm/mga_drv.c          |    1
 drivers/char/drm/mga_drv.h          |    1
 drivers/char/drm/mga_irq.c          |    2
 drivers/char/drm/r128.h             |    2
 drivers/char/drm/r128_cce.c         |   50 ----
 drivers/char/drm/r128_drm.h         |   61 +++--
 drivers/char/drm/r128_drv.c         |    1
 drivers/char/drm/r128_drv.h         |   58 ++---
 drivers/char/drm/r128_irq.c         |    2
 drivers/char/drm/r128_state.c       |   34 ++
 drivers/char/drm/radeon.h           |   22 +
 drivers/char/drm/radeon_cp.c        |   40 +--
 drivers/char/drm/radeon_drm.h       |  101 ++++++--
 drivers/char/drm/radeon_drv.c       |    1
 drivers/char/drm/radeon_drv.h       |    6
 drivers/char/drm/radeon_irq.c       |    2
 drivers/char/drm/radeon_state.c     |  412 ++++++++++++++++++++++++++++++++----
 drivers/char/drm/tdfx.h             |   10
 drivers/char/drm/tdfx_drv.c         |   41 ---
 48 files changed, 1700 insertions(+), 899 deletions(-)

through these ChangeSets:

<airlied@pdx.freedesktop.org> (04/04/25 1.1520.2.2)
   drm_pciids.h:
     add new tdfx id, and blank ffb ids

<airlied@pdx.freedesktop.org> (04/04/24 1.1371.698.20)
   drm_irq.h:
     remove NO_VERSION

<airlied@pdx.freedesktop.org> (04/04/22 1.1371.698.19)
   drmP.h:
     remove unused structure

<airlied@pdx.freedesktop.org> (04/04/22 1.1371.698.18)
   convert DRM to use pci device structures on Linux, move pci ids
   into a separate include file (this is auto-generated from the DRM
   tree)

<airlied@pdx.freedesktop.org> (04/04/21 1.1371.698.17)
   define an empty driver pci ids for ffb driver

<airlied@pdx.freedesktop.org> (04/04/10 1.1371.698.16)
   From Jon Smirl:
   This code allows the mesa drivers to use a single definition of the DRM sarea/IOCTLS

<airlied@pdx.freedesktop.org> (04/04/10 1.1371.698.15)
   * Introduce COMMIT_RING() as in radeon DRM, stop using error prone
     writeback for ring read pointer (Paul Mackerras)
   * Get rid of some superfluous stuff, minor fixes

<airlied@pdx.freedesktop.org> (04/04/10 1.1371.698.14)
   radeon_drm.h:
     missing define from previous checkin

<airlied@pdx.freedesktop.org> (04/04/10 1.1371.698.13)
   Miscellaneous changes from DRM CVS

<airlied@pdx.freedesktop.org> (04/04/10 1.1371.698.12)
   drm_ctx_dtor.patch
   Submitted by: Erdi Chen

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.11)
   More differentiated error codes for DRM(agp_acquire)

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.10)
   From Michel Daenzer:
   Adapt to nopage() prototype change in Linux 2.6.1.

   Reviewed by: Arjan van de Ven <arjanv@redhat.com>, additional feedback
   from William Lee Irwin III and Linus Torvalds.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.9)
   From Eric Anholt + Jon Smirl:
   Don't ioremap the framebuffer area. The ioremapped area wasn't used by
   anything.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.8)
   From Eric Anholt:
   Return EBUSY when attempting to addmap a DRM_SHM area with a lock in it if
   dev->lock.hw_lock is already set. This fixes the case of two X Servers running
   on the same head on different VTs with interface 1.1, by making the 2nd head
   fail to inizialize like before.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.7)
   From Eric Anholt: some cleanups from AlanH:
   - Tie the DRM to a specific device: setunique no longer succeeds when given
   a busid that doesn't correspond to the device the DRM is attached to. This
   is a breaking of backwards-compatibility only for the multiple-DRI-head case
   with X Servers that don't use interface 1.1.
   - Move irq_busid to drm_irq.h and make it only return the IRQ for the current
   device. Retains compatibility with previous X Servers, cleans up unnecessary
   code. This means no irq_busid on !__HAVE_IRQ, but can be changed if
   necessary.
   - Bump interface version to 1.2. This version when set signifies that the
   control ioctl should ignore the irq number passed in and enable the
   interrupt handler for the attached device. Otherwise it errors out when
   the passed-in irq is not equal to the device's.
   - Store the highest version the interface has been set to in the device.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.6)
   From: Michel Daenzer:
   Memory layout transition:

   * the 2D driver initializes MC_FB_LOCATION and related registers sanely
   * the DRM deduces the layout from these registers
   * clients use the new SETPARAM ioctl to tell the DRM where they think the
   framebuffer is located in the card's address space
   * the DRM uses all this information to check client state and fix it up if
   necessary

   This is a prerequisite for things like direct rendering with IGP chips and
   video capturing.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.5)
   From Eric Anholt:
    Introduce a new ioctl, DRM_IOCTL_SET_VERSION. This ioctl allows the server
   or client to notify the DRM that it expects a certain version of the device
   dependent or device independent interface. If the major doesn't match or minor
   is too large, EINVAL is returned. A major of -1 means that the requestor
   doesn't care about that portion of the interface. The ioctl returns the actual
   versions in the same struct.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.4)
   - Add DRM_GET_PRIV_WITH_RETURN macro. This can be used in shared code to get
   the drm_file_t * based on the filp passed in ioctl handlers.

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.3)
   left gamma_dma.c out of last changeset

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.2)
   From: Eric Anholt:
   - Move IRQ functions from drm_dma.h to new drm_irq.h and disentangle them from
   __HAVE_DMA. This will be useful for adding vblank sync support to sis and
   tdfx. Rename dma_service to irq_handler, which is more accurately what it is.
   - Fix the #if _HAVE_DMA_IRQ in radeon, r128, mga, i810, i830, gamma to have
   the right number of underscores. This may have been a problem in the case
   that the server died without doing its DRM_IOCTL_CONTROL to uninit

<airlied@pdx.freedesktop.org> (04/04/09 1.1371.698.1)
   - Converted Linux drivers to initialize DRM instances based on PCI IDs, not
   just a single instance. The PCI ID lists include a driver private field, which may be used
   by drivers for chip family or other information. Based on work by jonsmirl
   and Eric Anholt. I've left out the PCI device naming for this patch as
   that might be a bit controversial. clean up tdfx to look like everyone else..

