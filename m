Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314060AbSDKN4p>; Thu, 11 Apr 2002 09:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSDKN4o>; Thu, 11 Apr 2002 09:56:44 -0400
Received: from port-212-202-186-28.reverse.qdsl-home.de ([212.202.186.28]:13572
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S314060AbSDKN4m>; Thu, 11 Apr 2002 09:56:42 -0400
Message-ID: <3CB59613.FA9D8F7D@trash.net>
Date: Thu, 11 Apr 2002 15:56:35 +0200
From: Patrick McHardy <kaber@trash.net>
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.4.18-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: kuznet2@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: bug in sch_generic.c:pfifo_fast_enqueue
In-Reply-To: <Pine.LNX.4.44.0204012131330.13230-200000@el-zoido.localnet> <20020410.214112.10765569.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" schrieb:
> 
>    From: Patrick McHardy <kaber@trash.net>
>    Date: Mon, 1 Apr 2002 21:43:03 +0200 (CEST)
> 
>    I found a small bug in pfifo_fast_enqueue, instead of
> 
>    if (list->qlen <= skb->dev->tx_queue_len)
> 
>    it should be
> 
>    if (list->qlen <= qdisc->dev->tx_queue_len)
> 
>    i guess.
> 
> skb->dev == qdisc->dev should be invariant when this
> code runs.  So the code is correct, albeit possibly
> confusing.


I (we) are (ab?)using the code to enqueue/dequeue arbitary
packets to a qdisc attached to a software device (imq)
for doing traffic control over multiple interfaces / ingress
traffic control with egress qdiscs, in that case 
skb->dev != qdisc->dev.
Although in normal circumstances the assumption may be right
it fails in this case. It would be nice if you apply my patch
as it doesn't changes anything and enforces correct behaviour
in cases like mine.

Bye,
Patrick
