Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSHTX1Y>; Tue, 20 Aug 2002 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSHTX1Y>; Tue, 20 Aug 2002 19:27:24 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:14343 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S318355AbSHTXYt>; Tue, 20 Aug 2002 19:24:49 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208202324.g7KNOqbU020602@wildsau.idv.uni.linz.at>
Subject: Re: need contact of via-rhine developers
In-Reply-To: <200208202159.g7KLxrrM020439@wildsau.idv.uni.linz.at> from "H.Rosmanith" at "Aug 20, 2 11:59:53 pm"
To: kernel@wildsau.idv.uni.linz.at (H.Rosmanith)
Date: Wed, 21 Aug 2002 01:24:51 +0200 (MET DST)
Cc: rl@hellgate.ch, kernel@wildsau.idv.uni.linz.at, rob.myers@gtri.gatech.edu,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

the following comment in the header of via-rhine.c made me suspicious:


 : The send packet thread has partial control over the Tx ring. It locks
 : the dev->priv->lock whenever it's queuing a Tx packet. If the next slot
 : in the ring is not available it stops the transmit queue by calling
 : netif_stop_queue.

okay so far. reading through net/sched/sched_generic.c shows that "NETDEV
WATCHDOG" will bark when (among other conditions) the netif queue is stoppped
and the timer expires. so, what if the queue is stopped, but never started
again by the driver? the only call to netif_start_queue is in via_rhine_open.
shouldn't there be another netif_start_queue if netif_queue_stopped(dev) &&
a packet has left the queue? where's the proper place to insert that?

regards,
h.rosmanith


