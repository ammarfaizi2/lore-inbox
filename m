Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWEOV1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWEOV1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbWEOV1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:27:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26061
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965256AbWEOV1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:27:00 -0400
Date: Mon, 15 May 2006 14:26:45 -0700 (PDT)
Message-Id: <20060515.142645.94689626.davem@davemloft.net>
To: ranjitm@google.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.56.0605151409110.25064@ranjit.corp.google.com>
References: <20060514031034.5d0396e7.akpm@osdl.org>
	<20060514.134231.101346572.davem@davemloft.net>
	<Pine.LNX.4.56.0605151409110.25064@ranjit.corp.google.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjit Manomohan <ranjitm@google.com>
Date: Mon, 15 May 2006 14:19:06 -0700 (PDT)

> Heres a new version which does a copy instead of the clone to avoid
> the double cloning issue.

I still very much dislike this patch because it is creating
1 more clone per packet than is actually necessary and that
is very expensive.

dev_queue_xmit_nit() is going to clone whatever SKB you send into
there, so better to just bump the reference count (with skb_get())
instead of cloning or copying.
