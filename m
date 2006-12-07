Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968801AbWLGFQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968801AbWLGFQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968798AbWLGFQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:16:13 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:57525 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968801AbWLGFQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:16:12 -0500
Date: Thu, 7 Dec 2006 05:16:10 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] DRM patches for 2.6.20
Message-ID: <Pine.LNX.4.64.0612070513390.24085@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This tree has mainly driver updates for the i915 vblank + DRM drawable 
changes, along with some minor bugfixes.

Please pull from the 'drm-patches' branch:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git drm-patches
(or from master if the mirroring is still fubar..)

  drivers/char/drm/drm.h          |   33 ++++
  drivers/char/drm/drmP.h         |   23 +++
  drivers/char/drm/drm_bufs.c     |   10 +
  drivers/char/drm/drm_core.h     |    8 +
  drivers/char/drm/drm_drawable.c |  294 ++++++++++++++++++++++++++++++++++++++-
  drivers/char/drm/drm_drv.c      |   14 ++
  drivers/char/drm/drm_irq.c      |  155 +++++++++++++++++----
  drivers/char/drm/drm_lock.c     |   11 +
  drivers/char/drm/drm_sman.c     |    1
  drivers/char/drm/drm_stub.c     |    2
  drivers/char/drm/drm_vm.c       |   16 ++
  drivers/char/drm/i915_dma.c     |    2
  drivers/char/drm/i915_drm.h     |   19 +++
  drivers/char/drm/i915_drv.c     |    4 -
  drivers/char/drm/i915_drv.h     |   22 +++
  drivers/char/drm/i915_irq.c     |  265 ++++++++++++++++++++++++++++++++++-
  16 files changed, 822 insertions(+), 57 deletions(-)
commit d942625c2d5f5d29cd3bb4fad8a4aadd59024317
Author: Andrew Morton <akpm@osdl.org>
Date:   Thu Dec 7 16:11:44 2006 +1100

     Fix http://bugzilla.kernel.org/show_bug.cgi?id=7606

     WARNING: "drm_sman_set_manager" [drivers/char/drm/sis.ko] undefined!

     Cc: <daniel-silveira@gee.inatel.br>
     Cc: <stable@kernel.org>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 3417f33e762bf7d4277031a655e3ad07e73ce0be
Author: George Sapountzis <gsap7@yahoo.gr>
Date:   Tue Oct 24 12:03:04 2006 -0700

     drm: add flag for mapping PCI DMA buffers read-only.

     Add DRM_PCI_BUFFER_RO flag for mapping PCI DMA buffer read-only. An additional
     flag is needed, since PCI DMA buffers do not have an associated map.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 5c2df2bfb121a77d925dba580f53da08b4020528
