Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWEOVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWEOVlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWEOVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:41:55 -0400
Received: from stinky.trash.net ([213.144.137.162]:29655 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964920AbWEOVlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:41:53 -0400
Message-ID: <4468F5A0.3040404@trash.net>
Date: Mon, 15 May 2006 23:41:52 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: ranjitm@google.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
References: <20060514031034.5d0396e7.akpm@osdl.org>	<20060514.134231.101346572.davem@davemloft.net>	<Pine.LNX.4.56.0605151409110.25064@ranjit.corp.google.com> <20060515.142645.94689626.davem@davemloft.net>
In-Reply-To: <20060515.142645.94689626.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Ranjit Manomohan <ranjitm@google.com>
> Date: Mon, 15 May 2006 14:19:06 -0700 (PDT)
> 
> 
>>Heres a new version which does a copy instead of the clone to avoid
>>the double cloning issue.
> 
> 
> I still very much dislike this patch because it is creating
> 1 more clone per packet than is actually necessary and that
> is very expensive.
> 
> dev_queue_xmit_nit() is going to clone whatever SKB you send into
> there, so better to just bump the reference count (with skb_get())
> instead of cloning or copying.


I think this would break the tc actions. Some actions call
pskb_expand_head() on input, which BUGs on skb_shared(skb).
They can't clone the skb instead because the functions
doing that don't own it, the caller would continue with the
old skb.
