Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266653AbRGOQDh>; Sun, 15 Jul 2001 12:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266669AbRGOQD1>; Sun, 15 Jul 2001 12:03:27 -0400
Received: from [195.211.46.202] ([195.211.46.202]:30024 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S266653AbRGOQDU>;
	Sun, 15 Jul 2001 12:03:20 -0400
Date: Sun, 15 Jul 2001 17:39:16 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: <linux-irda@pasta.cs.UiT.No>
Subject: [PATCH] Re: [CHECKER] free errors for 2.4.6 and 2.4.6ac2
In-Reply-To: <Pine.GSO.4.31.0107131551270.15960-100000@myth2.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0107141202250.6232-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dag, Jean, LKML!

On Fri, 13 Jul 2001, Evan Parker wrote:

> Enclosed are 10 bugs where code uses memory that has already been
> freed.
...
> 1	|	/home/eparker/tmp/linux/2.4.6-ac2/drivers/net/irda/ali-ircc.c/

Here's the patch for review:

--- linux-2.4.7/drivers/net/irda/ali-ircc.c~	Thu Jul 12 14:20:56 2001
+++ linux-2.4.7/drivers/net/irda/ali-ircc.c	Sat Jul 14 12:01:07 2001
@@ -331,8 +331,8 @@
 	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize,
 					      GFP_KERNEL|GFP_DMA);
 	if (self->tx_buff.head == NULL) {
-		kfree(self);
 		kfree(self->rx_buff.head);
+		kfree(self);
 		return -ENOMEM;
 	}
 	memset(self->tx_buff.head, 0, self->tx_buff.truesize);

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


