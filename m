Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUJDS2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUJDS2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUJDS0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:26:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:46550 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268279AbUJDSZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:25:23 -0400
Subject: [patch] inotify: make nr_watches unsigned
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096865816.3827.1.camel@vertex>
References: <1096865816.3827.1.camel@vertex>
Content-Type: multipart/mixed; boundary="=-n/yUUbK3s8vmw4jzA33Z"
Date: Mon, 04 Oct 2004 14:23:47 -0400
Message-Id: <1096914227.17426.36.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n/yUUbK3s8vmw4jzA33Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

John,

Attached trivial patch makes nr_watches unsigned.  The value never goes
negative, so we might as well benefit from the increased ranged and
better defined overflow semantics.

Also, manipulating unsigned variables is quicker on all architectures
(modulo SH5, but they like to be rebels).

	Robert Love


--=-n/yUUbK3s8vmw4jzA33Z
Content-Disposition: attachment; filename=inotify-0.12-rml-nr_watches-1.patch
Content-Type: text/x-patch; name=inotify-0.12-rml-nr_watches-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make nr_watches unsigned, or else.

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-10-04 14:15:58.247682768 -0400
+++ linux/drivers/char/inotify.c	2004-10-04 14:21:04.635104800 -0400
@@ -78,7 +78,7 @@
 	struct list_head 	watches;
 	spinlock_t		lock;
 	unsigned int		event_count;
-	int			nr_watches;
+	unsigned int		nr_watches;
 };
 
 struct inotify_watch {

--=-n/yUUbK3s8vmw4jzA33Z--

