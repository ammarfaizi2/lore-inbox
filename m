Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbTDGXNW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTDGXMp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:12:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59520
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263820AbTDGXFu (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:05:50 -0400
Date: Tue, 8 Apr 2003 01:24:43 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080024.h380OhRt009107@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix up yam for 2.5 locking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/hamradio/yam.c linux-2.5.67-ac1/drivers/net/hamradio/yam.c
--- linux-2.5.67/drivers/net/hamradio/yam.c	2003-02-15 03:39:31.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/hamradio/yam.c	2003-04-04 18:12:23.000000000 +0100
@@ -722,7 +722,6 @@
 	int counter = 100;
 	int i;
 
-	sti();
 
 	for (i = 0; i < NR_PORTS; i++) {
 		yp = &yam_ports[i];
@@ -768,7 +767,6 @@
 	off_t pos = 0;
 	off_t begin = 0;
 
-	cli();
 
 	for (i = 0; i < NR_PORTS; i++) {
 		if (yam_ports[i].iobase == 0 || yam_ports[i].irq == 0)
@@ -803,8 +801,6 @@
 			break;
 	}
 
-	sti();
-
 	*start = buffer + (offset - begin);
 	len -= (offset - begin);
 
