Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161946AbWKJSdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161946AbWKJSdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161941AbWKJSdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:33:39 -0500
Received: from www.osadl.org ([213.239.205.134]:8917 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161935AbWKJSdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:33:38 -0500
Message-Id: <20061110182418.134188000@cruncher.tec.linutronix.de>
Date: Fri, 10 Nov 2006 18:32:29 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Helmut Duregger <Helmut.Duregger@student.uibk.ac.at>
Subject: [patch] ktime: Fix signed / unsigned mismatch in ktime_to_ns
Content-Disposition: inline; filename=ktime-fix-signed-unsigned-mismatch.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 32 bit implementation of ktime_to_ns returns unsigned value, while the
64 bit version correctly returns an signed value. There is no current user
affected by this, but it has to be fixed, as ktime values can be negative.

Pointed-out-by: Helmut Duregger <Helmut.Duregger@student.uibk.ac.at>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--

Index: linux-2.6.19-rc5-mm1.orig/include/linux/ktime.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig.orig/include/linux/ktime.h	2006-11-09 12:49:34.000000000 +0100
+++ linux-2.6.19-rc5-mm1.orig/include/linux/ktime.h	2006-11-10 19:22:35.000000000 +0100
@@ -248,9 +248,9 @@ static inline struct timeval ktime_to_ti
  *
  * Returns the scalar nanoseconds representation of kt
  */
-static inline u64 ktime_to_ns(const ktime_t kt)
+static inline s64 ktime_to_ns(const ktime_t kt)
 {
-	return (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
+	return (s64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
 }
 
 #endif

--

