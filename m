Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752603AbWKBA1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbWKBA1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbWKBA1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:27:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48806
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752603AbWKBA1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:27:53 -0500
Date: Wed, 01 Nov 2006 16:27:58 -0800 (PST)
Message-Id: <20061101.162758.10298784.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org, jschlst@samba.org, acme@conectiva.com.br
Subject: Re: [PATCH] LLC: Avoid potential NULL dereference in
 net/llc/af_llc.c::llc_ui_accept() .
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611020121.53368.jesper.juhl@gmail.com>
References: <200611020121.53368.jesper.juhl@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Thu, 2 Nov 2006 01:21:53 +0100

> Since skb_dequeue() may return NULL we risk dereferencing a NULL pointer at
>   if (!skb->sk)
> This patch avoids that by also testing for a NULL skb.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

It can't return NULL in this context because we just checked
skb_queue_empty() with the socket lock held and llc_wait_data()
will return zero only if skb_queue_empty() is false.

I know it's hard for automated tools to see this, but it's not
reasonable to put this extra check in there since it is
superfluous due to the above mentioned invariants.
