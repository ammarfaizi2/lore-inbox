Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSJYWoo>; Fri, 25 Oct 2002 18:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJYWoo>; Fri, 25 Oct 2002 18:44:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59664 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261646AbSJYWol>;
	Fri, 25 Oct 2002 18:44:41 -0400
Message-ID: <3DB9CAC1.2010000@pobox.com>
Date: Fri, 25 Oct 2002 18:50:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: [BK/GNU] net driver series 12
Content-Type: multipart/mixed;
 boundary="------------050902010002000309090606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902010002000309090606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

I have pushed a tulip bug fix out to gkernel.  Please do a

        bk pull http://gkernel.bkbits.net/net-drivers-2.4

to retrieve the simple tulip patch, which is attached to this email for 
your review.  The BK repository also contains the previous 34 patches I 
sent to you yesterday, or the day before...


--------------050902010002000309090606
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.759   -> 1.760  
#	drivers/net/tulip/tulip_core.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/25	jgarzik@redhat.com	1.760
# Fix tulip net driver multi-port board irq assignment
# --------------------------------------------
#
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	Fri Oct 25 18:22:30 2002
+++ b/drivers/net/tulip/tulip_core.c	Fri Oct 25 18:22:30 2002
@@ -1482,7 +1482,6 @@
 	tp->timer.function = tulip_tbl[tp->chip_id].media_timer;
 
 	dev->base_addr = ioaddr;
-	dev->irq = irq;
 
 #ifdef CONFIG_TULIP_MWI
 	if (!force_csr0 && (tp->flags & HAS_PCI_MWI))
@@ -1655,6 +1654,7 @@
 	for (i = 0; i < 6; i++)
 		last_phys_addr[i] = dev->dev_addr[i];
 	last_irq = irq;
+	dev->irq = irq;
 
 	/* The lower four bits are the media type. */
 	if (board_idx >= 0  &&  board_idx < MAX_UNITS) {

--------------050902010002000309090606--

