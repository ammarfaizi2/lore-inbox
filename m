Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946513AbWKAFjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946513AbWKAFjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946518AbWKAFjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:39:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45713 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946514AbWKAFjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:39:09 -0500
Message-Id: <20061101053757.260569000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:58 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 18/61] Fix uninitialised spinlock in via-pmu-backlight code.
Content-Disposition: inline; filename=fix-uninitialised-spinlock-in-via-pmu-backlight-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Woodhouse <dwmw2@infradead.org>

[PATCH] Fix uninitialised spinlock in via-pmu-backlight code.

The uninitialised pmu_backlight_lock causes the current Fedora test kernel
(which has spinlock debugging enabled) to panic on suspend.

This is suboptimal, so I fixed it.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/macintosh/via-pmu-backlight.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/drivers/macintosh/via-pmu-backlight.c
+++ linux-2.6.18.1/drivers/macintosh/via-pmu-backlight.c
@@ -16,7 +16,7 @@
 #define MAX_PMU_LEVEL 0xFF
 
 static struct backlight_properties pmu_backlight_data;
-static spinlock_t pmu_backlight_lock;
+static DEFINE_SPINLOCK(pmu_backlight_lock);
 static int sleeping;
 static u8 bl_curve[FB_BACKLIGHT_LEVELS];
 

--
