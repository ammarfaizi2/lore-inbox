Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDDTHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDDTHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWDDTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:07:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44559 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750811AbWDDTHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:07:44 -0400
Date: Tue, 4 Apr 2006 21:07:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/core/net-sysfs.c: fix an off-by-21-or-49 error
Message-ID: <20060404190742.GA6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an off-by-21-or-49 error ;-) spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/net/core/net-sysfs.c.old	2006-04-04 20:36:32.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/net/core/net-sysfs.c	2006-04-04 20:36:49.000000000 +0200
@@ -165,7 +165,7 @@ static ssize_t show_operstate(struct cla
 		operstate = IF_OPER_DOWN;
 	read_unlock(&dev_base_lock);
 
-	if (operstate >= sizeof(operstates))
+	if (operstate >= ARRAY_SIZE(operstates))
 		return -EINVAL; /* should not happen */
 
 	return sprintf(buf, "%s\n", operstates[operstate]);

