Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWISAOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWISAOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWISAOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:14:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:43701 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030323AbWISAOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:14:09 -0400
Subject: Re: [PATCH 2/4] pmc551 remove unnecessary braces
From: Josh Boyer <jdub@us.ibm.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Mark Ferrell <mferrell@mvista.com>
In-Reply-To: <91292912129122wcf1@karneval.cz>
References: <91292912129122wcf1@karneval.cz>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 19:16:19 -0500
Message-Id: <1158624979.3600.31.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 00:47 +0200, Jiri Slaby wrote:
> 
> diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
> index 6d4d5a4..0ee22ca 100644
> --- a/drivers/mtd/devices/pmc551.c
> +++ b/drivers/mtd/devices/pmc551.c
> @@ -137,11 +137,11 @@ #endif
>  
>  	pmc551_point(mtd, instr->addr, instr->len, &retlen, &ptr);
>  
> -	if (soff_hi == eoff_hi || mtd->size == priv->asize) {
> +	if (soff_hi == eoff_hi || mtd->size == priv->asize)
>  		/* The whole thing fits within one access, so just one shot
>  		   will do it. */
>  		memset(ptr, 0xff, instr->len);
> -	} else {
> +	else {
>  		/* We have to do multiple writes to get all the data
>  		   written. */
>  		while (soff_hi != eoff_hi) {

I actually find this change to make the code less readable.  Yes, the
braces aren't technically necessary, but the else requires them, and the
comment block before the memset makes this multi-line.

This whole patch is highly user preference, but I'd rather these braces
stay.


> @@ -700,9 +695,8 @@ static int __init init_pmc551(void)
>  
>  		if ((PCI_Device = pci_find_device(PCI_VENDOR_ID_V3_SEMI,
>  						  PCI_DEVICE_ID_V3_SEMI_V370PDC,
> -						  PCI_Device)) == NULL) {
> +						  PCI_Device)) == NULL)
>  			break;
> -		}

1) If you're going for coding style, the assignment within the if
condition needs to be moved outside of it.

2) If you're not going to fix 1, then leave the braces.

josh

