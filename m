Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263811AbTCUT1N>; Fri, 21 Mar 2003 14:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbTCUTZt>; Fri, 21 Mar 2003 14:25:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51844
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263797AbTCUTZj>; Fri, 21 Mar 2003 14:25:39 -0500
Date: Fri, 21 Mar 2003 20:40:55 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212040.h2LKettj026431@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: use new outbsync when sending commands
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-iops.c linux-2.5.65-ac2/drivers/ide/ide-iops.c
--- linux-2.5.65/drivers/ide/ide-iops.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-iops.c	2003-03-07 18:43:58.000000000 +0000
@@ -1035,7 +1056,7 @@
 	hwgroup->expiry		= expiry;
 	hwgroup->timer.expires	= jiffies + timeout;
 	add_timer(&hwgroup->timer);
-	hwif->OUTBSYNC(cmd, IDE_COMMAND_REG);
+	hwif->OUTBSYNC(drive, cmd, IDE_COMMAND_REG);
 	/* Drive takes 400nS to respond, we must avoid the IRQ being
 	   serviced before that. 
 	   
