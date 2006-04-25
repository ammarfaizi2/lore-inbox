Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWDYDeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWDYDeM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWDYDeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:34:11 -0400
Received: from fc-cn.com ([218.25.172.144]:20493 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751127AbWDYDeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:34:10 -0400
Date: Tue, 25 Apr 2006 11:36:16 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: neilb@suse.de, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [patch 2/2] raid6_unplug_device() fix
Message-ID: <20060425033616.GA27664@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Fix raid6_unplug_device() to not disturb raid6d unnecessarily.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
index 820536e..d3deedb 100644
--- a/drivers/md/raid6main.c
+++ b/drivers/md/raid6main.c
@@ -1644,8 +1644,8 @@ static void raid6_unplug_device(request_
 	if (blk_remove_plug(q)) {
 		conf->seq_flush++;
 		raid6_activate_delayed(conf);
+		md_wakeup_thread(mddev->thread);
 	}
-	md_wakeup_thread(mddev->thread);
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 

-- 
Coywolf Qi Hunt
