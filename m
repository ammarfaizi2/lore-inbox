Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbRL2TQ7>; Sat, 29 Dec 2001 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285329AbRL2TQv>; Sat, 29 Dec 2001 14:16:51 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:34573 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S285269AbRL2TQi>;
	Sat, 29 Dec 2001 14:16:38 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112291916.WAA12108@ms2.inr.ac.ru>
Subject: Re: NETIF_F_(SG|FRAGLIST|HIGHDMA) docs anywhere?
To: stodden@in.tum.DE (Daniel Stodden)
Date: Sat, 29 Dec 2001 22:16:21 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1009610172.2105.0.camel@bitch> from "Daniel Stodden" at Dec 29, 1 10:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 			so i guess supporting at least scatter/gather
> should give some performance improvements in order to get rid of
> skb_linearize() on xmit?

I beg pardon but before strating to fight problems, it is necessary
to force kernel to prepare something different of linear skbs. :-)

What's about checksumming? Do you plan to ignore it?


>			 since transmission is done completely by the
> local cpu, all of F_SG/FRAGLIST/HIGHDMA look relatively easy to
> implemement to me.=20

I see no connection between "cpu locality" and frgamtn hadling at all.


> frag_list seems to be the list involved with keeping track of ip
> fragmentation. so dev->hard_start_xmit() with frag_list set would only
> happen on routers or when??

In stock kernels: _never_. Packets are not defragmented by routers,
and netfilter linearizes everything in any case.

Anyway, if the driver is able to provide some facility, why not to do this?

> when is nr_frags>0? i've found some postings indicating sendfile(2) will
> benefit here. is this the only case?

Yes.

Which means that the task is not so sexy. :-)

Alexey
