Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVJDMnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVJDMnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJDMnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:00 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:34531 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932409AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:41:59 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 6/7] HPET: remove superfluous indirections
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124158.23057.30425.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: 4286de93149302de6634a50f16744393
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

In the hpet_ioctl_common() function, devp->hd_hpets is already cached
in the hpetp variable, so we can use just that.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:53:21.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:24.000000000 +0200
@@ -501,8 +501,8 @@ hpet_ioctl_common(struct hpet_dev *devp,
 				info.hi_ireqfreq = 0;
 			info.hi_flags =
 			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
-			info.hi_hpet = devp->hd_hpets->hp_which;
-			info.hi_timer = devp - devp->hd_hpets->hp_dev;
+			info.hi_hpet = hpetp->hp_which;
+			info.hi_timer = devp - hpetp->hp_dev;
 			if (kernel)
 				memcpy((void *)arg, &info, sizeof(info));
 			else
