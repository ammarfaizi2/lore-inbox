Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWBLQzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWBLQzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBLQzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:55:40 -0500
Received: from [194.90.237.34] ([194.90.237.34]:23186 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751167AbWBLQzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:55:39 -0500
Date: Sun, 12 Feb 2006 18:56:57 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [git patch review 1/4] IPoIB: Don't start send-only joins while multicast thread is stopped
Message-ID: <20060212165657.GA14127@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1139689341370-68b63fa9b8e76d91@cisco.com> <20060211140209.57af1b16.akpm@osdl.org> <ada8xsh49ll.fsf@cisco.com> <20060212075037.GA11550@mellanox.co.il> <adazmkw3543.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adazmkw3543.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Feb 2006 16:57:27.0531 (UTC) FILETIME=[676CBBB0:01C62FF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Subject: Re: [openib-general] Re: [git patch review 1/4] IPoIB: Don't start send-only joins while multicast thread is stopped
> 
>     Michael> Basically, its as Andrew said: the lock around clear_bit
>     Michael> is there to ensure that ipoib_mcast_send isnt running
>     Michael> already when we stop the thread.  Thats why test_bit has
>     Michael> to be inside the lock, too.
> 
> Makes sense I guess.  If I'm understanding correctly, the lock isn't
> really there to serialize the bit ops, but rather to make sure
> ipoib_mcast_send() won't do anything after we clear the bit.

Right. Thats one way to put it.

> Does that mean that there's no reason to take the lock around the set_bit()?

Ugh, sorry, I dont really remember why I put it there.

I guess I just have easier time reasoning about locks than barriers and atomic
operations. "bit is protected by priv->lock" is a simple rule, and we are not on
data path here. The fact that the race went unnoticed for a while validates
this approach in my eyes.

I guess longer term we will replace mcast_mutex with priv->lock anyway, so it
doesnt matter much.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
