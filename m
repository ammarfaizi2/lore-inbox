Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVKDWKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVKDWKI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVKDWKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:10:08 -0500
Received: from verein.lst.de ([213.95.11.210]:63653 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751017AbVKDWKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:10:07 -0500
Date: Fri, 4 Nov 2005 23:09:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] re-add TIOCSTART and TIOCSTOP compat_ioctl handlers
Message-ID: <20051104220951.GA9301@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't implement these ioctls, but some architectures define them
in the headers.  Bash picks them up and issues them frequently.  Add
compat_ioctl handlers to silence warnings about unhandled copat ioctls.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/compat_ioctl.c
===================================================================
--- linux-2.6.orig/fs/compat_ioctl.c	2005-11-02 11:04:41.000000000 +0100
+++ linux-2.6/fs/compat_ioctl.c	2005-11-02 11:04:56.000000000 +0100
@@ -3050,6 +3050,16 @@
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
 #endif
+#ifdef TIOCSTART
+/*
+ * For these two we have defintions in ioctls.h and/or termios.h on
+ * some architectures but no actual implemention.  Some applications
+ * like bash call them if they are defined in the headers, so we provide
+ * entries here to avoid syslog message spew.
+ */
+COMPATIBLE_IOCTL(TIOCSTART)
+COMPATIBLE_IOCTL(TIOCSTOP)
+#endif
 /* Usbdevfs */
 HANDLE_IOCTL(USBDEVFS_CONTROL32, do_usbdevfs_control)
 HANDLE_IOCTL(USBDEVFS_BULK32, do_usbdevfs_bulk)
