Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269816AbRHDHNo>; Sat, 4 Aug 2001 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269818AbRHDHNZ>; Sat, 4 Aug 2001 03:13:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9735 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269816AbRHDHNW>;
	Sat, 4 Aug 2001 03:13:22 -0400
Date: Sat, 4 Aug 2001 04:13:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.21.0108040222561.9719-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0108040411220.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001, Marcelo Tosatti wrote:

> Well, the freepages_high change needs more work.
>
> Normal allocations are not going to easily "fall down" to lower zones
> because the high zones will be kept at freepages.high most of the time.

Actually, the first allocation loop in __alloc_pages()
is testing against zone->pages_high and allocating only
from zones which have MORE than this.

So I guess this should only result in a somewhat slower
and/or softer fallback and definately worth a try.

Oh, and we definately need to un-lazy the queue movement
from the inactive_clean list. Having all of the pages you
counted on as being reclaimable referenced is a very bad
surprise ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

