Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946880AbWKANvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946880AbWKANvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946879AbWKANvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:51:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946883AbWKANvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:51:06 -0500
Date: Wed, 1 Nov 2006 10:50:51 -0300
From: Glauber de Oliveira Costa <gcosta@redhat.com>
To: dri-devel@lists.sourceforge.net, airlied@linux.ie,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] use printk_ratelimit() inside DRM_DEBUG
Message-ID: <20061101135051.GH17565@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

the DRM_DEBUG macro can be called within functions very oftenly
triggered, thus generating lots of message load and potentially
compromising system

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="drm_debug.patch"

--- linux-2.6.18.x86_64/drivers/char/drm/drmP.h.orig	2006-11-01 08:00:18.000000000 -0500
+++ linux-2.6.18.x86_64/drivers/char/drm/drmP.h	2006-11-01 08:06:27.000000000 -0500
@@ -185,7 +185,7 @@
 #if DRM_DEBUG_CODE
 #define DRM_DEBUG(fmt, arg...)						\
 	do {								\
-		if ( drm_debug )			\
+		if ( drm_debug && printk_ratelimit() )			\
 			printk(KERN_DEBUG				\
 			       "[" DRM_NAME ":%s] " fmt ,	\
 			       __FUNCTION__ , ##arg);			\

--wLAMOaPNJ0fu1fTG--
