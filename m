Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUJLO2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUJLO2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJLO1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:27:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26380 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S264377AbUJLOZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:25:41 -0400
Date: Tue, 12 Oct 2004 16:25:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch] 2.6.9-rc4-mm1: USB compile error with PROC_FS=n
Message-ID: <20041012142509.GB18579@stusta.de>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>...
> All 741 patches
>...
> bk-usb.patch
>...


This removes an #ifdef CONFIG_PROC_FS from drivers/usb/core/inode.c 
which is required, since now compilation fails with CONFIG_PROC_FS=n:


<--  snip  -->

...
  CC      drivers/usb/core/inode.o
drivers/usb/core/inode.c: In function `usbfs_init':
drivers/usb/core/inode.c:750: `proc_bus' undeclared (first use in this function)
drivers/usb/core/inode.c:750: (Each undeclared identifier is reported only once
drivers/usb/core/inode.c:750: for each function it appears in.)
make[3]: *** [drivers/usb/core/inode.o] Error 1

<--  snip  -->


The fix is simple:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc4-mm1-full/drivers/usb/core/inode.c.old	2004-10-12 16:20:54.000000000 +0200
+++ linux-2.6.9-rc4-mm1-full/drivers/usb/core/inode.c	2004-10-12 16:23:53.000000000 +0200
@@ -746,8 +746,10 @@
 		return retval;
 	}
 
+#ifdef CONFIG_PROC_FS
 	/* create mount point for usbfs */
 	usbdir = proc_mkdir("usb", proc_bus);
+#endif
 
 	return 0;
 }
