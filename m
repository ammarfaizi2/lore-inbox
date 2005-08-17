Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVHQSeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVHQSeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVHQSeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:34:36 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:5593
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1751160AbVHQSeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:34:36 -0400
Date: Wed, 17 Aug 2005 11:34:32 -0700 (PDT)
Message-Id: <20050817.113432.107383006.davem@davemloft.net>
To: Joshua.Wise@sicortex.com
Cc: linux-kernel@vger.kernel.org, aaron.brooks@sicortex.com
Subject: Re: NAPI poll routine happens in interrupt context?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508170932.10441.Joshua.Wise@sicortex.com>
References: <200508170932.10441.Joshua.Wise@sicortex.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Wise <Joshua.Wise@sicortex.com>
Date: Wed, 17 Aug 2005 09:32:10 -0400

> I have recently been working on a network driver for an emulated ultra-simple 
> network card, and I've run into a few snags with the NAPI. My current issue 
> is that it seems to me that my poll routine is being called from an atomic 
> context, so when poll calls rx, and rx calls netif_receive_skb, I end up with 
> lots of __might_sleep warnings in the various network layers.

NAPI's ->poll method is invoked from software IRQ context.
