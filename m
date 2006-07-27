Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWG0Jhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWG0Jhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWG0Jhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:37:55 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56970 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932108AbWG0Jhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:37:54 -0400
Date: Thu, 27 Jul 2006 13:37:23 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060727093722.GA11133@2ka.mipt.ru>
References: <20060727074902.GC5490@2ka.mipt.ru> <20060727.010255.87351515.davem@davemloft.net> <20060727085812.GA24529@2ka.mipt.ru> <20060727.023156.61758783.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060727.023156.61758783.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 27 Jul 2006 13:37:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 02:31:56AM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Thu, 27 Jul 2006 12:58:13 +0400
> 
> > Btw, according to DMA allocations - there are some problems here too.
> > Some pieces of the world can not dma behind 16mb, and someone can do it
> > over 4gb.
> 
> I think people take this "DMA" in Ulrich's interface names too
> literally.  It is logically something different, although it could be
> used directly for this purpose.
> 
> View it rather as memory you have by some key based ID, but need to
> explicitly map to access directly.

I mean here, that it is possible to have those Ulrich's dma regions to
be used as a real dma regions, and showed that it is not a good idea.

> > Those physical pages can be managed within kernel and userspace can map
> > them. But there is another possibility - replace slab allocation for
> > network devices with allocation from premapped pool.
> > That naturally allows to manage that pool for AIO needs and have
> > zero-copy sending and receiving support. That is what I talked in
> > netchannel topic when question about allocation/freeing cost in atomic
> > context arised. I work on that solution, which can be used both for
> > netchannels (and full userspace processing) and usual networking code.
> 
> Interesting idea, and yes I have been watching you stress test your
> AVL tree code :))

Tests are completed - actually it required 12 a4 papers filled with
small circles and numbers to prove it is correct, overnight run was just
for clarifications :)

-- 
	Evgeniy Polyakov
