Return-Path: <linux-kernel-owner+w=401wt.eu-S1750823AbXAIDho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXAIDho (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 22:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXAIDho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 22:37:44 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:46172 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXAIDhn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 22:37:43 -0500
X-Greylist: delayed 87979 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 22:37:43 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Date: Mon, 8 Jan 2007 11:12:28 +0800
Message-ID: <989B956029373F45A0B8AF029708189006134E@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070106131832.GE19020@Ahmed>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Thread-Index: AccxlTYoDWnWmfqPRs6Bt4gQs+C71ABPIHbw
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ahmed S. Darwish [mailto:darwish.07@gmail.com]
> Sent: Saturday, January 06, 2007 9:19 PM
> To: Li Yang-r58472
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
> 
> [Please inform me if you are not the maintaner cause I'm not sure:)]
> 
> Hi,
> A kmalloc casting cleanup patch.
> 
> I wasn't able to compile the file drivers/net/ucc_geth.c cause of
> some not found headers (asm/of_platform.h, asm/qe.h, and others )

You need to use ARCH=powerpc to compile this driver.  I don't know how
you could select this driver without using powerpc arch.

> 
> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> 
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 8243150..001109e 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -2864,8 +2864,8 @@ static int ucc_geth_startup(struct
ucc_geth_private *ugeth)
>  			if (UCC_GETH_TX_BD_RING_ALIGNMENT > 4)
>  				align = UCC_GETH_TX_BD_RING_ALIGNMENT;
>  			ugeth->tx_bd_ring_offset[j] =
> -				(u32) (kmalloc((u32) (length + align),
> -				GFP_KERNEL));
> +				kmalloc((u32) (length + align),
GFP_KERNEL);
> +
>  			if (ugeth->tx_bd_ring_offset[j] != 0)
>  				ugeth->p_tx_bd_ring[j] =
>
(void*)((ugeth->tx_bd_ring_offset[j] +
> @@ -2900,7 +2900,7 @@ static int ucc_geth_startup(struct
ucc_geth_private *ugeth)
>  			if (UCC_GETH_RX_BD_RING_ALIGNMENT > 4)
>  				align = UCC_GETH_RX_BD_RING_ALIGNMENT;
>  			ugeth->rx_bd_ring_offset[j] =
> -			    (u32) (kmalloc((u32) (length + align),
GFP_KERNEL));
> +				kmalloc((u32) (length + align),
GFP_KERNEL);

NACK about the 2 clean-ups above.  Cast from pointer to integer is
required here.

>  			if (ugeth->rx_bd_ring_offset[j] != 0)
>  				ugeth->p_rx_bd_ring[j] =
>
(void*)((ugeth->rx_bd_ring_offset[j] +
> @@ -2926,10 +2926,9 @@ static int ucc_geth_startup(struct
ucc_geth_private *ugeth)
>  	/* Init Tx bds */
>  	for (j = 0; j < ug_info->numQueuesTx; j++) {
>  		/* Setup the skbuff rings */
> -		ugeth->tx_skbuff[j] =
> -		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *)
*
> -
ugeth->ug_info->bdRingLenTx[j],
> -					       GFP_KERNEL);
> +		ugeth->tx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
> +
ugeth->ug_info->bdRingLenTx[j],
> +					      GFP_KERNEL);
> 
>  		if (ugeth->tx_skbuff[j] == NULL) {
>  			ugeth_err("%s: Could not allocate tx_skbuff",
> @@ -2958,10 +2957,9 @@ static int ucc_geth_startup(struct
ucc_geth_private *ugeth)
>  	/* Init Rx bds */
>  	for (j = 0; j < ug_info->numQueuesRx; j++) {
>  		/* Setup the skbuff rings */
> -		ugeth->rx_skbuff[j] =
> -		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *)
*
> -
ugeth->ug_info->bdRingLenRx[j],
> -					       GFP_KERNEL);
> +		ugeth->rx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
> +
ugeth->ug_info->bdRingLenRx[j],
> +					      GFP_KERNEL);
> 
>  		if (ugeth->rx_skbuff[j] == NULL) {
>  			ugeth_err("%s: Could not allocate rx_skbuff",
> @@ -3452,8 +3450,7 @@ static int ucc_geth_startup(struct
ucc_geth_private *ugeth)
>  	 * allocated resources can be released when the channel is
freed.
>  	 */
>  	if (!(ugeth->p_init_enet_param_shadow =
> -	     (struct ucc_geth_init_pram *) kmalloc(sizeof(struct
> ucc_geth_init_pram),
> -					      GFP_KERNEL))) {
> +	      kmalloc(sizeof(struct ucc_geth_init_pram), GFP_KERNEL))) {
>  		ugeth_err
>  		    ("%s: Can not allocate memory for"
>  			" p_UccInitEnetParamShadows.", __FUNCTION__);
> 
> --
> Ahmed S. Darwish
> http://darwish-07.blogspot.com

- Leo
