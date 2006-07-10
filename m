Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWGJUpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWGJUpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWGJUpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:45:21 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:60805 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S964795AbWGJUpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:45:20 -0400
Message-ID: <44B2BCAA.5000007@walsh.ws>
Date: Mon, 10 Jul 2006 16:46:34 -0400
From: Brian Walsh <brian@walsh.ws>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Deepak Sanexa <dsanexa@mvista.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc1 1/1] [RESUBMIT] mtd/maps: ixp4xx partition parsing
References: <44B2AFFB.2070507@walsh.ws> <20060710200212.GA31761@flint.arm.linux.org.uk>
In-Reply-To: <20060710200212.GA31761@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the amount of flash is not divisible by 2 then the mask in parse_mtd_partitions would fail to work as designed.  Passing in the base address corrects this problem.

Signed-off-by: Brian Walsh <brian@walsh.ws>
---

diff -ur a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
--- a/drivers/mtd/maps/ixp4xx.c 2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/mtd/maps/ixp4xx.c 2006-07-10 16:29:47.000000000 -0400
@@ -253,7 +253,7 @@
        /* Use the fast version */
        info->map.write = ixp4xx_write16,

-       err = parse_mtd_partitions(info->mtd, probes, &info->partitions, 0);
+       err = parse_mtd_partitions(info->mtd, probes, &info->partitions, dev->resource->start);
        if (err > 0) {
                err = add_mtd_partitions(info->mtd, info->partitions, err);
                if(err)


