Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUBBSUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUBBSUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:20:43 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:59200 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265755AbUBBSUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:20:39 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 19:20:39 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 2/42]
Message-ID: <20040202182039.GB6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ad1889.c:361: warning: unsigned int format, different type arg (arg 4)

It happens only with CONFIG_HIGHMEM64G=y as dma_addr_t becomes u64.
Fixed by casting dma_addr_t to dma64_addr_t in the printk.


diff -Nru -X dontdiff linux-2.4-vanilla/drivers/sound/ad1889.c linux-2.4/drivers/sound/ad1889.c
--- linux-2.4-vanilla/drivers/sound/ad1889.c	Tue Nov 11 17:51:39 2003
+++ linux-2.4/drivers/sound/ad1889.c	Sat Jan 31 16:12:10 2004
@@ -356,9 +356,9 @@
 	for (i = 0; i < AD_MAX_STATES; i++) {
 		out += sprintf(out, "DMA status for %s:\n", 
 			(i == AD_WAV_STATE ? "WAV" : "ADC")); 
-		out += sprintf(out, "\t\t0x%p (IOVA: 0x%u)\n", 
+		out += sprintf(out, "\t\t0x%p (IOVA: 0x%Lu)\n", 
 			dev->state[i].dmabuf.rawbuf,
-			dev->state[i].dmabuf.dma_handle);
+			(dma64_addr_t)dev->state[i].dmabuf.dma_handle);
 
 		out += sprintf(out, "\tread ptr: offset %u\n", 
 			(unsigned int)dev->state[i].dmabuf.rd_ptr);

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
No matter what you choose, you're still a luser.
