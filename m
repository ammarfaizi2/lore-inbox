Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263383AbVCJXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbVCJXQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbVCJXPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:15:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:33242 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263382AbVCJXKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:21 -0500
Date: Thu, 10 Mar 2005 15:08:14 -0800
From: Greg KH <greg@kroah.com>
To: eich@pdx.freedesktop.org, dri-devel@lists.sourceforge.net,
       airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [03/11] drm missing memset can crash X server..
Message-ID: <20050310230814.GD22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


Egbert Eich reported a bug 2673 on bugs.freedesktop.org and tracked it
down to a missing memset in the setversion ioctl, this causes X server
crashes...

From: Egbert Eich <eich@pdx.freedesktop.org>
Signed-off-by: Dave Airlie <airlied@linux.ie>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

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

