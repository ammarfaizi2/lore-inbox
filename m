Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVCJFqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVCJFqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVCJFou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:44:50 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:24301 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262483AbVCIWUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:20:02 -0500
Date: Wed, 9 Mar 2005 22:20:02 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: stable@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] drm missing memset can crash X server..
Message-ID: <Pine.LNX.4.58.0503092217240.17853@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Egbert Eich reported a bug 2673 on bugs.freedesktop.org and tracked it
down to a missing memset in the setversion ioctl, this causes X server
crashes...

From: Egbert Eich <eich@pdx.freedesktop.org>
Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drm_ioctl.c b/drivers/char/drm/drm_ioctl.c
--- a/drivers/char/drm/drm_ioctl.c	2005-03-09 10:53:42 +11:00
+++ b/drivers/char/drm/drm_ioctl.c	2005-03-09 10:53:43 +11:00
@@ -326,6 +326,8 @@

 	DRM_COPY_FROM_USER_IOCTL(sv, argp, sizeof(sv));

+	memset(&version, 0, sizeof(version));
+
 	dev->driver->version(&version);
 	retv.drm_di_major = DRM_IF_MAJOR;
 	retv.drm_di_minor = DRM_IF_MINOR;
