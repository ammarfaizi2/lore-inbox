Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288784AbSAXRxs>; Thu, 24 Jan 2002 12:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288809AbSAXRxc>; Thu, 24 Jan 2002 12:53:32 -0500
Received: from www.transvirtual.com ([206.14.214.140]:18190 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S288800AbSAXRxQ>; Thu, 24 Jan 2002 12:53:16 -0500
Date: Thu, 24 Jan 2002 09:52:59 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Sven <luther@dpt-info.u-strasbg.fr>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
In-Reply-To: <20020123183102.A3780@dpt-info.u-strasbg.fr>
Message-ID: <Pine.LNX.4.10.10201240949370.28447-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The correct fix is to do something like fb_info.node = NODEV;
> 
> And not B_FREE ?
> 
> I am unsure about this, but i notice that in the 2.4.17 kernel + pm3fb, the
> value assigned to .node was -1, which correspond to B_FREE and not NODEV
> (which is 0).

Looking at it your right. It should be B_FREE.

> That said, since it is almost never used, it would maybe be best to move it
> out of the fbdevs and into some of the more generic layers.

I agree. In fact it is already does set it. Form rgeister_framebuffer

fb_info->node = mk_kdev(FB_MAJOR, i);

So why does any fbdev driver touch it?

> Also, since when does the B_FREE or NODEV exists ? I did put the changes into
> a #ifdef kernel 2.5, and kept the -1 for kernels 2.4, but i guess i could
> remove this check altogether if the NODEV was present from the begining. And
> what about 2.2 kernels ?

It is a 2.5.X thing. 


