Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVAaXsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVAaXsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVAaXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:47:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63237 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261453AbVAaXmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:07 -0500
Date: Tue, 1 Feb 2005 00:42:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/timer.c: make two variables static
Message-ID: <20050131234205.GK21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 include/linux/timex.h |    2 --
 kernel/timer.c        |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/include/linux/timex.h.old	2004-12-12 03:32:15.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/timex.h	2004-12-12 03:32:54.000000000 +0100
@@ -240,9 +240,7 @@
 extern long time_maxerror;	/* maximum error */
 extern long time_esterror;	/* estimated error */
 
-extern long time_phase;		/* phase offset (scaled us) */
 extern long time_freq;		/* frequency offset (scaled ppm) */
-extern long time_adj;		/* tick adjust (scaled 1 / HZ) */
 extern long time_reftime;	/* time at last adjustment (s) */
 
 extern long time_adjust;	/* The amount of adjtime left */
--- linux-2.6.10-rc2-mm4-full/kernel/timer.c.old	2004-12-12 03:33:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/timer.c	2004-12-12 03:33:20.000000000 +0100
@@ -631,10 +631,10 @@
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-long time_phase;			/* phase offset (scaled us)	*/
+static long time_phase;			/* phase offset (scaled us)	*/
 long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
-long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
+static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;

