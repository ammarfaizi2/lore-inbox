Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVCWXXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVCWXXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCWXXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:23:46 -0500
Received: from mail.dif.dk ([193.138.115.101]:18865 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262011AbVCWXXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:23:44 -0500
Date: Thu, 24 Mar 2005 00:25:31 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] verify_area to access_ok conversion in drivers/char/drm/drm_os_linux.h
Message-ID: <Pine.LNX.4.62.0503240021330.7460@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


verify_area is deprecated, replaced by access_ok.
Seems I missed this one when I did the big overall conversion.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drm_os_linux.h	2005-03-21 23:12:26.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/drm_os_linux.h	2005-03-24 00:18:57.000000000 +0100
@@ -89,7 +89,7 @@ static __inline__ int mtrr_del (int reg,
 	copy_to_user(arg1, arg2, arg3)
 /* Macros for copyfrom user, but checking readability only once */
 #define DRM_VERIFYAREA_READ( uaddr, size ) 		\
-	verify_area( VERIFY_READ, uaddr, size )
+	(access_ok( VERIFY_READ, uaddr, size ) ? 0 : -EFAULT)
 #define DRM_COPY_FROM_USER_UNCHECKED(arg1, arg2, arg3) 	\
 	__copy_from_user(arg1, arg2, arg3)
 #define DRM_COPY_TO_USER_UNCHECKED(arg1, arg2, arg3)	\


