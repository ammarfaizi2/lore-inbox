Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDOQQg (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDOQQf 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:16:35 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6791 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261727AbTDOQQe 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:16:34 -0400
Date: Tue, 15 Apr 2003 12:28:24 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [TRIVIAL PATCH] sync_dquots_dev in Linux 2.4.21-pre7-ac1
Message-ID: <Pine.LNX.4.53.0304151217310.28540@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm get this error if I compile 2.4.21-pre7-ac1 without CONFIG_QUOTA
defined:

fs/fs.o: In function `do_quotactl':
fs/fs.o(.text+0x1b362): undefined reference to `sync_dquots_dev'
make: *** [vmlinux] Error 1

sync_dquots_dev() is only implemented if CONFIG_QUOTA is defined.
However, quote.c uses it unconditionally.  include/linux/quotaops.h has
some macros to disable some functions when CONFIG_QUOTA is undefined, so
it's probably where the fix belongs.  This patch helps:

==============================
--- linux.orig/include/linux/quotaops.h
+++ linux/include/linux/quotaops.h
@@ -193,6 +193,7 @@
 #define DQUOT_SYNC_SB(sb)			do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
+#define sync_dquots_dev(dev, type)		do { } while(0)
 extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
==============================

-- 
Regards,
Pavel Roskin
