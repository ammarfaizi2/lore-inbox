Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUBBUjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbUBBUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:36:48 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:50562 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266015AbUBBUC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:02:58 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:02:54 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 34/42]
Message-ID: <20040202200254.GH6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


r128_cce.c:357: warning: unsigned int format, different type arg (arg 3)
radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)

dma_addr_t can be 64 bit long even on x86 (when CONFIG_HIGHMEM64G is
defined). Cast to dma64_addr_t in the printk.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/drm/r128_cce.c linux-2.4/drivers/char/drm/r128_cce.c
--- linux-2.4-vanilla/drivers/char/drm/r128_cce.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/char/drm/r128_cce.c	Sat Jan 31 18:59:21 2004
@@ -352,8 +352,8 @@
 
 		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
      			    entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08Lx handle=0x%08lx\n",
+			   (dma64_addr_t)entry->busaddr[page_ofs],
      			   entry->handle + tmp_ofs );
 	}
 
diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/drm/radeon_cp.c linux-2.4/drivers/char/drm/radeon_cp.c
--- linux-2.4-vanilla/drivers/char/drm/radeon_cp.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/char/drm/radeon_cp.c	Sat Jan 31 19:00:12 2004
@@ -903,8 +903,8 @@
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			     entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08Lx handle=0x%08lx\n",
+			   (dma64_addr_t)entry->busaddr[page_ofs],
 			   entry->handle + tmp_ofs );
 	}
 

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)
