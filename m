Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWFUOeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWFUOeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFUOeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:34:03 -0400
Received: from mail.gmx.net ([213.165.64.21]:63466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932167AbWFUOeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:34:00 -0400
X-Authenticated: #704063
Subject: [Patch] Array overrun in drivers/net/tokenring/3c359.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mikep@linuxtr.net
Content-Type: text/plain
Date: Wed, 21 Jun 2006 16:33:58 +0200
Message-Id: <1150900438.20915.6.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity (#id 502)
the xl_laa[] array has only 6 entries, since the else
case uses i-10 as array index to dev->dev_addr[] i guess
thats what should be done here too

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/tokenring/3c359.c.orig	2006-06-21 16:31:36.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/tokenring/3c359.c	2006-06-21 16:31:41.000000000 +0200
@@ -764,7 +764,7 @@ static int xl_open_hw(struct net_device 
 	if (xl_priv->xl_laa[0]) {  /* If using a LAA address */
 		for (i=10;i<16;i++) { 
 			writel( (MEM_BYTE_WRITE | 0xD0000 | xl_priv->srb) + i, xl_mmio + MMIO_MAC_ACCESS_CMD) ; 
-			writeb(xl_priv->xl_laa[i],xl_mmio + MMIO_MACDATA) ; 
+			writeb(xl_priv->xl_laa[i-10],xl_mmio + MMIO_MACDATA) ; 
 		}
 		memcpy(dev->dev_addr,xl_priv->xl_laa,dev->addr_len) ; 
 	} else { /* Regular hardware address */ 


