Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVKTXUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVKTXUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVKTXUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:20:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39696 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932114AbVKTXUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:20:10 -0500
Date: Mon, 21 Nov 2005 00:20:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org, dan@dennedy.org
Cc: linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051120232009.GH16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The coverity checker spotted that this was a NULL pointer dereference in 
the "if (copy_from_user(...))" case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old	2005-11-20 22:08:57.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c	2005-11-20 22:09:34.000000000 +0100
@@ -2166,7 +2166,8 @@
 			}
 		}
 	}
-	kfree(cache->filled_head);
+	if(cache->filled_head)
+		kfree(cache->filled_head);
 	kfree(cache);
 
 	if (ret >= 0) {

