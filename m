Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbWHMXuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWHMXuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWHMXuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:50:32 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:18751 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751735AbWHMXub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:50:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAIhX30SBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Florin Malita <fmalita@gmail.com>
Subject: Re: [PATCH] atkbd.c: overrun in atkbd_set_repeat_rate()
Date: Sun, 13 Aug 2006 19:50:28 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <44DF953B.6010707@gmail.com>
In-Reply-To: <44DF953B.6010707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608131950.28720.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 17:10, Florin Malita wrote:
> This was introduced in commit 3d0f0fa0cb554541e10cb8cb84104e4b10828468:
> bounds checking is performed against period[32] while indexing delay[4].
> 
> Spotted by Coverity, CID 1376.
> 

Will apply, thank you.

> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 6bfa0cf..a86afd0 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -498,7 +498,7 @@ static int atkbd_set_repeat_rate(struct 
>  		i++;
>  	dev->rep[REP_PERIOD] = period[i];
>  
> -	while (j < ARRAY_SIZE(period) - 1 && delay[j] < dev->rep[REP_DELAY])
> +	while (j < ARRAY_SIZE(delay) - 1 && delay[j] < dev->rep[REP_DELAY])
>  		j++;
>  	dev->rep[REP_DELAY] = delay[j];
>  
> 
> 

-- 
Dmitry
