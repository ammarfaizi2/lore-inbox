Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313987AbSDKEs7>; Thu, 11 Apr 2002 00:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313988AbSDKEs6>; Thu, 11 Apr 2002 00:48:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14033 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313987AbSDKEs6>;
	Thu, 11 Apr 2002 00:48:58 -0400
Date: Wed, 10 Apr 2002 21:41:12 -0700 (PDT)
Message-Id: <20020410.214112.10765569.davem@redhat.com>
To: kaber@trash.net
Cc: kuznet2@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: bug in sch_generic.c:pfifo_fast_enqueue
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0204012131330.13230-200000@el-zoido.localnet>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick McHardy <kaber@trash.net>
   Date: Mon, 1 Apr 2002 21:43:03 +0200 (CEST)

   I found a small bug in pfifo_fast_enqueue, instead of
   
   if (list->qlen <= skb->dev->tx_queue_len)
   
   it should be
   
   if (list->qlen <= qdisc->dev->tx_queue_len)
   
   i guess.

skb->dev == qdisc->dev should be invariant when this
code runs.  So the code is correct, albeit possibly
confusing.
