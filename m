Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031176AbWI0Wtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031176AbWI0Wtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031180AbWI0Wtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:49:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:9914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031176AbWI0Wtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:49:51 -0400
X-Authenticated: #704063
Subject: [Patch] Remove unnecessary check in drivers/rtc/rtc-v3020.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it
Content-Type: text/plain
Date: Thu, 28 Sep 2006 00:49:36 +0200
Message-Id: <1159397376.14069.5.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

looks like the probe function always gets a valid pdev,
and checking it after dereferencing it is pretty useless.
This patch removes the check (cid #1365)

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git7/drivers/rtc/rtc-v3020.c.orig	2006-09-27 22:18:37.000000000 +0200
+++ linux-2.6.18-git7/drivers/rtc/rtc-v3020.c	2006-09-27 22:18:50.000000000 +0200
@@ -169,9 +169,6 @@ static int rtc_probe(struct platform_dev
 	if (pdev->resource[0].flags != IORESOURCE_MEM)
 		return -EBUSY;
 
-	if (pdev == NULL)
-		return -EBUSY;
-
 	chip = kzalloc(sizeof *chip, GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;


