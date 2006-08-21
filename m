Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWHUFkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWHUFkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 01:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHUFkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 01:40:42 -0400
Received: from msr3.hinet.net ([168.95.4.103]:18648 "EHLO msr3.hinet.net")
	by vger.kernel.org with ESMTP id S932604AbWHUFkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 01:40:41 -0400
Message-ID: <008e01c6c4e4$4fd05a00$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>
References: <1155841636.4532.16.camel@localhost.localdomain> <44E5A276.3050708@pobox.com>
Subject: Re: [PATCH 4/6] IP100A Change search phy addr start form 0
Date: Mon, 21 Aug 2006 13:40:29 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:

In IP100A, phy address is 0. Because IP100A is a single chip, the in
chip phy address is 0. so, we must search phy address for 0.

Jesse
----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>
Sent: Friday, August 18, 2006 7:20 PM
Subject: Re: [PATCH 4/6] IP100A Change search phy addr start form 0


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
>  #define DRV_NAME "sundance"
> -#define DRV_VERSION "1.01+LK1.13"
> +#define DRV_VERSION "1.01+LK1.14"
>  #define DRV_RELDATE "04-Aug-2006"
>
>
> @@ -559,8 +559,9 @@ #endif
>  /*
>  * It seems some phys doesn't deal well with address 0 being accessed
>  * first, so leave address zero to the end of the loop (32 & 31).
> + * for IP100A the phy should start from 0
>  */
> - for (phy = 1; phy <= 32 && phy_idx < MII_CNT; phy++) {
> + for (phy = 0; phy <= 32 && phy_idx < MII_CNT; phy++) {
>  int phyx = phy & 0x1f;
>  int mii_status = mdio_read(dev, phyx, MII_BMSR);
>  if (mii_status != 0xffff  &&  mii_status != 0x0000) {

For IP100A, is the phy built into the chip?

For a standard DP83840[A] phy, phy #0 is a "ghost" which mirrors another
phy.  For this reason, we scan phy #0 last.

Does the above code not work?

Jeff


