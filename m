Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWF0WlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWF0WlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWF0WlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:41:24 -0400
Received: from mail.gmx.net ([213.165.64.21]:49327 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422695AbWF0WlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:41:23 -0400
X-Authenticated: #704063
Subject: [Patch] Off by one in drivers/usb/input/yealink.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Henk.Vergonet@gmail.com
Content-Type: text/plain
Date: Wed, 28 Jun 2006 00:41:19 +0200
Message-Id: <1151448080.16217.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another off by one spotted by coverity (id #485),
we loop exactly one time too often

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/usb/input/yealink.c.orig	2006-06-28 00:29:46.000000000 +0200
+++ linux-2.6.17-git11/drivers/usb/input/yealink.c	2006-06-28 00:30:04.000000000 +0200
@@ -350,7 +350,7 @@ static int yealink_do_idle_tasks(struct 
 		val = yld->master.b[ix];
 		if (val != yld->copy.b[ix])
 			goto send_update;
-	} while (++ix < sizeof(yld->master));
+	} while (++ix < sizeof(yld->master)-1);
 
 	/* nothing todo, wait a bit and poll for a KEYPRESS */
 	yld->stat_ix = 0;


