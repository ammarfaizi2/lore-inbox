Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWEYXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWEYXWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWEYXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:22:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21393
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S965187AbWEYXWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:22:17 -0400
Date: Thu, 25 May 2006 16:22:22 -0700 (PDT)
Message-Id: <20060525.162222.107938414.davem@davemloft.net>
To: fmalita@gmail.com
Cc: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irda: missing allocation result check in
 irlap_change_speed()
From: David Miller <davem@davemloft.net>
In-Reply-To: <4474F6A6.1000006@gmail.com>
References: <4474F6A6.1000006@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florin Malita <fmalita@gmail.com>
Date: Wed, 24 May 2006 20:13:26 -0400

> The skb allocation may fail, which can result in a NULL pointer
> dereference in irlap_queue_xmit().
> 
> Coverity CID: 434.
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>

If the allocation fails we should probably do something
more interesting here, such as schedule a timer to try
again later.  Otherwise the speed change will silently
never occur.
