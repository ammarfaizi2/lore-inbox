Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272893AbRIGW7V>; Fri, 7 Sep 2001 18:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272895AbRIGW7K>; Fri, 7 Sep 2001 18:59:10 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:22278 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S272893AbRIGW7F>;
	Fri, 7 Sep 2001 18:59:05 -0400
Date: Sat, 8 Sep 2001 00:59:24 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Dropped packets with the newest tulip driver due to FIFO overflow
Message-ID: <Pine.LNX.4.33.0109080040060.31881-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff, LKML!

With the newest tulip driver (1.1.8 or the one in linux-2.4.9), I'm
getting extremely bad receive performance, with around 30-90% of all
received packets beeing mysteriously and silently dropped.  This on a
Cardbus DC21143, which works very well with "all" previous versions.
(...and it's not a duplex issue, trust me...)

After some head-scratching, I traced the packet loss to receive FIFO
overflows.  The missing packets are accounted for in CSR8<27:17>, which is
the FIFO overflow counter.  The driver does not read this counter for some
reason, and that's why the packets are silently dropped.  FIFO errors are
what you get if the DMA to memory is not happening fast enough.  It is not
obvious to me why the changes in the driver caused this, but I do have
some ideas to try tomorrow, after some sleep.  I find it strange that the
packet loss is so extreme, though.

I'm writing this to verify that this is not a known problem, to make sure
I'm not wasting my time.

Any ideas or comments?

/Tobias

