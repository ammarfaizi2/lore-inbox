Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbTBKJnM>; Tue, 11 Feb 2003 04:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbTBKJnM>; Tue, 11 Feb 2003 04:43:12 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24032 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267550AbTBKJnL>;
	Tue, 11 Feb 2003 04:43:11 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 11 Feb 2003 10:52:39 +0100 (MET)
Message-Id: <UTC200302110952.h1B9qd125066.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] genhd device unregistration fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Sat Jan 18 23:54:33 2003
+++ b/drivers/block/genhd.c	Tue Feb 11 09:47:29 2003
@@ -74,7 +74,7 @@
 	down_write(&block_subsys.rwsem);
 	for (s = &probes[index]; *s; s = &(*s)->next) {
 		struct blk_probe *p = *s;
-		if (p->dev == dev || p->range == range) {
+		if (p->dev == dev && p->range == range) {
 			*s = p->next;
 			kfree(p);
 			break;
