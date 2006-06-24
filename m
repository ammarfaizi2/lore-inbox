Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933213AbWFXHw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213AbWFXHw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 03:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933215AbWFXHw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 03:52:28 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:23529 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S933213AbWFXHw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 03:52:28 -0400
Date: Sat, 24 Jun 2006 08:52:27 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] DRM driver updates
Message-ID: <Pine.LNX.4.64.0606240851530.30220@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
 	Can you please pull the 'drm-patches' branch from:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It contains just driver updates from DRM CVS for i915 and radeon.

Dave.

  drivers/char/drm/i915_dma.c     |    4 ++
  drivers/char/drm/i915_drm.h     |   13 +++++++
  drivers/char/drm/i915_drv.h     |    6 +++
  drivers/char/drm/i915_irq.c     |   69 +++++++++++++++++++++++++++++++++++++--
  drivers/char/drm/radeon_cp.c    |    6 ++-
  drivers/char/drm/radeon_drm.h   |    7 +++-
  drivers/char/drm/radeon_drv.h   |   10 +++++-
  drivers/char/drm/radeon_state.c |   39 +++++++++++++++++++++-
  8 files changed, 142 insertions(+), 12 deletions(-)

commit c499aeb08cb24bed60e5bfc80720597bcf1a720d
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Jun 24 17:37:48 2006 +1000

     drm: radeon constify radeon microcode

     From: Tilman (DRM CVS)
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 702880f24373dfb31edb0bcd997ff924d07decc3
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Jun 24 17:07:34 2006 +1000

     Add i915 ioctls to configure pipes for vblank interrupt.

     i915 vblanks can be generated from either pipe a or b, however a disabled
     pipe generates no interrupts. This change allows the X server to select
     which pipe generates vblank interrupts.

     From: Keith Packard <keith.packard@intel.com> via DRM CVS
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d6fece051a4ef330922bfafb9d64e3e133e3a8a6
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Jun 24 17:04:07 2006 +1000

     drm: update radeon to 1.25 add r200 vertex program support

     Add support for r200 vertex programs (R200_EMIT_VAP_PVS_CNTL, and new
     packet type for making it possible to address whole tcl vector space
     and have a larger count)

     From: Roland Scheidegger (DRM CVS)
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f2a2279ffc0dfd27f6909184a29910e40ae7eebd
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Jun 24 16:55:34 2006 +1000

     drm: radeon add a tcl state flush before accessing tcl vector space

     Do a tcl state flush before accessing tcl vector space. This fixes some
     more problems with flickering (bug #6637). drm may not be appropriate
     place for this, since doing that flush there might both be overkill and
     insufficient in some cases. However, it's hard to figure out when that
     flush is needed, so this has to suffice. There does not seem to be a
     performance penalty associated with it.

     From: Roland Scheidegger (DRM CVS)
     Signed-off-by: Dave Airlie <airlied@linux.ie>
