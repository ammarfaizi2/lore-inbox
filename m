Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273593AbRIQM06>; Mon, 17 Sep 2001 08:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRIQM0R>; Mon, 17 Sep 2001 08:26:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64273 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273587AbRIQM0G>;
	Mon, 17 Sep 2001 08:26:06 -0400
Date: Mon, 17 Sep 2001 09:26:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109170923190.2990-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Linus Torvalds wrote:

>  - truly anonymous pages (ie before they've been added to the swap cache)
>    are not necessarily going to behave as nicely as other pages. They
>    magically appear after VM scanning as a "1st reference", and I have a
>    reasonably good argument that says that they'll have been aged up and
>    down roughly the same number of times, which makes this more-or-less
>    correct. But it's still a theoretical argument, nothing more.

This nicely points out the problem with page aging which Linux
has always had. Pages which are referenced all the time by the
processes using them STILL get aged down all the time.

I suspect that the biggest impact the reverse mapping patch
has right now seems to be caused by fixing this behaviour and
just aging up a page when it is referenced and down when it is
not.

>  - I don't like the lack of aging in 'reclaim_page()'. It will walk the
>    whole LRU list if required, which kind of defeats the purpose of having
>    reference bits and LRU on that list. The code _claims_ that it almost
>    always succeeds with the first page, but I don't see why it would. I
>    think that comment assumed that the inactive_clean list cannot have any
>    referenced pages, but that's never been true.

This depends on whether we do reactivation in __find_page_nolock()
or if we leave the page alone and wait for kswapd to do that for
us.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

