Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWB0Wd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWB0Wd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWB0Wcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65152 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932472AbWB0Wcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:32:33 -0500
Message-Id: <20060227223400.512003000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:28 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, adaplas@pol.net,
       milang@tal.org, tbm@cyrius.com
Subject: [patch 28/39] [PATCH] gbefb: IP32 gbefb depth change fix
Content-Disposition: inline; filename=gbefb-ip32-gbefb-depth-change-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The gbefb driver does not update the framebuffer layers visual setting when
depth is changed with fbset, resulting in strange colors (very dark blue in
16-bit, almost black in 24-bit).

Signed-off-by: Kaj-Michael Lang <milang@tal.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/video/gbefb.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.15.4.orig/drivers/video/gbefb.c
+++ linux-2.6.15.4/drivers/video/gbefb.c
@@ -656,12 +656,15 @@ static int gbefb_set_par(struct fb_info 
 	switch (bytesPerPixel) {
 	case 1:
 		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_I8);
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 2:
 		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_ARGB5);
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	case 4:
 		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_RGB8);
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	}
 	SET_GBE_FIELD(WID, BUF, val, GBE_BMODE_BOTH);

--
