Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbRDZODT>; Thu, 26 Apr 2001 10:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135443AbRDZODJ>; Thu, 26 Apr 2001 10:03:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:4869 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135427AbRDZOCw>;
	Thu, 26 Apr 2001 10:02:52 -0400
Date: Thu, 26 Apr 2001 11:02:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104260644430.672-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104261100490.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Mike Galbraith wrote:

> 1. pagecache is becoming swapcache and must be aged before anything is
> done.  Meanwhile we're calling refill_inactive_scan() so fast that noone
> has a chance to touch a page.   Age becomes a simple counter.. I think.
> When you hit a big surge, swap pages are at the back of all lists, so all
> of your valuable cache gets reclaimed before we write even one swap page.

Does the patch I sent to linux-mm@kvack.org last night help in
this ?

I found that the way refill_inactive_scan() and swap_out() are being
called from the main loop in refill_inactive() aren't equal and have
fixed that in a way which (IMHO) also beautifies the code a bit.

(and makes sure background aging doesn't get out of hand with a few
simple checks)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

