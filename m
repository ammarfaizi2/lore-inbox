Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWJYSwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWJYSwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWJYSwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:52:17 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:32646 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1030464AbWJYSwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:52:17 -0400
Date: Wed, 25 Oct 2006 19:52:14 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] drm patches for 2.6.19-rc3
Message-ID: <Pine.LNX.4.64.0610251948160.9796@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull the drm-patches branch
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 drm-patches

This just contains some bug fixes and a radeon packet verifier 
improvement,

Dave.

  drivers/char/drm/drm_bufs.c     |    4 +
  drivers/char/drm/drm_sysfs.c    |   43 +++++++++++++--
  drivers/char/drm/mga_drv.c      |    1
  drivers/char/drm/r300_cmdbuf.c  |   33 +++++++++++-
  drivers/char/drm/radeon_state.c |  109 ++++++++++++++++++++++++++++++++++++++-
  drivers/char/drm/savage_bci.c   |    1
  drivers/char/drm/savage_state.c |    2 -
  7 files changed, 180 insertions(+), 13 deletions(-)

commit 85abb3f95010b277a6efbc9b8031a7854af87e10
Author: Amol Lad <amol@verismonetworks.com>
Date:   Wed Oct 25 09:55:34 2006 -0700

     drm: ioremap balanced with iounmap for drivers/char/drm

     ioremap must be balanced by an iounmap and failing to do so can result
     in a memory leak.

     Tested (compilation only) to make sure the files are compiling without
     any warning/error due to new changes

     Signed-off-by: Amol Lad <amol@verismonetworks.com>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 24f73c92a990ecd3d1bb846267780a264d830065
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Oct 10 14:23:37 2006 -0700

     drm: fix error returns, sysfs error handling

     - callers of drm_sysfs_create() and drm_sysfs_device_add() looked for
       errors using IS_ERR(), but the functions themselves only ever returned
       NULL on error.  Fixed.

     - unwind from, and propagate sysfs errors

     Signed-off-by: Jeff Garzik <jeff@garzik.org>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 0d960d26c42888cf327df7faa1a8aa62bab53fa4
Author: Dave Jones <davej@redhat.com>
Date:   Wed Oct 18 00:26:39 2006 -0400

     fix return code in error case.

     The other failure returns in this function are negative, so make
     this one do the same.

     Signed-off-by: Dave Jones <davej@redhat.com>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 958de71b1ab01c20c1b385035235746c9227b24f
Author: Tilman Sauerbeck <tilman@code-monkey.de>
Date:   Tue Oct 24 21:52:23 2006 +1000

     drm: mga: set dev_priv_size

     fd.o bug 1746

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 10eee0fe9114694401c7ae154e8cfb2ab2f59c10
Author: Michael Karcher <freedesktop-bugzilla@mkarcher.dialup.fu-berlin.de>
Date:   Tue Oct 24 21:46:55 2006 +1000

     drm: savage: dev->agp_buffer_map is not initialized for AGP DMA on savages

     fd.o bug 8662

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit a1aa28970316d7fb606321d5ab7fb3873641ab54
Author: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
Date:   Tue Oct 24 21:45:00 2006 +1000

     drm: radeon: only allow specific type-3 packetss through verifier

     only allow specific type-3 packets to pass the verifier instead of all for r100/r200 as others might be unsafe (r300 already does this), and add checking for these we need but aren't safe. Check the RADEON_CP_INDX_BUFFER packet on both r200 and r300 as it isn't safe neither.

     Signed-off-by: Dave Airlie <airlied@linux.ie>
