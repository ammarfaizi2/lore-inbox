Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTCEUMA>; Wed, 5 Mar 2003 15:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTCEUMA>; Wed, 5 Mar 2003 15:12:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:19214 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261907AbTCEUL5>; Wed, 5 Mar 2003 15:11:57 -0500
Date: Wed, 5 Mar 2003 20:22:26 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0303052015250.27760-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>   while waiting on these updates I updated matroxfb a bit
> (ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.63.gz),
> so that it now uses fb_* for cfb modes, and putcs/... hooks for
> text mode. I have still dozen of changes in fbcon.c which I have
> to eliminate (mainly logo painting and cursor handling - for now
> I still use revc method, mainly because of I did not make into it yet).

I grabbed your latest patch and started to merge it with my latest work on 
the matrox driver. As soon as I'm done merging my matrox changes I will 
send you a patch right away.

>   My main concern now is 12x22 font... Accelerator setup
> is so costly for each separate painted character that for 8bpp 
> accelerated version is even slower than unaccelerated one :-(
> (and almost twice as slow when compared with 2.4.x).

Try the latest patch I released.
 
>   And one (or two...) generic questions: why is not pseudo_palette
> u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?

pseudo_palette was originally designed to be a pointer to some kind of 
data for color register programming. For example many PPC graphics cards 
have a color register region. Now you could have that point to 
pseudo_palette.  Note pseudo_palette is only visiable in fbmem.c for the 
logo drawing code. Personally I liek to see that hidden.

> And why we do not fill this pseudo_palette with
> i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> pseudocolor? This allowed me to remove couple of switches and tests
> from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> but I did not changed these two in my benchmarks below).

??? Does your accel engine require these kinds of values?


