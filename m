Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUCIQXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCIQXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:23:51 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:17388 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262048AbUCIQXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:23:49 -0500
Date: Tue, 9 Mar 2004 16:20:39 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: [SECURITY] CAN-2004-0003 R128 DRI limits checking.
Message-ID: <20040309162039.GC28660@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, dri-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This got fixed in 2.4, but somehow got missed in 2.6.
http://icat.nist.gov/icat.cfm?cvename=CAN-2004-0003 has more info.

		Dave

--- linux-2.6.3/drivers/char/drm/r128_state.c~	2004-03-09 16:12:59.000000000 +0000
+++ linux-2.6.3/drivers/char/drm/r128_state.c	2004-03-09 16:13:42.000000000 +0000
@@ -915,6 +915,9 @@
 	DRM_DEBUG( "\n" );
 
 	count = depth->n;
+	if (count > 4096 || count <= 0)
+		return -EMSGSIZE;
+
 	if ( DRM_COPY_FROM_USER( &x, depth->x, sizeof(x) ) ) {
 		return DRM_ERR(EFAULT);
 	}
@@ -1008,6 +1011,8 @@
 	DRM_DEBUG( "\n" );
 
 	count = depth->n;
+	if (count > 4096  || count <= 0)
+		return -EMSGSIZE;
 
 	xbuf_size = count * sizeof(*x);
 	ybuf_size = count * sizeof(*y);
@@ -1125,6 +1130,9 @@
 	DRM_DEBUG( "\n" );
 
 	count = depth->n;
+	if (count > 4096 || count <= 0)
+		return -EMSGSIZE;
+
 	if ( DRM_COPY_FROM_USER( &x, depth->x, sizeof(x) ) ) {
 		return DRM_ERR(EFAULT);
 	}
@@ -1167,6 +1175,9 @@
 	DRM_DEBUG( "%s\n", __FUNCTION__ );
 
 	count = depth->n;
+	if (count > 4096 || count <= 0)
+		return -EMSGSIZE;
+
 	if ( count > dev_priv->depth_pitch ) {
 		count = dev_priv->depth_pitch;
 	}
