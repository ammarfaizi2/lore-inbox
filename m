Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTFDT2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTFDT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:28:44 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:65038 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263898AbTFDT2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:28:40 -0400
Date: Wed, 4 Jun 2003 21:41:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: torvalds@transmeta.com
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.70 - double iounmap in octagon 5066 mtd driver
Message-ID: <20030604214125.A25880@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iounmap() is done after label out_unmap anyway.


 drivers/mtd/maps/octagon-5066.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/mtd/maps/octagon-5066.c~trivial-double-iounmap-octagon-5066 drivers/mtd/maps/octagon-5066.c
--- linux-2.5.70-1.1229.7.33-to-1.1330/drivers/mtd/maps/octagon-5066.c~trivial-double-iounmap-octagon-5066	Wed Jun  4 21:29:16 2003
+++ linux-2.5.70-1.1229.7.33-to-1.1330-fr/drivers/mtd/maps/octagon-5066.c	Wed Jun  4 21:30:28 2003
@@ -247,7 +247,6 @@ int __init init_oct5066(void)
 	}
 	if (OctProbe() != 0) {
 		printk(KERN_NOTICE "5066: Octagon Probe Failed, is this an Octagon 5066 SBC?\n");
-		iounmap((void *)iomapadr);
 		ret = -EAGAIN;
 		goto out_unmap;
 	}

_
