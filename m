Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTEEDhG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 23:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTEEDhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 23:37:06 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:37876 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261874AbTEEDhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 23:37:04 -0400
Date: Sun, 4 May 2003 20:49:01 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: torvalds@transmeta.com, linux-fbdev-devel@lists.sf.net
Cc: lkml <linux-kernel@vger.kernel.org>, ajoshi@shell.unixbox.com,
       gareth.hughes@acm.org, faith@redhat.com, jsimmons@infradead.org
Subject: [PATCH] 2.5.69 drm/radeon_cp.c
Message-Id: <20030504204901.20761942.randy.dunlap@verizon.net>
Organization: YPO4
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.64.196.31] at Sun, 4 May 2003 22:49:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch to 2.5.69 fixes this warning (gcc 3.2):
drivers/char/drm/radeon_cp.c: In function `radeon_cp_init_ring_buffer':
drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)
drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)


Is this obvious enough?  Want it to go thru someone?

--
~Randy



patch_name:	drm_radeon_dma.patch
patch_version:	2003-05-04.20:32:09
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix printk of dma_addr_t
product:	Linux
product_versions: linux-2569
changelog:	print dma_addr_t as unsigned long
maintainer:	dunno: Ani Joshi (ajoshi@shell.unixbox.com),
		James Simmons (jsimmons@infradead.org),
		Gareth Hughes (gareth.hughes@acm.org),
		Rik Faith (faith@redhat.com)
diffstat:	=
 drivers/char/drm/radeon_cp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./drivers/char/drm/radeon_cp.c%VID ./drivers/char/drm/radeon_cp.c
--- ./drivers/char/drm/radeon_cp.c%VID	2003-05-04 16:53:06.000000000 -0700
+++ ./drivers/char/drm/radeon_cp.c	2003-05-04 20:30:30.000000000 -0700
@@ -903,8 +903,8 @@
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			     entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
+			   (unsigned long) entry->busaddr[page_ofs],
 			   entry->handle + tmp_ofs );
 	}
 
