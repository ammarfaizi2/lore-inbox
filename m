Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSIJVYS>; Tue, 10 Sep 2002 17:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSIJVYS>; Tue, 10 Sep 2002 17:24:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17068 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315779AbSIJVYS>;
	Tue, 10 Sep 2002 17:24:18 -0400
Date: Tue, 10 Sep 2002 14:21:08 -0700 (PDT)
Message-Id: <20020910.142108.08824481.davem@redhat.com>
To: steve@neptune.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209101716300.17602-100000@triton.neptune.on.ca>
References: <20020910211222.37684.qmail@web14001.mail.yahoo.com>
	<Pine.LNX.4.44.0209101716300.17602-100000@triton.neptune.on.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve Mickeler <steve@neptune.ca>
   Date: Tue, 10 Sep 2002 17:19:53 -0400 (EDT)

   Compiling in tg3 support using the tg3.c and tg3.h from 2.4.20-pre6
 ...   
   tg3.c: In function `tg3_rx':
   tg3.c:1977: warning: implicit declaration of function `netif_receive_skb'

I pretty sure you mispatched your tree.

It's there in 2.4.20-pre6:

bash$ egrep netif_receive_skb patch-2.4.20-pre6 
+                       netif_receive_skb (skb);
+3) instead of netif_rx() we call netif_receive_skb() to pass the skb.
+                       netif_receive_skb(skb);
+       return (polling ? netif_receive_skb(skb) : netif_rx(skb));
+extern int             netif_receive_skb(struct sk_buff *skb);
+int netif_receive_skb(struct sk_buff *skb)
+               netif_receive_skb(skb);
+EXPORT_SYMBOL(netif_receive_skb);
bash$ 
