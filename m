Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWDTJ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWDTJ7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDTJ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:59:42 -0400
Received: from fc-cn.com ([218.25.172.144]:36359 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750805AbWDTJ7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:59:41 -0400
Date: Thu, 20 Apr 2006 18:01:03 +0800
From: qiyong <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
       neilb@cse.unsw.edu.au
Subject: [patch] raid5_unplug_device() fix
Message-ID: <20060420100103.GA16687@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Fix raid5_unplug_device() to not disturb raid5d unnecessarily.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3184360..eff1d9c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1680,8 +1680,8 @@ static void raid5_unplug_device(request_
 	if (blk_remove_plug(q)) {
 		conf->seq_flush++;
 		raid5_activate_delayed(conf);
+		md_wakeup_thread(mddev->thread);
 	}
-	md_wakeup_thread(mddev->thread);
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 

-- 
Coywolf Qi Hunt
