Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRACSBX>; Wed, 3 Jan 2001 13:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRACSBN>; Wed, 3 Jan 2001 13:01:13 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:6408 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S129226AbRACSBH>;
	Wed, 3 Jan 2001 13:01:07 -0500
Date: Wed, 3 Jan 2001 22:59:48 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: is eth header is not transmitted 
Message-ID: <Pine.SOL.3.96.1010103223330.7550A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	In the function ip_build_xmit(), immediately after
sk_alloc_send_skb(), skb_reserve(skb, hh_len) is called. Now
skb_reserve(skb,len) only increment the data pointer and tail pointer by 
len amt.

	Now in a particular hard_start_xmit() say for rtl8139, the data
transfer is taking place from skb->data :
	outl(virt_to_bus(skb->data), ioaddr + TxAddr0 + entry*4)

So, I cannot understand, if transfer starts from data and not head, is
ethrnet header not transmitted? what I am missing? 

/sourav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
