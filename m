Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314597AbSEFR36>; Mon, 6 May 2002 13:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSEFR35>; Mon, 6 May 2002 13:29:57 -0400
Received: from mail.uklinux.net ([80.84.72.21]:2315 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S314597AbSEFR34>;
	Mon, 6 May 2002 13:29:56 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Mon, 6 May 2002 18:29:44 +0100 (BST)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/depca.c tidyup (fwd)
Message-ID: <Pine.LNX.4.44.0205061828560.30139-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ALIGN macro is defined centrally - remove the local version

Applies to: 2.5.13, 2.5.14

--- linux/drivers/net/depca.c.old	Sun May  5 12:43:31 2002
+++ linux/drivers/net/depca.c	Sun May  5 15:08:11 2002
@@ -339,16 +339,6 @@
 #define MAX_NUM_DEPCAS 2
 
 /*
-** Memory Alignment. Each descriptor is 4 longwords long. To force a
-** particular alignment on the TX descriptor, adjust DESC_SKIP_LEN and
-** DESC_ALIGN. ALIGN aligns the start address of the private memory area
-** and hence the RX descriptor ring's first entry. 
-*/
-#define ALIGN4      ((u_long)4 - 1)       /* 1 longword align */
-#define ALIGN8      ((u_long)8 - 1)       /* 2 longword (quadword) align */
-#define ALIGN         ALIGN8              /* Keep the LANCE happy... */
-
-/*
 ** The DEPCA Rx and Tx ring descriptors. 
 */
 struct depca_rx_desc {
@@ -641,7 +631,7 @@
 	offset += sizeof(struct depca_init);
 
 	/* Tx & Rx descriptors (aligned to a quadword boundary) */
-	offset = (offset + ALIGN) & ~ALIGN;
+	offset = ALIGN(offset, 8);
 	lp->rx_ring = (struct depca_rx_desc *)(lp->sh_mem + offset);
 	lp->rx_ring_offset = offset;
 

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please note that my address is changing from <peterd at pnd-pc dot demon.co.uk>


