Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFUNiD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTFUNiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:03 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21666 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262312AbTFUNiA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:00 -0400
Subject: [PATCH 5/11] input: Gameport was never closed after calibrating
In-Reply-To: <10562035173172@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035173709@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1363, 2003-06-21 04:36:19-07:00, devenyga@mcmaster.ca
  input: Fix gameport.c - gameport was never closed after calibrating


 gameport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	Sat Jun 21 15:25:21 2003
+++ b/drivers/input/gameport/gameport.c	Sat Jun 21 15:25:21 2003
@@ -84,6 +84,7 @@
 		if ((t = DELTA(t2,t1) - DELTA(t3,t2)) < tx) tx = t;
 	}
 
+	gameport_close(gameport);
 	return 59659 / (tx < 1 ? 1 : tx);
 
 #else
@@ -93,11 +94,10 @@
 	j = jiffies; while (j == jiffies);
 	j = jiffies; while (j == jiffies) { t++; gameport_read(gameport); }
 
+	gameport_close(gameport);
 	return t * HZ / 1000;
 
 #endif
-
-	gameport_close(gameport);
 }
 
 static void gameport_find_dev(struct gameport *gameport)

