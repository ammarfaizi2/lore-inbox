Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312465AbSDXSBg>; Wed, 24 Apr 2002 14:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312466AbSDXSBf>; Wed, 24 Apr 2002 14:01:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32389 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312465AbSDXSBf>;
	Wed, 24 Apr 2002 14:01:35 -0400
Date: Wed, 24 Apr 2002 10:51:28 -0700 (PDT)
Message-Id: <20020424.105128.122083622.davem@redhat.com>
To: kaber@trash.net
Cc: kuznet2@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: bug in sch_generic.c:pfifo_fast_enqueue
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CB59613.FA9D8F7D@trash.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick McHardy <kaber@trash.net>
   Date: Thu, 11 Apr 2002 15:56:35 +0200

   "David S. Miller" schrieb:
   >    From: Patrick McHardy <kaber@trash.net>
   >    Date: Mon, 1 Apr 2002 21:43:03 +0200 (CEST)
   > 
   >    I found a small bug in pfifo_fast_enqueue, instead of
   > 
   >    if (list->qlen <= skb->dev->tx_queue_len)
   >    it should be
   >    if (list->qlen <= qdisc->dev->tx_queue_len)
   > 
   > skb->dev == qdisc->dev should be invariant when this
   > code runs.  So the code is correct, albeit possibly
   > confusing.

   Although in normal circumstances the assumption may be right
   it fails in this case. It would be nice if you apply my patch
   as it doesn't changes anything and enforces correct behaviour
   in cases like mine.

Ok, for the sake of consistency, I've made the change.
