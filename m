Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUCWXT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUCWXT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:19:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:6784 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262906AbUCWXSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:18:16 -0500
Subject: [PATCH] More pmac-zilog sleep fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080082996.23208.144.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 10:03:17 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the long story of "BenH can't get a simple fix right the first time",
please add this one to pmac_zilog, and now people should enjoy really
working sleep again on pmac laptops ...

If the serial port was closed, we could use an uninitialized "pwr_delay"
and pass that to schedule_timeout().


===== drivers/serial/pmac_zilog.c 1.7 vs edited =====
--- 1.7/drivers/serial/pmac_zilog.c	Tue Mar 23 16:56:31 2004
+++ edited/drivers/serial/pmac_zilog.c	Wed Mar 24 10:01:17 2004
@@ -1627,7 +1627,7 @@
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
 	struct uart_state *state;
 	unsigned long flags;
-	int pwr_delay;
+	int pwr_delay = 0;
 
 	if (uap == NULL)
 		return 0;


