Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276176AbRI1REt>; Fri, 28 Sep 2001 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276175AbRI1REj>; Fri, 28 Sep 2001 13:04:39 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:57609 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276170AbRI1RE2>;
	Fri, 28 Sep 2001 13:04:28 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109281704.VAA04444@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: mingo@elte.hu
Date: Fri, 28 Sep 2001 21:04:43 +0400 (MSK DST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33.0109281817140.8840-100000@localhost.localdomain> from "Ingo Molnar" at Sep 28, 1 06:31:59 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> it does not, please read the code again. We iterate over all active bits
> in the 'pending' bitmask.

OK.


> net_rx_action() stops spinning if 1) a jiffy has passed 2) 300 packets
> have been processed. [the jiffy test is not completely accurate

It is. The break is forced not earlier than after one jiffie, but
it may loop for up to 2 jiffies.


> there is nothing sacred about the old method of processing NET_RX_SOFTIRQ,
> then NET_TX_SOFTIRQ, then breaking out of do_softirq() (the mechanizm was
> a bit more complex than that, but in insignificant ways). It's just as
> arbitrary as 10 loops - with the difference that 10 loops perform better.

Do not cheat yourself. 10 is more than 1 by order of magnitude.
I would eat this argument if the limit was 2. :-)


> > Most likely, your problem will disappear when you renice ksoftirqd
> > to higher priority f.e. equal to priority of tux threads.
> 
> (no. see the previous mails.)

But I do not know what exactly to look for there.

Please, explain who exactly obtains an advantage of looping.
net_rx_action()? Do you see drops in backlog?
Actually, I could see a sense in your approach if you said
something sort of: "I see drops in backlog, I want to increase
it to 3000, but it breaks latency, so that let it remain 300,
but instead I will make 10 loops". This would be sane justification
at least.

net_tx_action()? It does not look critical.

Alexey
