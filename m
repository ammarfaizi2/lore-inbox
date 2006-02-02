Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423397AbWBBJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423397AbWBBJTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423398AbWBBJTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:19:09 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:57028 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1423397AbWBBJTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:19:08 -0500
Date: Thu, 2 Feb 2006 09:17:47 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] drm patches for 2.6.16
Message-ID: <Pine.LNX.4.58.0602020913460.19173@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you pull the drm-linus branch from
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It contains a bunch of cleanup patches (mutex conversion, static function,
sparse) along with new i945GM chipset support (pciid and some minor
changes) which Intel recently pushed to me, there should be nothing
contentious in here ....

Dave.

 ati_pcigart.c |   17 +++++-------
 drmP.h        |    5 ++-
 drm_auth.c    |   20 +++++++-------
 drm_bufs.c    |   80 +++++++++++++++++++++++++++++-----------------------------
 drm_context.c |   52 ++++++++++++++++++-------------------
 drm_drv.c     |    4 +-
 drm_fops.c    |   12 ++++----
 drm_ioctl.c   |   18 ++++++-------
 drm_irq.c     |   16 +++++------
 drm_pciids.h  |    2 +
 drm_proc.c    |   28 ++++++++++----------
 drm_stub.c    |    4 +-
 drm_vm.c      |   12 ++++----
 i810_dma.c    |    2 -
 i810_drv.h    |    2 -
 i830_dma.c    |    2 -
 i830_drv.h    |    3 --
 i915_dma.c    |   42 +++++++++++++++++++++---------
 i915_drm.h    |   33 +++++++++++++++++++++++
 i915_drv.h    |    6 ++--
 i915_mem.c    |   31 ++++++++++++++++++++++
 radeon_cp.c   |    2 -
 savage_bci.c  |    4 ++
 savage_drv.h  |    1
 via_dma.c     |   10 +++----
 via_dmablit.c |    6 ++--
 via_drv.h     |    7 -----
 via_irq.c     |    2 -
 28 files changed, 248 insertions(+), 175 deletions(-)


commit 30e2fb188194908e48d3f27a53ccea6740eb1e98
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Feb 2 19:37:46 2006 +1100

    sem2mutex: drivers/char/drm/

    From: Arjan van de Ven <arjan@infradead.org>

    Semaphore to mutex conversion.

    The conversion was generated via scripts, and the result was validated
    automatically via a script as well.

    Signed-off-by: Arjan van de Ven <arjan@infradead.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit ce60fe02fbe737cbce09e2ba5a2ef1efd20eff73
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Feb 2 19:21:38 2006 +1100

    drm: drivers/char/drm/: make some functions static

    From: Adrian Bunk <bunk@stusta.de>

    This patch makes some needlessly global functions static.

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 339363c4c6fe01043c51e7d6e9fbeb8feee00841
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jan 26 08:32:14 2006 +1100

    drm: Fixes sparse warnings in via_dmablit.c

    Fixes the following sparse warnings:

     drivers/char/drm/via_dmablit.c:111:35: warning: Using plain integer as NULL pointer
     drivers/char/drm/via_dmablit.c:584:23: warning: Using plain integer as NULL pointer

    Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit de227f5f32775d86e5c780a7cffdd2e08574f7fb
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 25 15:31:43 2006 +1100

    drm: i915 patches from Tungsten Graphics

    Fix CMDBUFFER path, add heap destroy and flesh out sarea for rotation
    (Tungsten Graphics)

    From: Alan Hourihane <alanh@tungstengraphics.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 507d256bae9eef7acd5049af6e3f67c24904a1e4
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 25 14:58:58 2006 +1100

    drm: ati_pcigart: simplify page_count manipulations

    From: Nick Piggin <npiggin@suse.de>

    Allocate a compound page for the user mapping instead of tweaking the page
    refcounts.

    Signed-off-by: Nick Piggin <npiggin@suse.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f1e5c03d34c39394781ae13543cd3355976e4812
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 25 14:54:15 2006 +1100

    drm: use NULL instead of 0
    From: Randy Dunlap <rdunlap@xenotime.net>

    Use NULL instead of 0 (sparse warnings):

    drivers/char/drm/ati_pcigart.c:64:10: warning: Using plain integer as NULL
    pointer
    drivers/char/drm/ati_pcigart.c:130:21: warning: Using plain integer as NULL
    pointer
    drivers/char/drm/ati_pcigart.c:171:14: warning: Using plain integer as NULL
    pointer

    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2fed3bd7436e8988980989493c16b4983be1a800
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 25 14:52:43 2006 +1100

    drm: add X600 PCI IDs

    From: Brice Goglin <Brice.Goglin@ens-lyon.org>

    Now that Xorg 6.9/7.0 has been released, DRI is supported on more Radeon
    cards without ATI proprietary drivers.  I got my X300 to work without
    problem.  But, another Radeon X600 required to add its PCI ids to the
    Radeon driver.  Patch is attached.

    I can't be sure about the "CHIP_RV350", I copied it from the X300 entry
    (from http://dri.freedesktop.org/wiki/ATIRadeon, X600 is a rv380 chip while
    X300 is a rv370).  But, at least it works now.

    Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 5457f38e01ae2d296ff49db42254679018f13fa9
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 25 14:34:33 2006 +1100

    drm: add i945GM PCI ID

    From: Charles F. Johnson <charles.f.johnson@intel.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d59cc22f7ce48bf5454f12eec8603bff81c34cdb
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 25 14:31:45 2006 +1100

    drm: Fix sparce warning in radeon driver

    From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>

    drivers/char/drm/radeon_cp.c:1643:31: warning: Using plain integer as NULL
    pointer

    Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

