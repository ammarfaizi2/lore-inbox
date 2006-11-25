Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967164AbWKYUbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967164AbWKYUbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967166AbWKYUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:31:13 -0500
Received: from 1wt.eu ([62.212.114.60]:42244 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S967164AbWKYUbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:31:12 -0500
Date: Sat, 25 Nov 2006 22:22:09 +0100
From: Willy Tarreau <w@1wt.eu>
To: geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] fbcon: incorrect use of "&&" instead of "&"
Message-ID: <20061125212209.GA5918@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I'm about to merge this in 2.4. Do you have any objection ?

Thanks,
Willy

>From c969fc8009aeb748368319cec463ae2516f6fb17 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sat, 25 Nov 2006 21:54:10 +0100
Subject: [PATCH] fbcon: incorrect use of "&&" instead of "&"

The use of "&&" in the following statement causes unexpected
cases to be matched since __SCROLL_YMASK = 0x0f :

    switch (p->scrollmode && __SCROLL_YMASK)
        case __SCROLL_YWRAP: ...  /* 0x02 */
        case __SCROLL_YPAN: ...   /* 0x01 */

The YWRAP case can never be matched and the YPAN case may be
matched by mistake. Obvious fix is to replace && with &. This
bug is not present in 2.6.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/video/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbcon.c b/drivers/video/fbcon.c
index 0fb40c5..1f66819 100644
--- a/drivers/video/fbcon.c
+++ b/drivers/video/fbcon.c
@@ -2102,7 +2102,7 @@ static int fbcon_scrolldelta(struct vc_d
 
     offset = p->yscroll-scrollback_current;
     limit = p->vrows;
-    switch (p->scrollmode && __SCROLL_YMASK) {
+    switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 	    p->var.vmode |= FB_VMODE_YWRAP;
 	    break;
-- 
1.4.2.4

