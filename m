Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbTHVHak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbTHVHak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:30:40 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:35849 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263035AbTHVGrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:47:40 -0400
Date: Fri, 22 Aug 2003 03:46:55 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       dri-devel@lists.sourceforge.net
Subject: [PATCH][resend] 1/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/char/drm-4.0
Message-Id: <20030822034655.5a8a89c2.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 drmP.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.4.22-rc2/drivers/char/drm-4.0/drmP.h	2002-02-25 16:37:57.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/char/drm-4.0/drmP.h	2003-08-21 00:08:28.000000000 -0300
@@ -257,9 +257,9 @@
 
 				/* Macros to make printk easier */
 #define DRM_ERROR(fmt, arg...) \
-	printk(KERN_ERR "[" DRM_NAME ":" __FUNCTION__ "] *ERROR* " fmt , ##arg)
+	printk(KERN_ERR "[" DRM_NAME ":%s] *ERROR* " fmt , __FUNCTION__, ##arg)
 #define DRM_MEM_ERROR(area, fmt, arg...) \
-	printk(KERN_ERR "[" DRM_NAME ":" __FUNCTION__ ":%s] *ERROR* " fmt , \
+	printk(KERN_ERR "[" DRM_NAME ":%s:%s] *ERROR* " fmt , __FUNCTION__,\
 	       drm_mem_stats[area].name , ##arg)
 #define DRM_INFO(fmt, arg...)  printk(KERN_INFO "[" DRM_NAME "] " fmt , ##arg)
 
@@ -268,7 +268,7 @@
 	do {								  \
 		if (drm_flags&DRM_FLAG_DEBUG)				  \
 			printk(KERN_DEBUG				  \
-			       "[" DRM_NAME ":" __FUNCTION__ "] " fmt ,	  \
+			       "[" DRM_NAME ":%s] " fmt , __FUNCTION__,   \
 			       ##arg);					  \
 	} while (0)
 #else

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
