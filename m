Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUIAXVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUIAXVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUIAXVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:21:00 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:49007 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S267823AbUIAXPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:15:32 -0400
Date: Thu, 2 Sep 2004 02:18:40 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901231840.GF26044@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1094052981.431.7160.camel@cube> <52vfey0ylu.fsf@topspin.com> <20040901215314.GC26044@mellanox.co.il> <52sma1y4t7.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52sma1y4t7.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting r. Roland Dreier (roland@topspin.com) "Re: f_ops flag to speed up compatible ioctls in linux kernel":
>     Roland> Yes, this is exactly right.  One issue raised by this
>     Roland> thread is that the ioctl32 compatibility code only allows
>     Roland> one compatibility handler per ioctl number.  It seems that
>     Roland> this creates all sorts of possibilities for mayhem because
>     Roland> it makes the ioctl namespace global in scope in some
>     Roland> situations.  Does anyone have any thoughts on if/how this
>     Roland> should be addressed?
> 
>     Michael> Thats what my original patch attempts to address
>     Michael> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0409.0/0025.html
>     Michael> What do you think?
> 
> That patch seems somewhat orthogonal to the issue I raised.  You're
> just fixing the problem for devices that don't use the ioctl32 compat
> layer.
> 

No I'm removing the need for ioctls to go through the compat layer.
No compat layer, no problem.

I see the compat layer as a hack to support legacy devices without touching
all of their code.
I dont see why a new driver would use the compat hacks instead of simply
building a 32/64 bit compatible interface, and legacy drivers have the
uniqueness for commands solved one way or another.

So the only interesting problem left is for new char devices.

MST
