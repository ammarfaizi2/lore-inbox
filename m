Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSKNWH5>; Thu, 14 Nov 2002 17:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSKNWH4>; Thu, 14 Nov 2002 17:07:56 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:14232 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S261609AbSKNWHx>;
	Thu, 14 Nov 2002 17:07:53 -0500
Date: Thu, 14 Nov 2002 21:05:46 +0000
From: Serge Kuznetsov <sk@deeptown.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [NET] Possible bug in netif_receive_skb
Message-ID: <20021114210546.GI28216@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> ->func() must either take or free up the SKB, there must be no
> violations of this rule.
> 

Could you explain it more clearly?

How it applies to that two ( even three ) scenarios, I've told?

What if we have the first scenario:

ptype_all->func = func1;
ptype_all->next = NULL;

  Will this function be called or not?

Second scenario:

ptype_all->func = func1;
ptype_all->next = &ptype1;

ptype1->func = func2;
ptype1->next = NULL;

Will func2() be called?

Third scenario:

ptype_all->func = func1;
ptype_all->next = &ptype1;

ptype1->func = func2;
ptype1->next = &ptype2;

ptype2->func = func3;
ptype2->next = &ptype3;

ptype3->func = func4;
ptype3->next = NULL;

If func2() freed skb, and return NET_RX_DROP, what will happen?


PS: I still don't understand why we should skip the first step, and call first function on second cycle?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
