Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVCVWYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVCVWYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVCVWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:20:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25303 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262102AbVCVWRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:17:38 -0500
Message-ID: <42409971.5010704@pobox.com>
Date: Tue, 22 Mar 2005 17:17:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/net/wireless/airo.c: correct a wrong
References: <20050322220540.GS1948@stusta.de>
In-Reply-To: <20050322220540.GS1948@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> if
> Reply-To: 
> 
> The Coverity checker correctly noted that this condition can't ever be 
> fulfilled.
> 
> Can someone understanding this code check whether my guess what this 
> should have been was right?
> 
> Or should the if get completely dropped?
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c.old	2005-03-22 21:41:37.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/net/wireless/airo.c	2005-03-22 21:42:01.000000000 +0100
> @@ -3440,9 +3440,6 @@
>  	/* Make sure we got something */
>  	if (rxd.rdy && rxd.valid == 0) {
>  		len = rxd.len + 12;
> -		if (len < 12 && len > 2048)
> -			goto badrx;

Coverity is silly.

len is signed, and so can obviously be less than zero in edge cases.  I 
don't see where the "> 2048" test is invalid, either.

	Jeff



