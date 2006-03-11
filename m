Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWCKPKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWCKPKj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCKPKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:10:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14601 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751141AbWCKPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:10:38 -0500
Date: Sat, 11 Mar 2006 16:10:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/gameport/gameport.c: fix a memory leak
Message-ID: <20060311151037.GN21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak found by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/input/gameport/gameport.c.old	2006-03-11 14:28:35.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/input/gameport/gameport.c	2006-03-11 14:28:53.000000000 +0100
@@ -266,6 +266,7 @@ static void gameport_queue_event(void *o
 	if ((event = kmalloc(sizeof(struct gameport_event), GFP_ATOMIC))) {
 		if (!try_module_get(owner)) {
 			printk(KERN_WARNING "gameport: Can't get module reference, dropping event %d\n", event_type);
+			kfree(event);
 			goto out;
 		}
 

