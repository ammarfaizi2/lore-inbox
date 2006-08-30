Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWH3GKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWH3GKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWH3GKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:10:05 -0400
Received: from main.gmane.org ([80.91.229.2]:43491 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751546AbWH3GKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:10:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: rockeychu <rockeychu@gmail.com>
Subject: =?utf-8?b?W1BBVENIXW5hbmRfYmFzZTo=?= misused =?utf-8?b?bWFmX2lk?=   ( for Linux 2.6.18-RC4 & RC5 )
Date: Wed, 30 Aug 2006 05:43:08 +0000 (UTC)
Message-ID: <loom.20060830T073313-489@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 220.114.96.50 (Opera/9.01 (Windows NT 5.1; U; zh-cn))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When finding manufacturer, changed maf_id not maf_idx, so result is not correct.


--- linux-2.6.17_org/drivers/mtd/nand/nand_base.c     2006-08-28 
12:29:32.000000000 +0800
+++ linux-2.6.17/drivers/mtd/nand/nand_base.c 2006-08-30 13:09:55.320000000 
+0800
@@ -1093,9 +1093,10 @@

        ret = nand_do_read_ops(mtd, from, &chip->ops);

+       *retlen = chip->ops.retlen;
+
        nand_release_device(mtd);

-       *retlen = chip->ops.retlen;
        return ret;
 }

@@ -1691,9 +1692,10 @@

        ret = nand_do_write_ops(mtd, to, &chip->ops);

+       *retlen = chip->ops.retlen;
+
        nand_release_device(mtd);

-       *retlen = chip->ops.retlen;
        return ret;
 }

@@ -2222,7 +2224,7 @@
        }

        /* Try to identify manufacturer */
-       for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_id++) {
+       for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_idx++) {
                if (nand_manuf_ids[maf_idx].id == *maf_id)
                        break;
        }


