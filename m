Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVCVWAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVCVWAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVCVV7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:59:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56332 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262072AbVCVV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:57:21 -0500
Date: Tue, 22 Mar 2005 22:57:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-ns83820@kvack.org
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/net/ns83820.c: remove unused code
Message-ID: <20050322215717.GO1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coveity checker found that residue is always 0.

Is this patch correct or should residue have been used?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/net/ns83820.c.old	2005-03-22 21:32:15.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/ns83820.c	2005-03-22 21:33:16.000000000 +0100
@@ -1189,7 +1189,6 @@
 
 	for (;;) {
 		volatile u32 *desc = dev->tx_descs + (free_idx * DESC_SIZE);
-		u32 residue = 0;
 
 		dprintk("frag[%3u]: %4u @ 0x%08Lx\n", free_idx, len,
 			(unsigned long long)buf);
@@ -1199,17 +1198,11 @@
 		desc_addr_set(desc + DESC_BUFPTR, buf);
 		desc[DESC_EXTSTS] = cpu_to_le32(extsts);
 
-		cmdsts = ((nr_frags|residue) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
+		cmdsts = ((nr_frags) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
 		cmdsts |= (desc == first_desc) ? 0 : CMDSTS_OWN;
 		cmdsts |= len;
 		desc[DESC_CMDSTS] = cpu_to_le32(cmdsts);
 
-		if (residue) {
-			buf += len;
-			len = residue;
-			continue;
-		}
-
 		if (!nr_frags)
 			break;
 

