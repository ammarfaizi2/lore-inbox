Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422682AbWGJTvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWGJTvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWGJTvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:51:19 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:49285 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S1422682AbWGJTvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:51:18 -0400
Message-ID: <44B2AFFB.2070507@walsh.ws>
Date: Mon, 10 Jul 2006 15:52:27 -0400
From: Brian Walsh <brian@walsh.ws>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Deepak Sanexa <dsanexa@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc1 1/1] mtd/maps: ixp4xx partition parsing
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the amount of flash is not divisible by 2 then the mask in
parse_mtd_partitions would fail to work as designed.  Passing in the
base address corrects this problem.

Signed-off-by: Brian Walsh <brian@walsh.ws>
---

diff -ur a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
--- a/drivers/mtd/maps/ixp4xx.c 2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/mtd/maps/ixp4xx.c 2006-07-10 13:34:09.000000000 -0400
@@ -253,7 +253,7 @@
        /* Use the fast version */
        info->map.write = ixp4xx_write16,

-       err = parse_mtd_partitions(info->mtd, probes, &info->partitions, 0);
+       err = parse_mtd_partitions(info->mtd, probes, &info->partitions,
dev->resouce->start);
        if (err > 0) {
                err = add_mtd_partitions(info->mtd, info->partitions, err);
                if(err)

