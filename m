Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSKNUIj>; Thu, 14 Nov 2002 15:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSKNUIj>; Thu, 14 Nov 2002 15:08:39 -0500
Received: from home.deeptown.org ([205.150.192.50]:7298 "HELO deeptown.org")
	by vger.kernel.org with SMTP id <S265180AbSKNUIf> convert rfc822-to-8bit;
	Thu, 14 Nov 2002 15:08:35 -0500
Message-ID: <002d01c28c1a$91ff9640$34c096cd@toybox>
From: "Serge Kuznetsov" <sk@deeptown.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
References: <015301c28c00$f6287390$34c096cd@toybox> <20021114.092646.38763468.davem@redhat.com>
Subject: Re: [NET] Possible bug in netif_receive_skb
Date: Thu, 14 Nov 2002 15:15:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
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
