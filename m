Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263682AbTCUW0u>; Fri, 21 Mar 2003 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263672AbTCUSLQ>; Fri, 21 Mar 2003 13:11:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39043
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263682AbTCUSK1>; Fri, 21 Mar 2003 13:10:27 -0500
Date: Fri, 21 Mar 2003 19:25:41 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211925.h2LJPfFh025753@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: unbreak the acquirewdt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This puts back a MOD_INC_USE which leaves a warning but means that the
driver doesnt now load/unload and disable the watchdog on a close

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/watchdog/acquirewdt.c linux-2.5.65-ac2/drivers/char/watchdog/acquirewdt.c
--- linux-2.5.65/drivers/char/watchdog/acquirewdt.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/watchdog/acquirewdt.c	2003-02-14 18:07:43.000000000 +0000
@@ -141,6 +141,8 @@
 			spin_unlock(&acq_lock);
 			return -EBUSY;
 		}
+		if (nowayout)
+			MOD_INC_USE_COUNT;
 
 		/* Activate */
 		acq_is_open=1;
