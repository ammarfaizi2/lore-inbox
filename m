Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSHTXiB>; Tue, 20 Aug 2002 19:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSHTXiA>; Tue, 20 Aug 2002 19:38:00 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:16903 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S317489AbSHTXiA>; Tue, 20 Aug 2002 19:38:00 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208202338.g7KNc6q9020629@wildsau.idv.uni.linz.at>
Subject: Re: need contact of via-rhine developers
In-Reply-To: <20020820232624.GA32608@k3.hellgate.ch> from Roger Luethi at "Aug 21, 2 01:26:24 am"
To: rl@hellgate.ch (Roger Luethi)
Date: Wed, 21 Aug 2002 01:38:06 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (l),
       kernel@wildsau.idv.uni.linz.at (H.Rosmanith (Kernel Mailing List))
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You will probably need more log information than the driver can provide.

e.g. like this:

  : Aug 21 07:37:22 samiel kernel: > via_rhine_tx
  : Aug 21 07:37:22 samiel kernel:  Tx scavenge 11 status 80000000.
  : Aug 21 07:37:22 samiel kernel: eth0: exiting interrupt, status=0000.
  : Aug 21 07:37:22 samiel kernel: > via_rhine_start_tx
  : Aug 21 07:37:22 samiel kernel:   stopping netif_queue
  : Aug 21 07:37:22 samiel kernel: eth0: Transmit frame #36 queued in slot 4.
  : Aug 21 07:37:22 samiel kernel: eth0: Interrupt, status 0002.
  : Aug 21 07:37:22 samiel kernel: > via_rhine_tx
  : Aug 21 07:37:22 samiel kernel:  Tx scavenge 11 status 80000000.
  : Aug 21 07:37:22 samiel kernel: eth0: exiting interrupt, status=0000.
  : Aug 21 07:37:26 samiel kernel: eth0: VIA Rhine monitor tick, status 0000.
  : Aug 21 07:37:26 samiel kernel: NETDEV WATCHDOG: eth0: transmit timed out
  : Aug 21 07:37:26 samiel kernel: > via_rhine_tx_timeout

this indicates that the netif_queue is stopped, but never started again,
allthough:

        if ((np->cur_tx - np->dirty_tx) < TX_QUEUE_LEN - 4)
                netif_wake_queue (dev);

maybe something is wrong with that one?

I'll add more debugs...

regards,
h.rosmanith
 
