Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUFPCKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUFPCKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbUFPCKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:10:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18930 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S266065AbUFPCKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:10:31 -0400
Date: Tue, 15 Jun 2004 19:10:23 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] make ps2 mouse work ...
Message-ID: <20040615191023.G28403@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I found this problem on a MIPS machine.  The problem is 
likely to happen on other register-rich RISC arches too.

cmdcnt needs to be volatile since it is modified by
irq routine and read by normal process context.

Jun

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="040615.a-psmouse-cmdcnt-volatile.patch"

diff -Nru linux/drivers/input/mouse/psmouse.h.orig linux/drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse/psmouse.h.orig	2004-04-16 15:28:47.000000000 -0700
+++ linux/drivers/input/mouse/psmouse.h	2004-06-15 18:51:53.000000000 -0700
@@ -40,7 +40,7 @@
 	char *name;
 	unsigned char cmdbuf[8];
 	unsigned char packet[8];
-	unsigned char cmdcnt;
+	volatile unsigned char cmdcnt;
 	unsigned char pktcnt;
 	unsigned char type;
 	unsigned char model;

--FCuugMFkClbJLl1L--
