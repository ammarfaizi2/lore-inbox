Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135339AbRDZMAZ>; Thu, 26 Apr 2001 08:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135344AbRDZMAQ>; Thu, 26 Apr 2001 08:00:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:1797 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135339AbRDZMAI>;
	Thu, 26 Apr 2001 08:00:08 -0400
Date: Thu, 26 Apr 2001 13:59:10 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104260619200.1364-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104261332420.353-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Marcelo Tosatti wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
>
> > > (i cannot see how this chunk affects the VM, AFAICS this too makes the
> > > zapping of the cache less agressive.)
> >
> > (more folks get snagged on write.. they can't eat cache so fast)
>
> What about GFP_BUFFER allocations ? :)
>
> I suspect the jiffies hack is avoiding GFP_BUFFER allocations to eat cache
> insanely.

(I think it's aging speed in general.  If user tasks aren't doing it,
kswapd is.)

> Easy way to confirm that: add the kswapd wait queue again and make
> allocators which don't have __GFP_IO set wait on that in
> try_to_free_pages().

I've tried not allowing those to enter try_to_free_pages() [nogo].
I'll try a waitqueue.  wait_event(waitqueue_active(&kswapd_wait)) ok?

	-Mike

