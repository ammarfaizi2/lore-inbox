Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLQIps>; Sun, 17 Dec 2000 03:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQLQIpj>; Sun, 17 Dec 2000 03:45:39 -0500
Received: from linuxcare.com.au ([203.29.91.49]:23300 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129352AbQLQIpZ>; Sun, 17 Dec 2000 03:45:25 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback) 
In-Reply-To: Your message of "Thu, 14 Dec 2000 12:23:19 -0800."
             <200012142023.MAA12823@pizda.ninka.net> 
Date: Sat, 16 Dec 2000 00:12:31 +1100
Message-Id: <E146uf1-0000Dq-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200012142023.MAA12823@pizda.ninka.net> you write:
>    Date: Thu, 14 Dec 2000 15:35:48 -0500 (EST)
>    From: "Mohammad A. Haque" <mhaque@haque.net>
> 
>    I'll be trying in a few hours.
> 
> Meanwhile for people wanting the crashes to be fixed, please
> apply this patch.
> 
> This was _always_ broken, and really what netfilter is doing
> should have never worked.  The only theory I have right now
> is that people using netfilter never had IP fragments timeout.
> :-)

Ick, we've previously had issues with using the defrag routine from
PRE_ROUTING (Andi fixed the `called without bh disabled' problem). 8(

Good news is that it's all done from one place:

net/ipv4/ip_conntrack_core.c:910:ip_ct_gather_frags(struct sk_buff *skb)

You can fix it to obey the rules there, rather than hacking fragment
code.

Cheers,
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
