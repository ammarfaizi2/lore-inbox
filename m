Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTERT6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTERT6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:58:32 -0400
Received: from verein.lst.de ([212.34.181.86]:54281 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262177AbTERT6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:58:31 -0400
Date: Sun, 18 May 2003 22:11:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make pmac compile again
Message-ID: <20030518221125.A30290@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two little patches (already in the linuxppc BK tree) to get BK current
compile again on pmac.


--- 1.12/drivers/ide/ppc/pmac.c	Mon May 12 02:09:46 2003
+++ edited/drivers/ide/ppc/pmac.c	Sat May 17 15:31:07 2003
@@ -721,7 +721,7 @@
 		}
 	}
 
-	return NODEV;
+	return 0;
 }
 
 void __init
--- 1.13/drivers/macintosh/adbhid.c	Wed Feb 12 10:41:01 2003
+++ edited/drivers/macintosh/adbhid.c	Sat May 17 21:30:20 2003
@@ -84,7 +84,7 @@
 
 static void adbhid_probe(void);
 
-static void adbhid_input_keycode(int, int, int);
+static void adbhid_input_keycode(int, int, int, struct pt_regs *);
 static void leds_done(struct adb_request *);
 
 static void init_trackpad(int id);
@@ -140,7 +140,7 @@
 }
 
 static void
-adbhid_input_keycode(int id, int keycode, int repeat, pt_regs *regs)
+adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	int up_flag;
 
