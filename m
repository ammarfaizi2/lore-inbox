Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSGUVyL>; Sun, 21 Jul 2002 17:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSGUVyL>; Sun, 21 Jul 2002 17:54:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51609 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314340AbSGUVyK>;
	Sun, 21 Jul 2002 17:54:10 -0400
Date: Sun, 21 Jul 2002 23:56:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
In-Reply-To: <20020721234619.A10561@lst.de>
Message-ID: <Pine.LNX.4.44.0207212345490.29913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Christoph Hellwig wrote:

> > the genhd.c bit is safe as well, removed the comment.
> 
> Is there any reason the sti is there at all?  In -dj almost all drivers
> use module_init() now so it becomes increasingly useless..

well, indeed. While the sti() can be understood to a certain degree - we
used to boot with the IRQ lock on and accidentally leaving it enabled can
cause problems - but otherwise preceeding code should not disable
interrupts in an unbalanced way. I've removed the __sti() from my tree.

there's even more ancient code in the block driver init path, eg. in
drivers/block/ll_rw_blk.c:blk_dev_init():

        outb_p(0xc, 0x3f2);

i suspect this is ancient Linux code. 0x3f2 is one of the floppy
controller ports - many modern x86 boxes do not even have a floppy
controller! I've removed this from my tree as well - if this is needed at
all then it belongs into the floppy driver. Latest patch is at:
    
  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-B0

	Ingo

