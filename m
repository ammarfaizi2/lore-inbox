Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751304AbWFETGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWFETGS (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWFETGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:06:18 -0400
Received: from mail.gmx.de ([213.165.64.20]:7888 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751304AbWFETGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:06:17 -0400
X-Authenticated: #704063
Subject: [Patch] Fix typo in drivers/isdn/hisax/q931.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: isdn4linux@listserv.isdn4linux.de
Content-Type: text/plain
Date: Mon, 05 Jun 2006 21:06:14 +0200
Message-Id: <1149534374.16598.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug #517. 
Since IESIZE is greater than IESIZE_NI1 we might run past the end
of ielist_ni1. This fixes it by using the proper IESIZE_NI1 define.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de> 

--- linux-2.6.17-rc5/drivers/isdn/hisax/q931.c.orig	2006-06-05 20:57:11.000000000 +0200
+++ linux-2.6.17-rc5/drivers/isdn/hisax/q931.c	2006-06-05 20:57:50.000000000 +0200
@@ -1402,12 +1402,12 @@ dlogframe(struct IsdnCardState *cs, stru
 			}
 			/* No, locate it in the table */
 			if (cset == 0) {
-				for (i = 0; i < IESIZE; i++)
+				for (i = 0; i < IESIZE_NI1; i++)
 					if (*buf == ielist_ni1[i].nr)
 						break;
 
 				/* When not found, give appropriate msg */
-				if (i != IESIZE) {
+				if (i != IESIZE_NI1) {
 					dp += sprintf(dp, "  %s\n", ielist_ni1[i].descr);
 					dp += ielist_ni1[i].f(dp, buf);
 				} else


