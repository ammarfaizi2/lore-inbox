Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266422AbRGCCjv>; Mon, 2 Jul 2001 22:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266424AbRGCCjl>; Mon, 2 Jul 2001 22:39:41 -0400
Received: from www.transvirtual.com ([206.14.214.140]:15887 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S266422AbRGCCj2>; Mon, 2 Jul 2001 22:39:28 -0400
Date: Mon, 2 Jul 2001 19:39:05 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: David T Eger <eger@cc.gatech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: readl() / writel() on PowerPC
In-Reply-To: <Pine.SOL.4.21.0107022017370.23357-100000@oscar.cc.gatech.edu>
Message-ID: <Pine.LNX.4.10.10107021935590.8156-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been working on a driver for a PowerPC PCI card/framebuffer device,
> and noticed that the standard readl() and writel() for this platform to
> byte swapping, since PowerPC runs big-endian.  However, at least for my
> hardware it's *really* not needed, and should just do a regular load
> store, as is done for CONFIG_APUS.  Looking at another driver
> (drivers/char/bttv.h) I notice that Mr. Metzler redefines his read and
> write routines for PowerPC as well to do simple loads and stores to IO
> regions.
> 
> Am I missing something?  Is there some reason that readl() and
> writel() should byte-swap by default?

Use the fb_writeX/fb_readX functions in fbcon.h. They take care of these
issues.

P.S
   Watchout for userland programs. You can NOT use memset on the
framebuffer on PPC due to caching issues. Use have to use tricks similar
to what is done in fbcon.h with fb_memset.
   

