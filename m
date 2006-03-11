Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWCKPKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWCKPKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWCKPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:10:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751088AbWCKPKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:10:33 -0500
Date: Sat, 11 Mar 2006 16:10:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/serio/serio.c: fix a memory leak
Message-ID: <20060311151032.GM21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak found by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/input/serio/serio.c.old	2006-03-11 14:29:47.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/input/serio/serio.c	2006-03-11 14:30:03.000000000 +0100
@@ -196,6 +196,7 @@ static void serio_queue_event(void *obje
 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
 		if (!try_module_get(owner)) {
 			printk(KERN_WARNING "serio: Can't get module reference, dropping event %d\n", event_type);
+			kfree(event);
 			goto out;
 		}
 

