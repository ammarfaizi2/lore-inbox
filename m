Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTDHTJ1 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTDHTJ1 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:09:27 -0400
Received: from smtp02.web.de ([217.72.192.151]:42770 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261609AbTDHTJZ convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:09:25 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: =?iso-8859-2?q?Pawe=B3=20Go=B3aszewski?= <blues@ds.pg.gda.pl>
Subject: Re: [2.5.67] gen_rtc compile error
Date: Tue, 8 Apr 2003 21:20:39 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304082120.39576.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 20:37, Pawe³ Go³aszewski wrote:
> When I try to build my kernel I get:
>
> [...]
>
> My kernel configuration:
> http://piorun.ds.pg.gda.pl/~blues/config-2.5.67.txt

Battery status seems to be not available on all architectures.
(I don't know the reason for this.)
With this patch, it should compile (against 2.5.67):

--- drivers/char/genrtc.c.orig	2003-04-08 21:15:52.000000000 +0200
+++ drivers/char/genrtc.c	2003-04-08 21:17:33.000000000 +0200
@@ -486,7 +486,9 @@
 		     "update_IRQ\t: %s\n"
 		     "periodic_IRQ\t: %s\n"
 		     "periodic_freq\t: %ld\n"
+#ifdef RTC_BATT_BAD
 		     "batt_status\t: %s\n",
+#endif
 		     (flags & RTC_DST_EN) ? "yes" : "no",
 		     (flags & RTC_DM_BINARY) ? "no" : "yes",
 		     (flags & RTC_24H) ? "yes" : "no",
@@ -494,8 +496,11 @@
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


BUT: Is bat-state *really* not supported on all platforms?

Regards
Michael Buesch.

