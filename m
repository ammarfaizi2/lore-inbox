Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVLYU5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVLYU5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVLYU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:57:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42381
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750918AbVLYU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:57:53 -0500
Date: Sun, 25 Dec 2005 12:57:42 -0800 (PST)
Message-Id: <20051225.125742.65007619.davem@davemloft.net>
To: manfred@dbl.q-ag.de
Cc: jgarzik@pobox.com, aabdulla@nvidia.com, afu@fugmann.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] forcedeth: TSO fix for large buffers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200512251451.jBPEpgNe018712@dbl.q-ag.de>
References: <200512251451.jBPEpgNe018712@dbl.q-ag.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Spraul <manfred@dbl.q-ag.de>
Date: Sun, 25 Dec 2005 15:51:42 +0100

> This patch contains a bug fix for large buffers. Originally, if a tx 
> buffer to be sent was larger then the maximum size of the tx descriptor,
> 
> it would overwrite other control bits. In this patch, the buffer is 
> split over multiple descriptors. Also, the fragments are now setup in 
> forward order.
> 
> Signed-off-by: Ayaz Abdulla <aabdulla@nvidia.com>
> 
> Rediffed against forcedeth 0.48
> Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

Are you sure it's ok to setup the tx descriptors in that order?

Usually, you need to set them up last to first so that the chip
doesn't see a half-filled-in set of TX descriptors.  Ie. the
core question is if the chip can scan the TX descriptors looking
for valid ones all on it's own after processing existing TX
descriptors, or do you have to explicitly allow the chip look
at the newly added TX descriptor with a register write or similar?
