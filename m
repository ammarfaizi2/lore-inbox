Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVJAXvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVJAXvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVJAXvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:51:55 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:1424 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750907AbVJAXvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:51:55 -0400
Date: Sat, 1 Oct 2005 16:20:59 -0400
From: Christopher Li <chrisl@vmware.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: [PATCH] incrase usbdevfs bulk buffer size
Message-ID: <20051001202059.GE3453@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the usbdevfs buffer size limit.

I hit this limit with running ehci in the VM. The a single ehci
qTD transfer buffer can be 5 pages long, that is 20K. The current devio bulk
transfer limit is 16K.  I am not sure why the bulk transfer limit
is 16K. I can complicate the user space part to work around that,
but it seems much simpler just allow usbdevfs to accept bigger buffers.

I did some limited usage test with ehci controller. It seems works for me,
it did use a bigger buffer and nothing blow up.

Signed-Off-By: Christopher Li <chrisl@vmware.com>

Index: linux-2.6.13.2/drivers/usb/core/devio.c
===================================================================
--- linux-2.6.13.2.orig/drivers/usb/core/devio.c	2005-09-28 13:08:10.000000000 -0700
+++ linux-2.6.13.2/drivers/usb/core/devio.c	2005-10-01 04:58:47.000000000 -0700
@@ -72,7 +72,7 @@ MODULE_PARM_DESC (usbfs_snoop, "true to 
 	} while (0)
 
 
-#define	MAX_USBFS_BUFFER_SIZE	16384
+#define	MAX_USBFS_BUFFER_SIZE	(32*1024)
 
 static inline int connected (struct usb_device *dev)
 {
