Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTDHTef (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTDHTef (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:34:35 -0400
Received: from smtp03.web.de ([217.72.192.158]:10763 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261644AbTDHTee (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:34:34 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [2.5.67] gen_rtc compile error
Date: Tue, 8 Apr 2003 21:46:07 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl> <200304082130.07080.freesoftwaredeveloper@web.de> <jek7e4ixqc.fsf@sykes.suse.de>
In-Reply-To: <jek7e4ixqc.fsf@sykes.suse.de>
Cc: linux-kernel@vger.kernel.org,
       =?utf-8?q?Pawe=C5=82=20Go=C5=82aszewski?= <blues@ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304082146.07124.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 21:40, Andreas Schwab wrote:
> Michael Buesch <freesoftwaredeveloper@web.de> writes:
> |> Correcting my patch: ;)
>
> Still not right.
>
> [...]
>
> Lacks a close paren if !RTC_BATT_BAD.
>
> Andreas.

Uhh, must be *very* hard to post the correct patch at first time
trying it. :)


--- drivers/char/genrtc.c.orig	2003-04-08 21:15:52.000000000 +0200
+++ drivers/char/genrtc.c	2003-04-08 21:43:37.000000000 +0200
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
+		     ,(flags & RTC_BATT_BAD) ? "bad" : "okay"
+#endif
+		     );
 	if (!get_rtc_pll(&pll))
 	    p += sprintf(p,
 			 "PLL adjustment\t: %d\n"

