Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbULFVEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbULFVEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbULFVDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:03:25 -0500
Received: from math.ut.ee ([193.40.5.125]:13210 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261648AbULFVBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:01:47 -0500
Date: Mon, 6 Dec 2004 23:01:44 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "shadows global" warning
Message-ID: <Pine.SOC.4.61.0412062300260.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "declaration of `jiffies' shadows a global declaration"
occuring on line 236

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/include/linux/time.h	2004-08-14 10:55:35.000000000 +0000
+++ b/include/linux/time.h	2004-12-02 21:16:18.000000000 +0000
@@ -233,13 +233,13 @@
  }

  static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(const unsigned long jiffy_count, struct timespec *value)
  {
  	/*
  	 * Convert jiffies to nanoseconds and separate with
  	 * one divide.
  	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC; 
+	u64 nsec = (u64)jiffy_count * TICK_NSEC;
  	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
  }

