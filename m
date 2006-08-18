Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWHRLU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWHRLU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWHRLU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:20:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8152 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932405AbWHRLUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:20:25 -0400
Message-ID: <44E5A276.3050708@pobox.com>
Date: Fri, 18 Aug 2006 07:20:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 4/6] IP100A Change search phy addr start form 0
References: <1155841636.4532.16.camel@localhost.localdomain>
In-Reply-To: <1155841636.4532.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Change search phy addr start form 0
> 
> Change Logs:
>     Change search phy addr start form 0
> 
> ---
> 
>  drivers/net/sundance.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> 212cd4ffa21a57300eae4254bf02e5b33b96f544
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> index 2bde1b3..f63871a 100755
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -21,7 +21,7 @@
>  */
>  
>  #define DRV_NAME	"sundance"
> -#define DRV_VERSION	"1.01+LK1.13"
> +#define DRV_VERSION	"1.01+LK1.14"
>  #define DRV_RELDATE	"04-Aug-2006"
>  
>  
> @@ -559,8 +559,9 @@ #endif
>  	/*
>  	 * It seems some phys doesn't deal well with address 0 being accessed
>  	 * first, so leave address zero to the end of the loop (32 & 31).
> +	 * for IP100A the phy should start from 0
>  	 */
> -	for (phy = 1; phy <= 32 && phy_idx < MII_CNT; phy++) {
> +	for (phy = 0; phy <= 32 && phy_idx < MII_CNT; phy++) {
>  		int phyx = phy & 0x1f;
>  		int mii_status = mdio_read(dev, phyx, MII_BMSR);
>  		if (mii_status != 0xffff  &&  mii_status != 0x0000) {

For IP100A, is the phy built into the chip?

For a standard DP83840[A] phy, phy #0 is a "ghost" which mirrors another 
phy.  For this reason, we scan phy #0 last.

Does the above code not work?

	Jeff


