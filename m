Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVIELxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVIELxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVIELxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 07:53:34 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:34693 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751113AbVIELxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 07:53:33 -0400
Message-ID: <431C31A5.3080804@gmail.com>
Date: Mon, 05 Sep 2005 13:53:09 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Panagiotis Issaris <panagiotis.issaris@gmail.com>
CC: ipw2100-admin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipw2200: Missing kmalloc check
References: <1125886450.4017.14.camel@nyx>
In-Reply-To: <1125886450.4017.14.camel@nyx>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris napsal(a):

>The ipw2200 driver code in current GIT contains a kmalloc() followed by
>a memset() without handling a possible memory allocation failure.
>
>Signed-off-by: Panagiotis Issaris <panagiotis.issaris@gmail.com>
>---
>
> drivers/net/wireless/ipw2200.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
>8e288419b49346fee512739acac446c951727d04
>diff --git a/drivers/net/wireless/ipw2200.c
>b/drivers/net/wireless/ipw2200.c
>--- a/drivers/net/wireless/ipw2200.c
>+++ b/drivers/net/wireless/ipw2200.c
>@@ -3976,6 +3976,10 @@ static struct ipw_rx_queue *ipw_rx_queue
> 	int i;
> 
> 	rxq = (struct ipw_rx_queue *)kmalloc(sizeof(*rxq), GFP_KERNEL);
>+	if (unlikely(!rxq)) {
>+		IPW_ERROR("memory allocation failed\n");
>+		return NULL;
>+	}
> 	memset(rxq, 0, sizeof(*rxq));
>  
>
and use kzalloc instead of kmalloc and memset 0?

> 	spin_lock_init(&rxq->lock);
> 	INIT_LIST_HEAD(&rxq->rx_free);
>  
>
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

