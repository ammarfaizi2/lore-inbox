Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030687AbWKPIWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030687AbWKPIWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 03:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWKPIWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 03:22:17 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:57740 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030687AbWKPIWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 03:22:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/2] Use freezeable workqueues in XFS
Date: Thu, 16 Nov 2006 09:18:21 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
References: <200611160912.51226.rjw@sisk.pl>
In-Reply-To: <200611160912.51226.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160918.23641.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the workqueues used by XFS freezeable, so their worker threads don't
submit any I/O after the suspend image has been created.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/xfs/linux-2.6/xfs_buf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc5-mm2/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/fs/xfs/linux-2.6/xfs_buf.c
+++ linux-2.6.19-rc5-mm2/fs/xfs/linux-2.6/xfs_buf.c
@@ -1826,11 +1826,11 @@ xfs_buf_init(void)
 	if (!xfs_buf_zone)
 		goto out_free_trace_buf;
 
-	xfslogd_workqueue = create_workqueue("xfslogd");
+	xfslogd_workqueue = create_freezeable_workqueue("xfslogd");
 	if (!xfslogd_workqueue)
 		goto out_free_buf_zone;
 
-	xfsdatad_workqueue = create_workqueue("xfsdatad");
+	xfsdatad_workqueue = create_freezeable_workqueue("xfsdatad");
 	if (!xfsdatad_workqueue)
 		goto out_destroy_xfslogd_workqueue;
 
