Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129323AbRBYMXj>; Sun, 25 Feb 2001 07:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBYMX3>; Sun, 25 Feb 2001 07:23:29 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:40460 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129323AbRBYMXR>;
	Sun, 25 Feb 2001 07:23:17 -0500
Date: Sun, 25 Feb 2001 13:22:49 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
Message-ID: <20010225132249.J18271@almesberger.net>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Feb 24, 2001 at 06:25:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 1) Rx Skb recycling.

Sounds like a potentially useful idea. To solve the most immediate memory
pressure problems, maybe VM could provide some function that does a kfree
in cases of memory shortage, and that does nothing otherwise, so the
driver could offer to free the skb after netif_rx. You still need to go
over the list in idle periods, though.

> 2) Tx packet grouping.

Hmm, I think we need an estimate of how long a packet train you'd usually
get. A flag looks reasonably inexpensive. Estimated numbers sound like
over-engineering.

> Disadvantages?  Can this sort of knowledge be obtained by a netdevice
> right now, without any kernel modifications?

Question is what the hardware really needs. If you can change the
interrupt point easily, it's probably cheapest to do all the work in
hard_start_xmit.

> 3) Slabbier packet allocation.

Hmm, this may actually be worse during bursts: if you burst exceeds
the preallocated size, you have to perform more expensive/slower
operations (e.g. running a tasklet) to refill your cache.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
