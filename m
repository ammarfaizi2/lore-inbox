Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130143AbRB1NHW>; Wed, 28 Feb 2001 08:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbRB1NHM>; Wed, 28 Feb 2001 08:07:12 -0500
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:49029 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S130143AbRB1NGz>; Wed, 28 Feb 2001 08:06:55 -0500
Message-ID: <3A9CF79F.38751994@valinux.com>
Date: Thu, 01 Mar 2001 00:05:35 +1100
From: Gareth Hughes <gareth@valinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] r128 DRM module -- hardware bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch addresses a serious problem with older Rage 128
chipsets, up to and including at least the Rage 128 RF chipset found on
the Xpert 2000.  The workaround should be classed as a critical fix, as
without it such cards will lock almost immediately.

-- Gareth

--- linux/drivers/char/drm/r128_drv.h	Fri Jan  5 08:03:20 2001
+++ linux.gh/drivers/char/drm/r128_drv.h	Thu Mar  1 00:03:35 2001
@@ -447,6 +447,11 @@
 		DRM_INFO( "ADVANCE_RING() tail=0x%06x wr=0x%06x\n",	\
 			  write, dev_priv->ring.tail );			\
 	}								\
+	if ( write < 32 ) {						\
+		memcpy( dev_priv->ring.end,				\
+			dev_priv->ring.start,				\
+			write * sizeof(u32) );				\
+	}								\
 	r128_flush_write_combine();					\
 	dev_priv->ring.tail = write;					\
 	R128_WRITE( R128_PM4_BUFFER_DL_WPTR, write );			\
