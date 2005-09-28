Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVI1HNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVI1HNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVI1HND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:13:03 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:29315 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030200AbVI1HMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:12:52 -0400
Date: Wed, 28 Sep 2005 09:12:16 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/7] HPET: allow non-power-of-two frequencies
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071216.23025.43840.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: 568c65f24c2a4eafb45e22569274dbdb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was only the RTC hardware that restricted interrupt frequencies to a
power of two.  There is no reason to take over this restriction into the
HPET driver, so remove the offending check.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-27 21:44:11.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-09-27 21:45:12.000000000 +0200
@@ -519,7 +519,7 @@ hpet_ioctl_common(struct hpet_dev *devp,
 			break;
 		}
 
-		if (!arg || (arg & (arg - 1))) {
+		if (!arg) {
 			err = -EINVAL;
 			break;
 		}
