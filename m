Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDZEaJ>; Thu, 26 Apr 2001 00:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133091AbRDZE37>; Thu, 26 Apr 2001 00:29:59 -0400
Received: from www.wen-online.de ([212.223.88.39]:42002 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131323AbRDZE3l>;
	Thu, 26 Apr 2001 00:29:41 -0400
Date: Thu, 26 Apr 2001 06:28:57 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104251829490.967-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104260617020.566-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Marcelo Tosatti wrote:

> On Tue, 24 Apr 2001, Linus Torvalds wrote:
>
> > Basically, I don't want to mix synchronous and asynchronous
> > interfaces. Everything should be asynchronous by default, and waiting
> > should be explicit.
>
> The following patch changes all swap IO functions to be asynchronous by
> default and changes the callers to wait when needed (except
> rw_swap_page_base which will block writers if there are too many in flight
> swap IOs).
>
> Ingo's find_get_swapcache_page() does not wait on locked pages anymore,
> which is now up to the callers.
>
> time make -j32 test with 4 CPUs machine, 128M ram and 128M swap:
>
> pre5
> ----
> 228.04user 28.14system 5:16.52elapsed 80%CPU (0avgtext+0avgdata
> 0maxresident)k
> 0inputs+0outputs (525113major+678617minor)pagefaults 0swaps
>
> pre5 + attached patch
> --------------------
> 227.18user 25.49system 3:40.53elapsed 114%CPU (0avgtext+0avgdata
> 0maxresident)k
> 0inputs+0outputs (495387major+644924minor)pagefaults 0swaps
>
>
> Comments?

More of a question.  Neither Ingo's nor your patch makes any difference
on my UP box (128mb PIII/500) doing make -j30.  It is taking me 11 1/2
minutes to do this test (that's horrible).  Any idea why?

(I can get it to under 9 with MUCH extremely ugly tinkering.  I've done
this enough to know that I _should_ be able to do 8 1/2 minutes ~easily)

	-Mike

