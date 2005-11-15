Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVKOGar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVKOGar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVKOGaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:30:46 -0500
Received: from waste.org ([64.81.244.121]:56222 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932304AbVKOGaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:30:46 -0500
Date: Mon, 14 Nov 2005 22:29:47 -0800
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [BUG] netpoll is unable to handle skb's using packet split
Message-ID: <20051115062947.GI31287@waste.org>
References: <9929d2390511141315t2fb15b2aucbbebcbe4cec7ef1@mail.gmail.com> <20051115052358.GG31287@waste.org> <20051114.213922.16377460.davem@davemloft.net> <20051114.214130.57199557.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114.214130.57199557.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 09:41:30PM -0800, David S. Miller wrote:
> From: "David S. Miller" <davem@davemloft.net>
> Date: Mon, 14 Nov 2005 21:39:22 -0800 (PST)
> 
> > From: Matt Mackall <mpm@selenic.com>
> > Date: Mon, 14 Nov 2005 21:23:58 -0800
> > 
> > > What is "packet split" in this context?
> > 
> > It's a mode of buffering used by the e1000 driver.
> 
> BTW, the issue is that in packet split mode, the e1000 driver is
> feeding paged based non-linear SKBs into the stack on receive which is
> completely legal but aparently netpoll or something parsing netpoll RX
> packets does not handle it properly.

The bug is in netpoll. It's non-linear ignorant. We probably can't
call skb_linearize because it wants to kmalloc, but we probably can
follow the fragment. Or, worst case, we can manually linearize into an
SKB in our private pool.

Can we make any assumptions about the size and position of fragments.
For instance, will the first N data bytes of a UDP packet all be in
the same fragment?

-- 
Mathematics is the supreme nostalgia of our time.
