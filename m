Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132355AbRCZHFl>; Mon, 26 Mar 2001 02:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132357AbRCZHFb>; Mon, 26 Mar 2001 02:05:31 -0500
Received: from zeus.kernel.org ([209.10.41.242]:22999 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132355AbRCZHFV>;
	Mon, 26 Mar 2001 02:05:21 -0500
Date: Mon, 26 Mar 2001 11:02:13 +0400
From: Oleg Drokin <green@ixcelerator.com>
To: Manoj Sontakke <manojs@sasken.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: IP layer bug?
Message-ID: <20010326110213.A17124@iXcelerator.com>
In-Reply-To: <20010326100941.A16800@iXcelerator.com> <Pine.LNX.4.21.0103261739260.25784-100000@pcc65.sasi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103261739260.25784-100000@pcc65.sasi.com>; from manojs@sasken.com on Mon, Mar 26, 2001 at 05:51:43PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 26, 2001 at 05:51:43PM +0530, Manoj Sontakke wrote:
> > > ip_options_compile() when called with first argument NULL resets cb to 0.
> > I have found that already.
> > > underlying layer(link and phy) could be anything so where from the
> > > ip_options should start will depend upon the underlying layer.
> > But here's the problem!
> > If I won't zero cb in my driver before netif_rx() call,
> > IP layer thinks that all my packets have various ip options set
> > (source routing most notable)
> U can set cb to zero, but u also plan to use cb for storing ur data. If
I use it for storing data, but when I do netif_rx() on skb, I cannot touch it
anymore, so no data there is belong to me, and if I read that code in
ip_input.c, it gets zeroed.
BTW, I found that it's not ip_input.c that sends me 'source routing rejected'
message, because no message is logged. It might be some other place.
But anyway something is wrong in IP layer.

> that happens then u need to modify the way the macro IPCB
> (probably in net/ip.h) is defined. Also make sure to increase the size 
> of cb to accomodate ur data. This will solve ur problem but making this
My data perfectly fits in cb of current size.

> general (part of the standard kernel code) needs a lot of work in the ip
> layer. The cb is also used by TCP. The same needs to be done in IP layer
> but this will again largly depend on the layers below and hence the
> complexity.
But comment in skbuff.h claims that any owner of skb can use cb for its own needs, till it passes ownership to whoever else.

> The alternative to this is that u can add another buffer like cb in
> sk_buff.
What for?

Bye,
    Oleg
