Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUBBUGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbUBBUEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:04:37 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:12696 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S266037AbUBBUDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:03:31 -0500
Date: Mon, 2 Feb 2004 21:03:30 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 36/42]
Message-ID: <20040202200330.GJ6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


scsi_merge.c:104: warning: long unsigned int format, different type arg (arg 4)

page_to_phys returns a u64 if CONFIG_HIGHMEM64G is defined.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/scsi_merge.c linux-2.4/drivers/scsi/scsi_merge.c
--- linux-2.4-vanilla/drivers/scsi/scsi_merge.c	Fri Nov 29 00:53:14 2002
+++ linux-2.4/drivers/scsi/scsi_merge.c	Sat Jan 31 19:03:49 2004
@@ -98,10 +98,10 @@
 	printk("Flags %d %d\n", use_clustering, dma_host);
 	for (bh = req->bh; bh->b_reqnext != NULL; bh = bh->b_reqnext) 
 	{
-		printk("Segment 0x%p, blocks %d, addr 0x%lx\n",
+		printk("Segment 0x%p, blocks %d, addr 0x%Lx\n",
 		       bh,
 		       bh->b_size >> 9,
-		       bh_phys(bh) - 1);
+		       (u64)bh_phys(bh) - 1);
 	}
 	panic("Ththththaats all folks.  Too dangerous to continue.\n");
 }

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
No matter what you choose, you're still a luser.
