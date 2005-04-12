Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVDLSxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVDLSxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVDLSvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:51:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:1994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262226AbVDLKcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:48 -0400
Message-Id: <200504121032.j3CAWdfE005645@shell0.pdx.osdl.net>
Subject: [patch 127/198] fix module_param_string() calls
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       wesarg@informatik.uni-halle.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bert Wesarg <wesarg@informatik.uni-halle.de>

This patch fix 3 calls to module_param_string() in
driver/media/video/tuner-core.c and drivers/media/video/tda9887.c.  In all
three places, the len and the perm parameter was switched.

Signed-off-by: Bert Wesarg <wesarg@informatik.uni-halle.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/media/video/tda9887.c    |    4 ++--
 25-akpm/drivers/media/video/tuner-core.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/media/video/tda9887.c~fix-module_param_string-calls drivers/media/video/tda9887.c
--- 25/drivers/media/video/tda9887.c~fix-module_param_string-calls	2005-04-12 03:21:34.030963408 -0700
+++ 25-akpm/drivers/media/video/tda9887.c	2005-04-12 03:21:34.035962648 -0700
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
diff -puN drivers/media/video/tuner-core.c~fix-module_param_string-calls drivers/media/video/tuner-core.c
--- 25/drivers/media/video/tuner-core.c~fix-module_param_string-calls	2005-04-12 03:21:34.031963256 -0700
+++ 25-akpm/drivers/media/video/tuner-core.c	2005-04-12 03:21:34.036962496 -0700
@@ -162,7 +162,7 @@ static void set_type(struct i2c_client *
 }
 
 static char pal[] = "-";
-module_param_string(pal, pal, 0644, sizeof(pal));
+module_param_string(pal, pal, sizeof(pal), 0644);
 
 static int tuner_fixup_std(struct tuner *t)
 {
_
