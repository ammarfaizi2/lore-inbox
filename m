Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316843AbSE1Qez>; Tue, 28 May 2002 12:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316844AbSE1Qey>; Tue, 28 May 2002 12:34:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:41220 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316843AbSE1Qex>; Tue, 28 May 2002 12:34:53 -0400
Message-ID: <3CF3A2C3.7060706@evision-ventures.com>
Date: Tue, 28 May 2002 17:31:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        breed@users.sourceforge.net
Subject: [PATCH] airo
In-Reply-To: <Pine.LNX.4.33.0205241902001.1537-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000309050805040704090401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309050805040704090401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Since apparently no body else did care thus far, and
since I'm using this driver, well here it comes:

- Adjust the airo wireless LAN card driver for the fact that modules
   don't export symbols by default any longer.

- Make some stuff which obivously should be static there static as well.
   (Plenty of code in Linux actually deserves a review for this
    far too common bug...)

--------------000309050805040704090401
Content-Type: text/plain;
 name="airo-2.5.18.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="airo-2.5.18.diff"

diff -ur linux-2.5.18/drivers/net/wireless/airo.c linux/drivers/net/wireless/airo.c
--- linux-2.5.18/drivers/net/wireless/airo.c	2002-05-25 03:55:19.000000000 +0200
+++ linux/drivers/net/wireless/airo.c	2002-05-28 18:20:41.000000000 +0200
@@ -1146,6 +1146,8 @@
 	kfree( dev );
 }
 
+EXPORT_SYMBOL(stop_airo_card);
+
 static int add_airo_dev( struct net_device *dev );
 
 struct net_device *init_airo_card( unsigned short irq, int port, int is_pcmcia )
@@ -1239,7 +1241,9 @@
 	return NULL;
 }
 
-int waitbusy (struct airo_info *ai) {
+EXPORT_SYMBOL(init_airo_card);
+
+static int waitbusy (struct airo_info *ai) {
 	int delay = 0;
 	while ((IN4500 (ai, COMMAND) & COMMAND_BUSY) & (delay < 10000)) {
 		udelay (10);
@@ -1283,7 +1287,9 @@
 	return 0;
 }
 
-int wll_header_parse(struct sk_buff *skb, unsigned char *haddr)
+EXPORT_SYMBOL(reset_airo_card);
+
+static int wll_header_parse(struct sk_buff *skb, unsigned char *haddr)
 {
 	memcpy(haddr, skb->mac.raw + 10, ETH_ALEN);
 	return ETH_ALEN;

--------------000309050805040704090401--

