Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTFTAGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFTAG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:06:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54742 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262063AbTFTAGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:06:21 -0400
Date: Fri, 20 Jun 2003 02:20:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mike Phillips <mikep@linuxtr.net>
Cc: linux-kernel@vger.kernel.org, linux-tr@linuxtr.net,
       linux-net@vger.kernel.org
Subject: [2.5 patch] 3c359.c: remove comparison that is always true
Message-ID: <20030620002019.GJ29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a comparison that is always true.

i is defined as u16, IOW it obviously can't be > 0xffff.

I don't know whether this patch is correct. The correct fix might be 
different but the current code is definitely broken.

cu
Adrian


--- linux-2.5.72-mm2/drivers/net/tokenring/3c359.c.old	2003-06-20 02:12:45.000000000 +0200
+++ linux-2.5.72-mm2/drivers/net/tokenring/3c359.c	2003-06-20 02:15:36.000000000 +0200
@@ -464,7 +464,7 @@
 		
 		printk(KERN_INFO "3C359: Uploading Microcode: "); 
 		
-		for (i = start,j=0; (j < mc_size && i <= 0xffff) ; i++,j++) { 
+		for (i = start,j=0; j < mc_size; i++,j++) { 
 			writel(MEM_BYTE_WRITE | 0XD0000 | i, xl_mmio + MMIO_MAC_ACCESS_CMD) ; 
 			writeb(microcode[j],xl_mmio + MMIO_MACDATA) ; 
 			if (j % 1024 == 0)
