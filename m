Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVJQBUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVJQBUE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 21:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVJQBUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 21:20:04 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:29968 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S932114AbVJQBUC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 21:20:02 -0400
From: Felix Oxley <lkml@oxley.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Fix build warning in hd.c
Date: Mon, 17 Oct 2005 02:19:36 +0100
User-Agent: KMail/1.8.2
Cc: B.Zolnierkiewicz@elka.pw.edu.pl
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510170219.38059.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Oxley <lkml@oxley.org>

Fix:
drivers/ide/legacy/hd.c: In function ‘hd_request’:
drivers/ide/legacy/hd.c:424: warning: ‘stat’ may be used uninitialized in this function

Signed-off-by: Felix Oxley <lkml@oxley.org>
---
--- ./drivers/ide/legacy/hd.orig	2005-10-17 02:05:29.000000000 +0100
+++ ./drivers/ide/legacy/hd.c	2005-10-17 02:06:13.000000000 +0100
@@ -421,7 +421,7 @@ static void bad_rw_intr(void)
 
 static inline int wait_DRQ(void)
 {
-	int retries = 100000, stat;
+	int retries = 100000, stat = 0;
 
 	while (--retries > 0)
 		if ((stat = inb_p(HD_STATUS)) & DRQ_STAT)
