Return-Path: <linux-kernel-owner+w=401wt.eu-S1751387AbXAFNSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXAFNSu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbXAFNSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:18:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:21582 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXAFNSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:18:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=colU8S8kzWczXuIQnkd6MxMFnCQXMcni+riR4EQMmi73pUuU6GoEOPnSbjUO/iBVqxfHzvX2/a8V4n6yKEWIAsHz5HcY9xFrmQpFGGdYkEBj3gx6XgGL/rVfT0gAvOcvoJmehP8nXlpUhTdGR9bZOhJtVo/b6vJhO1K6PtxetfY=
Date: Sat, 6 Jan 2007 15:18:32 +0200
To: leoli@freescale.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Message-ID: <20070106131832.GE19020@Ahmed>
Mail-Followup-To: leoli@freescale.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please inform me if you are not the maintaner cause I'm not sure:)]

Hi,
A kmalloc casting cleanup patch.

I wasn't able to compile the file drivers/net/ucc_geth.c cause of
some not found headers (asm/of_platform.h, asm/qe.h, and others )

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 8243150..001109e 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2864,8 +2864,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			if (UCC_GETH_TX_BD_RING_ALIGNMENT > 4)
 				align = UCC_GETH_TX_BD_RING_ALIGNMENT;
 			ugeth->tx_bd_ring_offset[j] =
-				(u32) (kmalloc((u32) (length + align),
-				GFP_KERNEL));
+				kmalloc((u32) (length + align), GFP_KERNEL);
+					 
 			if (ugeth->tx_bd_ring_offset[j] != 0)
 				ugeth->p_tx_bd_ring[j] =
 					(void*)((ugeth->tx_bd_ring_offset[j] +
@@ -2900,7 +2900,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			if (UCC_GETH_RX_BD_RING_ALIGNMENT > 4)
 				align = UCC_GETH_RX_BD_RING_ALIGNMENT;
 			ugeth->rx_bd_ring_offset[j] =
-			    (u32) (kmalloc((u32) (length + align), GFP_KERNEL));
+				kmalloc((u32) (length + align), GFP_KERNEL);
 			if (ugeth->rx_bd_ring_offset[j] != 0)
 				ugeth->p_rx_bd_ring[j] =
 					(void*)((ugeth->rx_bd_ring_offset[j] +
@@ -2926,10 +2926,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Tx bds */
 	for (j = 0; j < ug_info->numQueuesTx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->tx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenTx[j],
-					       GFP_KERNEL);
+		ugeth->tx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+					      ugeth->ug_info->bdRingLenTx[j],
+					      GFP_KERNEL);
 
 		if (ugeth->tx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate tx_skbuff",
@@ -2958,10 +2957,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Rx bds */
 	for (j = 0; j < ug_info->numQueuesRx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->rx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenRx[j],
-					       GFP_KERNEL);
+		ugeth->rx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+					      ugeth->ug_info->bdRingLenRx[j],
+					      GFP_KERNEL);
 
 		if (ugeth->rx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate rx_skbuff",
@@ -3452,8 +3450,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	 * allocated resources can be released when the channel is freed.
 	 */
 	if (!(ugeth->p_init_enet_param_shadow =
-	     (struct ucc_geth_init_pram *) kmalloc(sizeof(struct ucc_geth_init_pram),
-					      GFP_KERNEL))) {
+	      kmalloc(sizeof(struct ucc_geth_init_pram), GFP_KERNEL))) {
 		ugeth_err
 		    ("%s: Can not allocate memory for"
 			" p_UccInitEnetParamShadows.", __FUNCTION__);

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
