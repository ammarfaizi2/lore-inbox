Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWDIRQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDIRQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWDIRQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 13:16:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:29925 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750810AbWDIRQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 13:16:09 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in cdrom/aztcd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 19:16:06 +0200
Message-Id: <1144602967.19432.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug id #473.
After the for loop i==16 if we dont find a cdrom. So we should
check for i==16 first before checking the array element.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/drivers/cdrom/aztcd.c.orig	2006-04-09 19:09:24.000000000 +0200
+++ linux-2.6.17-rc1/drivers/cdrom/aztcd.c	2006-04-09 19:09:49.000000000 +0200
@@ -1763,7 +1763,7 @@ static int __init aztcd_init(void)
 				release_region(azt_port, 4);
 			}
 		}
-		if ((azt_port_auto[i] == 0) || (i == 16)) {
+		if ((i == 16) || (azt_port_auto[i] == 0)) {
 			printk(KERN_INFO "aztcd: no AZTECH CD-ROM drive found\n");
 			return -EIO;
 		}


