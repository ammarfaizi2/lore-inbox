Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVE2FDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVE2FDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVE2FCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:22 -0400
Received: from smtp829.mail.sc5.yahoo.com ([66.163.171.16]:21883 "HELO
	smtp829.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261244AbVE2FBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:09 -0400
Message-Id: <20050529045847.734671000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 10/13] gunze: fix out-of-bound array access
Content-Disposition: inline; filename=gunze-oob-access.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: gunze - fix out-of-bound array access reported by Adrian Bunk.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/gunze.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: work/drivers/input/touchscreen/gunze.c
===================================================================
--- work.orig/drivers/input/touchscreen/gunze.c
+++ work/drivers/input/touchscreen/gunze.c
@@ -68,8 +68,7 @@ static void gunze_process_packet(struct 
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		gunze->data[10] = 0;
-		printk(KERN_WARNING "gunze.c: bad packet: >%s<\n", gunze->data);
+		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
 		return;
 	}
 

