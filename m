Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSBDATG>; Sun, 3 Feb 2002 19:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSBDAS4>; Sun, 3 Feb 2002 19:18:56 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:51462 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S287919AbSBDASp>; Sun, 3 Feb 2002 19:18:45 -0500
Date: Sun, 3 Feb 2002 17:18:36 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Warnings in drm modules - 2.4.18pre...
Message-ID: <20020203171836.B12981@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following, obvious (DMA_BLOCK_SIZE is of size_t type) and otherwise
harmless, patch kills literally few hundreds compilation warnings on
64-bit platforms.

--- linux-2.4.18p7/drivers/char/drm/mga_drv.h~	Mon Aug 27 08:40:33 2001
+++ linux-2.4.18p7/drivers/char/drm/mga_drv.h	Sun Feb  3 15:46:16 2002
@@ -247,7 +247,7 @@
 	if ( MGA_VERBOSE ) {						\
 		DRM_INFO( "BEGIN_DMA( %d ) in %s\n",			\
 			  (n), __FUNCTION__ );				\
-		DRM_INFO( "   space=0x%x req=0x%x\n",			\
+		DRM_INFO( "   space=0x%x req=0x%lx\n",			\
 			  dev_priv->prim.space, (n) * DMA_BLOCK_SIZE );	\
 	}								\
 	prim = dev_priv->prim.start;					\
@@ -297,7 +297,7 @@
 #define DMA_WRITE( offset, val )					\
 do {									\
 	if ( MGA_VERBOSE ) {						\
-		DRM_INFO( "   DMA_WRITE( 0x%08x ) at 0x%04x\n",		\
+		DRM_INFO( "   DMA_WRITE( 0x%08x ) at 0x%04lx\n",	\
 			  (u32)(val), write + (offset) * sizeof(u32) );	\
 	}								\
 	*(volatile u32 *)(prim + write + (offset) * sizeof(u32)) = val;	\

Can it be applied, please, if only to reduce noise?

Once we are at it here is another patch of a similar character:

--- linux-2.4.18p7/drivers/char/drm/radeon_cp.c~	Fri Sep 14 15:29:41 2001
+++ linux-2.4.18p7/drivers/char/drm/radeon_cp.c	Sun Feb  3 15:30:19 2002
@@ -623,7 +623,7 @@
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			     entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
 			   entry->busaddr[page_ofs],
 			   entry->handle + tmp_ofs );
 	}
--- linux-2.4.18p7/drivers/char/drm/r128_cce.c~	Mon Aug 27 08:40:33 2001
+++ linux-2.4.18p7/drivers/char/drm/r128_cce.c	Sun Feb  3 15:30:10 2002
@@ -352,7 +352,7 @@
 
 		R128_WRITE( R128_PM4_BUFFER_DL_RPTR_ADDR,
      			    entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
 			   entry->busaddr[page_ofs],
      			   entry->handle + tmp_ofs );
 	}

although results are not spectacular. :-)

  Michal
