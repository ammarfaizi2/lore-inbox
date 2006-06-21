Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWFUUHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWFUUHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWFUUHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:07:14 -0400
Received: from mail.gmx.net ([213.165.64.21]:37566 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030199AbWFUUHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:07:12 -0400
X-Authenticated: #704063
Subject: [Patch] Ignored return value in drivers/mtd/chips/sharp.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: ds@schleef.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 22:07:08 +0200
Message-Id: <1150920428.24106.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity (id #10) spotted that we never reach the return ret; statement,
since ret never gets assigned a value except the 0 at
initialisation. I assume it was meant to hold the result
of sharp_write_oneword().

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6/drivers/mtd/chips/sharp.c.orig	2006-06-21 22:03:45.000000000 +0200
+++ linux-2.6/drivers/mtd/chips/sharp.c	2006-06-21 22:04:48.000000000 +0200
@@ -342,7 +342,8 @@ static int sharp_write(struct mtd_info *
 			len--;
 			j++;
 		}
-		sharp_write_oneword(map, &sharp->chips[chipnum], ofs&~3, tbuf.l);
+		ret = sharp_write_oneword(map, &sharp->chips[chipnum],
+						ofs&~3, tbuf.l);
 		if(ret<0)
 			return ret;
 		(*retlen)+=j;


