Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTDHTSf (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTDHTSf (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:18:35 -0400
Received: from smtp03.web.de ([217.72.192.158]:56858 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261620AbTDHTSe (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:18:34 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67] gen_rtc compile error
Date: Tue, 8 Apr 2003 21:30:07 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl> <200304082120.39576.freesoftwaredeveloper@web.de>
In-Reply-To: <200304082120.39576.freesoftwaredeveloper@web.de>
Cc: =?iso-8859-2?q?Pawe=B3=20Go=B3aszewski?= <blues@ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304082130.07080.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correcting my patch: ;)

--- drivers/char/genrtc.c.orig	2003-04-08 21:15:52.000000000 +0200
+++ drivers/char/genrtc.c	2003-04-08 21:28:43.000000000 +0200
@@ -486,16 +486,21 @@
 		     "update_IRQ\t: %s\n"
 		     "periodic_IRQ\t: %s\n"
 		     "periodic_freq\t: %ld\n"
-		     "batt_status\t: %s\n",
-		     (flags & RTC_DST_EN) ? "yes" : "no",
+#ifdef RTC_BATT_BAD
+		     "batt_status\t: %s\n"
+#endif
+		     ,(flags & RTC_DST_EN) ? "yes" : "no",
 		     (flags & RTC_DM_BINARY) ? "no" : "yes",
 		     (flags & RTC_24H) ? "yes" : "no",
 		     (flags & RTC_SQWE) ? "yes" : "no",
 		     (flags & RTC_AIE) ? "yes" : "no",
 		     irq_active ? "yes" : "no",
 		     (flags & RTC_PIE) ? "yes" : "no",
-		     0L /* freq */,
-		     (flags & RTC_BATT_BAD) ? "bad" : "okay");
+		     0L /* freq */
+#ifdef RTC_BATT_BAD
+		     ,(flags & RTC_BATT_BAD) ? "bad" : "okay")
+#endif
+		     ;
 	if (!get_rtc_pll(&pll))
 	    p += sprintf(p,
 			 "PLL adjustment\t: %d\n"

