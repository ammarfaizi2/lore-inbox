Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVC0M6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVC0M6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 07:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVC0M6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 07:58:50 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:31623 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S261639AbVC0M6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 07:58:32 -0500
Date: Sun, 27 Mar 2005 14:58:27 +0200 (MEST)
From: Bert Wesarg <wesarg@informatik.uni-halle.de>
Subject: [PATCH] fix module_param_string() calls
X-X-Sender: wesarg@turing
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.56.0503271457280.25037@turing>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Scan-Signature: a35061c0abf4d8fa2201d8bd9fe648d3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch fix 3 calls to module_param_string() in
driver/media/video/tuner-core.c and drivers/media/video/tda9887.c.
In all three places, the len and the perm parameter was switched.

Patch is against 2.6.12-rc1.

Signed-off-by: Bert Wesarg <wesarg@informatik.uni-halle.de>

diff -uprN linux-2.6.12-rc1.orig/drivers/media/video/tda9887.c linux-2.6.12-rc1/drivers/media/video/tda9887.c
--- linux-2.6.12-rc1.orig/drivers/media/video/tda9887.c	2005-03-27 14:44:23.000000000 +0200
+++ linux-2.6.12-rc1/drivers/media/video/tda9887.c	2005-03-27 14:48:06.000000000 +0200
@@ -478,9 +478,9 @@ static int tda9887_set_pinnacle(struct t
 /* ---------------------------------------------------------------------- */

 static char pal[] = "-";
-module_param_string(pal, pal, 0644, sizeof(pal));
+module_param_string(pal, pal, sizeof(pal), 0644);
 static char secam[] = "-";
-module_param_string(secam, secam, 0644, sizeof(secam));
+module_param_string(secam, secam, sizeof(secam), 0644);

 static int tda9887_fixup_std(struct tda9887 *t)
 {
diff -uprN linux-2.6.12-rc1.orig/drivers/media/video/tuner-core.c linux-2.6.12-rc1/drivers/media/video/tuner-core.c
--- linux-2.6.12-rc1.orig/drivers/media/video/tuner-core.c	2005-03-27 14:44:23.000000000 +0200
+++ linux-2.6.12-rc1/drivers/media/video/tuner-core.c	2005-03-27 14:47:17.000000000 +0200
@@ -162,7 +162,7 @@ static void set_type(struct i2c_client *
 }

 static char pal[] = "-";
-module_param_string(pal, pal, 0644, sizeof(pal));
+module_param_string(pal, pal, sizeof(pal), 0644);

 static int tuner_fixup_std(struct tuner *t)
 {
