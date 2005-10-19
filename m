Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVJSCb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVJSCb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 22:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVJSCb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 22:31:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32413 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932154AbVJSCb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 22:31:58 -0400
Message-ID: <4355B017.4040509@pobox.com>
Date: Tue, 18 Oct 2005 22:31:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 2.6.14-rc3 2/3] sundance: probe PHYs from MII address
 0
References: <10182005213101.12810@bilbo.tuxdriver.com>
In-Reply-To: <10182005213101.12810@bilbo.tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Probe for PHYs starting at MII address 0 instead of MII address 1.
> This covers the entire range of MII addresses.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> 
>  drivers/net/sundance.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -608,7 +608,7 @@ static int __devinit sundance_probe1 (st
>  
>  	np->phys[0] = 1;		/* Default setting */
>  	np->mii_preamble_required++;
> -	for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
> +	for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {

NAK.  MII address 0 should be scanned _last_, after all other addresses. 
  In some phys, it is a ghost, mirroring another address.

Take a look at some of the original Becker MII scan code from
ftp://ftp.scyld.com/pub/network/ to see an elegant method for this.

Becker's scan code would utilize a mask to keep the loop nice and 
elegant, eliminating an "if (phy == 32) phy = 0;" test.

	Jeff


