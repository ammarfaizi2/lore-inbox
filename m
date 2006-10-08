Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWJHSmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWJHSmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWJHSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:42:21 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:60333 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751321AbWJHSmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:42:16 -0400
Message-ID: <45294686.6050003@linuxtv.org>
Date: Sun, 08 Oct 2006 14:42:14 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: linux-kernel@vger.kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mike Isely <isely@pobox.com>
Subject: [2.6.18.y PATCH 5/6] pvrusb2: Suppress compiler warning
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 8e9961660bc5701f82970c4b5a2eb239efb5c2d1 Mon Sep 17 00:00:00 2001
From: Mike Isely <isely@pobox.com>
Date: Sun, 24 Sep 2006 10:45:28 -0400
Subject: [PATCH] pvrusb2: Suppress compiler warning

The pvrusb2 driver needs to call video_devdata() in order to correctly
transform a file pointer into a video_device pointer.  Unfortunately
the prototype for this function has been marked V4L1-only and there's
no official substitute that I can find for V4L2.  Adding to the
mystery is that the implementation for this function exists whether or
not V4L1 compatibility has been selected.  The upshot of all this is
that we get a compilation warning here about a missing prototype but
the code links OK.  This fix solves the warning by copying the
prototype into the source file that is using it.  Yes this is a hack,
but it's a safe one for 2.6.18 (any alternative would be much more
intrusive).  A better solution should be forthcoming for the next
kernel.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
index 128e6b5..385b715 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -32,6 +32,12 @@ #include "pvrusb2-ioread.h"
 #include <linux/videodev2.h>
 #include <media/v4l2-common.h>
 
+/* Mike Isely <isely@pobox.com> 23-Sep-2006 - This function is prototyped
+ * only for V4L1 but is implemented regardless of the V4L1 compatibility
+ * option state.  V4L2 has no replacement for this and we need it.  For now
+ * copy the prototype here so we can avoid the compiler warning. */
+extern struct video_device* video_devdata(struct file*);
+
 struct pvr2_v4l2_dev;
 struct pvr2_v4l2_fh;
 struct pvr2_v4l2;
