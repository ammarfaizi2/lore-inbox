Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWG0NFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWG0NFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWG0NFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:05:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59609 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161030AbWG0NFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:05:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j5Y0sZ1sHdBu1nzjgchIejllU7zrcWyVwRCcjDQYvRQ4e6h+It5Yd/htytgaJ21zBmbj7i+PDNZHxqs/sxZEuGC4WO+namLHS1wqJI+kE4SVccT6MhR/wmqFvVe7lk2/tR3zQ7azVOsklXYMYn35YvRZc8/VZhbEjrxXoIGr8/4=
Message-ID: <215036450607270605t1f1ea28am44684c13eb2a724f@mail.gmail.com>
Date: Thu, 27 Jul 2006 21:05:19 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       ipw2100-admin@linux.intel.com
Subject: [PATCH]: Add check return result on call create_workqueue
Cc: linux-kernel@vger.kernel.org, "Randy Dunlap" <randy.dunlap@oracle.com>,
       wim.coekaerts@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add check return result on call create_workqueue().

Signed-off-by: Joe Jin <lkmaillist@gmail.com>
---

--- linux-2.6.17.7/drivers/net/wireless/ipw2100.c       2006-07-25
11:36:01.000000000 +0800
+++ linux.new/drivers/net/wireless/ipw2100.c    2006-07-27
20:23:03.000000000 +0800
@@ -6110,6 +6110,10 @@
        INIT_STAT(&priv->fw_pend_stat);

        priv->workqueue = create_workqueue(DRV_NAME);
+       if(NULL == priv->workqueue){
+               free_ieee80211(dev);
+               return NULL;
+       }

        INIT_WORK(&priv->reset_work,
                  (void (*)(void *))ipw2100_reset_adapter, priv);


-- 
Regards,
Joe Jin
