Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269591AbUI3Wgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269591AbUI3Wgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269604AbUI3Wd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:33:59 -0400
Received: from peabody.ximian.com ([130.57.169.10]:44484 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269591AbUI3WcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:32:13 -0400
Subject: Re: [patch] inotify: make user visible types portable
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096583108.4203.86.camel@betsy.boston.ximian.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096583108.4203.86.camel@betsy.boston.ximian.com>
Content-Type: multipart/mixed; boundary="=-UeCpAMRgmj4ty3h380ar"
Date: Thu, 30 Sep 2004 18:30:47 -0400
Message-Id: <1096583447.4203.88.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UeCpAMRgmj4ty3h380ar
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-09-30 at 18:25 -0400, Robert Love wrote:

> (speaking of which, we had 'mask' as an 'unsigned long' inside inotify.c,
> so this change was needed anyhow).

Ugh.  We _also_ add mask sprinkled about as an int.

This patch makes those __u32 types, too.

	Robert Love


--=-UeCpAMRgmj4ty3h380ar
Content-Disposition: attachment; filename=inotify-more-mask-type-changes-1.patch
Content-Type: text/x-patch; name=inotify-more-mask-type-changes-1.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

s/int mask/__u32 mask/

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-inotify/drivers/char/inotify.c	2004-09-30 18:25:19.102473088 -0400
+++ linux/drivers/char/inotify.c	2004-09-30 18:29:03.495360184 -0400
@@ -136,7 +136,7 @@
 	iput(inode);
 }
 
-struct inotify_kernel_event *kernel_event(int wd, int mask,
+struct inotify_kernel_event *kernel_event(int wd, __u32 mask,
 					  const char *filename)
 {
 	struct inotify_kernel_event *kevent;
@@ -319,7 +319,7 @@
  * Grabs dev->lock, so the caller must not hold it.
  */
 static struct inotify_watcher *create_watcher(struct inotify_device *dev,
-					      int mask, struct inode *inode)
+					      __u32 mask, struct inode *inode)
 {
 	struct inotify_watcher *watcher;
 

--=-UeCpAMRgmj4ty3h380ar--

