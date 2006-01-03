Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWACVaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWACVaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWACVaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:30:11 -0500
Received: from ns1.coraid.com ([65.14.39.133]:60617 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751485AbWACV3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:29:46 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [6/7]: update device information on last
 close
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87hd8l2fb4.fsf@coraid.com>
Date: Tue, 03 Jan 2006 16:08:25 -0500
Message-ID: <87k6dhyq7q.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Instead of making the user wait or do it manually, refresh
device information on its last close by issuing a config
query to the device.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoeblk.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoeblk.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoeblk.c	2006-01-02 13:35:15.000000000 -0500
@@ -109,7 +109,7 @@
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (--d->nopen == 0 && !(d->flags & DEVFL_UP)) {
+	if (--d->nopen == 0) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
 		return 0;


-- 
  Ed L. Cashin <ecashin@coraid.com>

