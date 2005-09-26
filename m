Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbVIZRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbVIZRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbVIZRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:01:09 -0400
Received: from ns1.coraid.com ([65.14.39.133]:27556 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751683AbVIZRBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:01:08 -0400
To: linux-kernel@vger.kernel.org
Cc: Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
 length to ETH_ZLEN
References: <87oe6fhj8y.fsf@coraid.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 26 Sep 2005 12:50:28 -0400
In-Reply-To: <87oe6fhj8y.fsf@coraid.com> (Ed L. Cashin's message of "Mon, 26
 Sep 2005 12:43:57 -0400")
Message-ID: <87hdc7ept7.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ed L. Cashin" <ecashin@coraid.com> writes:

...
> Explicitly set the minimum packet length to ETH_ZLEN.
>
> Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
> ===================================================================
> --- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-26 12:20:34.000000000 -0400
> +++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
> @@ -20,6 +20,9 @@
>  {
>  	struct sk_buff *skb;
>  
> +	if (len < ETH_ZLEN)
> +		len = ETH_ZLEN;
> +
>  	skb = alloc_skb(len, GFP_ATOMIC);

This change fixes some strange problems observed on a system that was
using the e1000 network driver.  Is the network driver supposed to
ensure that ethernet packets are up to spec, at least 60 bytes long?

-- 
  Ed L Cashin <ecashin@coraid.com>

