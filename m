Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUHOMUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUHOMUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUHOMUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:20:38 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:18614 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264386AbUHOMUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:20:03 -0400
Date: Sun, 15 Aug 2004 13:19:31 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0408151311340.27003@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus/Andrew,

I'd like to merge up the DRM tree to the stable branch, these patches have
been in -mm since I added them, they include a new i915 drm from Tungsten
Graphics, and the DRM now uses PCI properly if no framebuffer is loaded
(it falls back if framebuffer is enabled...), the next DRM changes are
lined up on a CVS branch - they start detemplating the DRM...

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/Kconfig         |   17
 drivers/char/drm/Makefile        |    2
 drivers/char/drm/drm.h           |    4
 drivers/char/drm/drmP.h          |   18
 drivers/char/drm/drm_bufs.h      |    1
 drivers/char/drm/drm_drv.h       |  188 ++++++---
 drivers/char/drm/drm_ioctl.h     |    2
 drivers/char/drm/drm_os_linux.h  |    4
 drivers/char/drm/drm_pciids.h    |    8
 drivers/char/drm/drm_proc.h      |   17
 drivers/char/drm/drm_stub.h      |  201 +++++++---
 drivers/char/drm/gamma_old_dma.h |   69 ++-
 drivers/char/drm/i810_dma.c      |    7
 drivers/char/drm/i830_dma.c      |   12
 drivers/char/drm/i915.h          |   95 ++++
 drivers/char/drm/i915_dma.c      |  760 +++++++++++++++++++++++++++++++++++++++
 drivers/char/drm/i915_drm.h      |  162 ++++++++
 drivers/char/drm/i915_drv.c      |   31 +
 drivers/char/drm/i915_drv.h      |  228 +++++++++++
 drivers/char/drm/i915_irq.c      |  173 ++++++++
 drivers/char/drm/i915_mem.c      |  361 ++++++++++++++++++
 drivers/char/drm/sis_mm.c        |    7
 22 files changed, 2194 insertions(+), 173 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/08/02 1.1823)
   Fix up multiple devices issues with creating /proc/dri/

   From: Jon Smirl
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/08/02 1.1822)
   add hotplug support function

   From: Jon Smirl
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/08/02 1.1821)
   fixup prototype..

<airlied@starflyer.(none)> (04/07/31 1.1820)
   switch to using i915_dma_cleanup as this conflicts on BSD builds..

<airlied@starflyer.(none)> (04/07/31 1.1819)
   sparse: use of user space pointer in kernel...

   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/31 1.1818)
   sparse: 0->NULL conversions.

   From: Dave Airlie

<airlied@starflyer.(none)> (04/07/31 1.1817)
   the patch below optimises the drm code to not do put_user() on memory the
   kernel allocated and then mmap-installed to userspace, but instead makes it
   use the kernel virtual address directly instead.

   From: Arjan van de Ven <arjanv@redhat.com>
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/26 1.1816)
   ATI Rage 128 and Radeon DRM unconditionally depend on PCI

   Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

<airlied@starflyer.(none)> (04/07/26 1.1815)
   Correct a couple of packet length calculations. - keithw

<airlied@starflyer.(none)> (04/07/25 1.1814)
   define user if not already.. this isn't needed in kernel but for building against the kernel headers it is ...

<airlied@starflyer.(none)> (04/07/25 1.1813)
   sync up device/driver tracking with CVS,

   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/25 1.1812)
   fix whitespace on tabbing

<airlied@starflyer.(none)> (04/07/25 1.1811)
   add some annotations Als patch missed
   add annotations for i915 driver

<airlied@starflyer.(none)> (04/07/25 1.1810)
   add missing prototype

<airlied@starflyer.(none)> (04/07/25 1.1809)
   fixup annotation

<airlied@starflyer.(none)> (04/07/25 1.1808)
   patch from Tom Arbuckle for missing bus_address

   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/20 1.1807)
   use NULLs instead of 0s

   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/20 1.1806)
   fixup drm_stub so it works with two-headed cards properly...

   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/15 1.1784.4.6)
   Add new i915 driver from Tungsten Graphics Inc. This driver covers the i830
   chipsets also, a new X 2D + 3D driver are needed to use this but they have
   been integrated into at least the X.org tree at this point and I think the
   XFree86 tree. There are probably a few cleanups necessary for this driver.

   From: Keith Whitwell <keith@tungstengraphics.com>
   Approved-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/15 1.1784.4.5)
   Fix issue with keeping count of registered DRMs with new driver model

   Submitted-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/07/06 1.1784.4.4)
   changes for better hotplug and proper PCI device support from Jon Smirl and
   Dave Airlie, along with a big fix from Paul Mackerras.

   Note: these are complex due to the need for the DRM to fallback if the
   framebuffer driver has already taken the device.

   These changes have been in the DRM CVS tree for about 3 months, style
   comments are appreciated...


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

