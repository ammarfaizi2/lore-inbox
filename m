Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUDLOUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDLOUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:20:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29134 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262915AbUDLOSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:18:53 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 4/9
Date: Mon, 12 Apr 2004 09:18:42 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120918.42743.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm.c: Use wake_up() rather than wake_up_interruptible() with the
eventq.

--- diff/drivers/md/dm.c	2004-04-09 09:42:02.000000000 -0500
+++ source/drivers/md/dm.c	2004-04-09 09:42:12.000000000 -0500
@@ -748,7 +748,7 @@
 
 	down_write(&md->lock);
 	md->event_nr++;
-	wake_up_interruptible(&md->eventq);
+	wake_up(&md->eventq);
 	up_write(&md->lock);
 }
 
