Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVAEOlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVAEOlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVAEOlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:41:11 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:13643 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262455AbVAEOkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:40:51 -0500
Date: Wed, 5 Jan 2005 16:40:43 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050105144043.GB19434@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew, all!

Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
here is a patch to deprecate (un)register_ioctl32_conversion.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>


diff -ruI -u linux-2.6.10/include/linux/ioctl32.h linux-2.6.10-ioctls/include/linux/ioctl32.h
--- linux-2.6.10/include/linux/ioctl32.h	2004-12-24 23:33:49.000000000 +0200
+++ linux-2.6.10-ioctls/include/linux/ioctl32.h	2005-01-05 20:19:46.716664232 +0200
@@ -23,9 +23,12 @@
  */ 
 
 #ifdef CONFIG_COMPAT
-extern int register_ioctl32_conversion(unsigned int cmd,
+
+/* The following two calls trigger an unfixable module unload race. */
+/* Deprecated in favor of ioctl_compat in struct file_operations. */
+extern int __deprecated register_ioctl32_conversion(unsigned int cmd,
 				ioctl_trans_handler_t handler);
-extern int unregister_ioctl32_conversion(unsigned int cmd);
+extern int __deprecated unregister_ioctl32_conversion(unsigned int cmd);
 
 #else
 
