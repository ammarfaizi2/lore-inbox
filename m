Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVCIAEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVCIAEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVCIAAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:00:45 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:36019 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262388AbVCHX6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:58:45 -0500
Date: Tue, 8 Mar 2005 23:58:37 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: greg@kroah.com, chrisw@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm missing memset can crash X server...
Message-ID: <Pine.LNX.4.58.0503082356460.17157@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Egbert Eich reported a bug 2673 on bugs.freedesktop.org and tracked it
down to a missing memset in the setversion ioctl, this causes X server
crashes so I would like to see the fix in a 2.6.11.x tree if possible..

Regards,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

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
