Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276612AbRJBSvW>; Tue, 2 Oct 2001 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276573AbRJBSvL>; Tue, 2 Oct 2001 14:51:11 -0400
Received: from www.transvirtual.com ([206.14.214.140]:47110 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276548AbRJBSu5>; Tue, 2 Oct 2001 14:50:57 -0400
Date: Tue, 2 Oct 2001 11:50:58 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ricky Beam <jfbeam@bluetopia.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        linux-kernel@vger.kernel.org
Subject: Re: Huge console switching lags
In-Reply-To: <Pine.GSO.4.33.0110021423140.22872-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.10.10110021142230.14469-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >A console switch has to wait until queued I/O to that console is complete,
> 
> Ok, so fix that. (assuming that's not "waiting on the hardware" queued IO)

Strange you are having this problem. I have been using Morton's patch for
months now with the framebuffer layer and have no problems. Well I have
done some modifications which I will post shortly.

> >Also a console switch on a frame buffer with no hardware banking can take
> >a lot of time.
> 
> Oh, *grin*, forgot about those evil framebuffer consoles. (never use them
> myself, they really are freakin' slow.)  Arguablly, all access to fbdev's
> should be from a process context (it's like having X in the kernel.)

Well the reason the framebuffer suck is because the current api sucks for
them. It draws pixel by pixel. Slow slow slow!!! I have developed a new
api that takes advantage of the accel engine of graphics hardware. It is
much simpler and more flexiable and most important much much faster. Yes
there exist graphics hardware that are pure dummy framebuffers. Here I
have written soft accels (fillrect, draw image, copy area). They are much
faster than the current implemenation. I haven't even assemblty optimized
them or used MMX type things yet. Once that is done it will be very fast.

The point of the console locking change was because their exist graphics
hardware that is IRQ/DMA based only. Using a spinlock turns off printing
to the screen. Oops, big problem. With the new console locking mechanism
we can use the DMA/irq engine of any graphics card. This is much much
faster than using the mmio region like some of the fbdev drivers do. It is
faster than drawing pixel by pixel but it could be much faster.

