Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRKMP0n>; Tue, 13 Nov 2001 10:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRKMP0d>; Tue, 13 Nov 2001 10:26:33 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:18440 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S272818AbRKMP0S>;
	Tue, 13 Nov 2001 10:26:18 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111131525.SAA29471@ms2.inr.ac.ru>
Subject: Re: Fw: Networking: repeatable oops in 2.4.15-pre2
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 13 Nov 2001 18:25:45 +0300 (MSK)
Cc: davem@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org
In-Reply-To: <E163ZiI-0001CR-00@wagner> from "Rusty Russell" at Nov 13, 1 08:18:38 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The NAT code is special: it will always mangle packet the same way, so
> it doesn't *REALLY* matter if we mangle the original packet for local
> output (if we change IP headers in different ways for retransmission
> of the same packet, we would have much bigger problems).

No, this does not matter at all if you change only headers.
Netfilter is first who sees output packets and it may rewrite them
mostly arbitraririly: packet sockets, devices see only rewritten copy.

When retransmitting tcp prepares new headers and, hence, checks
for clonin itself, if someone holds the packet it prepares copy.

But if a hook changes _data_ (f.e. ftp packets), it can break original
packet sitting in tcp queue and this is fatal. So, when mangling
data, packet must be always copied. When mangling header, no copy
is required.


> Does this work for everyone?  Particularly while running tcpdump?

It does, but I cannot say "for everyone", it will work with current
protocol suite, but probably will break with out-of-tree stacks.

Anyway, if it will not work, it will be problem not of netfilter,
but of the guy who did not prepare right ownership. :-)

Alexey