Author: Dave Airlie <airlied@linux.ie>
Date:   Tue Oct 24 11:36:59 2006 -0700

     drm: fix up irqflags in drm_lock.c

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2228ed67223f3f22ea09df8854e6a31ea06d5619
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Wed Oct 25 01:05:09 2006 +1000

     drm: i915 updates

     Add support for DRM_VBLANK_NEXTONMISS.
     Bump minor for swap scheduling ioctl and secondary vblank support.
     Avoid mis-counting vblank interrupts when they're only enabled for pipe A.
     Only schedule vblank tasklet if there are scheduled swaps pending.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit a0b136bb696cfa744a79c4dbbbbd0c8f9f30fe3f
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Wed Oct 25 00:12:52 2006 +1000

     drm: i915: fix up irqflags arg

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 21fa60ed4eab5b3b28d05930bb086615ecc191b1
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Wed Oct 25 00:10:59 2006 +1000

     drm: i915: Only return EBUSY after we've established we need to schedule a new swap.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2dbb232c4d6b6c89fc367f7566c7c87dd3b56cd7
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Wed Oct 25 00:10:24 2006 +1000

     drm: i915: Fix 'sequence has passed' condition in i915_vblank_swap().

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 376642cf2eb0f32d8502b0a2c4efd96a3f13a8b8
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Wed Oct 25 00:09:35 2006 +1000

     drm: i915: Add SAREA fileds for determining which pipe to sync window buffer swaps to.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 5b51694aff705c465ef5941a99073036f3e444d9
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Wed Oct 25 00:08:23 2006 +1000

     drm: Make handling of dev_priv->vblank_pipe more robust.

     Initialize it to default value if it hasn't been set by the X server yet.

     In i915_vblank_pipe_set(), only update dev_priv->vblank_pipe and call
     i915_enable_interrupt() if the argument passed from userspace is valid to avoid
     corrupting dev_priv->vblank_pipe on invalid arguments.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 541f29aad766b6c7b911a7d900d952744369bf53
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:38:54 2006 +1000

     drm: DRM_I915_VBLANK_SWAP ioctl: Take drm_vblank_seq_type_t instead

     of pipe number.

     Handle relative as well as absolute target sequence numbers.

     Return error if target sequence has already passed, so userspace can deal with
     this situation as it sees fit.

     On success, return the sequence number of the vertical blank when the buffer
     swap is expected to take place.

     Also add DRM_IOCTL_I915_VBLANK_SWAP definition for userspace code that may want
     to use ioctl() instead of drmCommandWriteRead().

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit a6b54f3f5050c0cbc0c35dd48064846c6302706b
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:37:43 2006 +1000

     drm: i915: Add ioctl for scheduling buffer swaps at vertical blanks.

     This uses the core facility to schedule a driver callback that will be called
     ASAP after the given vertical blank interrupt with the HW lock held.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 049b323321bbcb476b799f50dc6444c0ed5a0e0e
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:34:58 2006 +1000

     drm: Core vsync: Don't clobber target sequence number when scheduling signal.

     It looks like this would have caused signals to always get sent on the next
     vertical blank, regardless of the sequence number.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit ab285d74e6742422fd0465577a31fb03fe9ed241
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:34:18 2006 +1000

     drm: Core vsync: Add flag DRM_VBLANK_NEXTONMISS.

     When this flag is set and the target sequence is missed, wait for the next
     vertical blank instead of returning immediately.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 8163e418f71e46a28bac6625b4c633c13bd53c8d
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:30:01 2006 +1000

     drm: Make locked tasklet handling more robust.

     Initialize the spinlock unconditionally when struct drm_device is filled in,
     and return early in drm_locked_tasklet() if the driver doesn't support IRQs.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 507c0185a72e89002757a58f6c64de3df84da0de
Author: =?utf-8?q?Felix_K=C3=BChling?= <fxkuehl@gmx.de>
Date:   Tue Oct 24 23:28:23 2006 +1000

     drm: drm_rmdraw: Declare id and idx as signed so testing for < 0 works as intended.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit cdec2f82b11afbe4933fa9a9b3ed567db14fd237
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:20:15 2006 +1000

     drm: Change first valid DRM drawable ID to be 1 instead of 0.

     This makes it easier for userspace to know when it needs to allocate an ID.

     Also free drawable information memory when it's no longer needed.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b03ed6f2fc519930fe3950365be59f0c079ce5d8
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:18:49 2006 +1000

     drm: drawable locking + memory management fixes + copyright

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2e54a007622ac75d63bdc1dd71d435446293f4a9
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:08:16 2006 +1000

     drm: Add support for interrupt triggered driver callback with lock held to DRM core.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit bea5679f9cb97b7e41786c8500df56665cd21e56
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 23:04:19 2006 +1000

     drm: Add support for tracking drawable information to core

     Actually make the existing ioctls for adding and removing drawables do
     something useful, and add another ioctl for the X server to update drawable
     information. The only kind of drawable information tracked so far is cliprects.

     Only reallocate cliprect memory if the number of cliprects changes.
     Also improve diagnostic output.

     hook up drm ioctl update draw
     export drm_get_drawable_info symbol

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 68815bad7239989d92f315c10d9ef65a11945a75
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 22:28:51 2006 +1000

     drm: add support for secondary vertical blank interrupt to i915

     When the vertical blank interrupt is enabled for both pipes, pipe A is
     considered primary and pipe B secondary. When it's only enabled for one pipe,
     it's always considered primary for backwards compatibility.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 776c9443e28dddbde9b513db6cb8221c45b3a269
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Tue Oct 24 22:24:38 2006 +1000

     drm: add support for secondary vertical blank interrupt to DRM core

     Signed-off-by: Dave Airlie <airlied@linux.ie>
