Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbREFCYt>; Sat, 5 May 2001 22:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbREFCYi>; Sat, 5 May 2001 22:24:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56840 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S131323AbREFCYV>;
	Sat, 5 May 2001 22:24:21 -0400
Date: Sat, 5 May 2001 23:24:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
Cc: Mitch Adair <mitch@theneteffect.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
In-Reply-To: <20010506135322.B11201@tapu.f00f.org>
Message-ID: <Pine.LNX.4.21.0105052320380.582-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, Chris Wedgwood wrote:
> On Sat, May 05, 2001 at 11:34:16AM -0500, Mitch Adair wrote:
> 
>     Wouldn't that be lot of the same issues as a "swapoff" with some
>     portion of that in use?  (except for the kernel data case of
>     course...)
> 
> No. Swapoff makes pages allocated to userland applications in swap
> move back into main memory -- this is much easier because:
> 
>    - the pages are on disk, we _know_ the aren't locked my mlock or
>      pinned for IO (kiobufs, whatever)
> 
>    - there are no kernel pages/buffers in this area, even harder than
>      the above to deal with

Details, details ... ;)

For the "pinned for IO" case, we can simply wait until they're
unpinned, this shouldn't take too long. Mlock isn't an issue
either, just remove the page from the page tables, relocate the
page and put it back. This may in theory violate some mlock
behaviour, but in practice it'll be no worse than normal
scheduling latency.

Kernel pages/buffers are no big deal since they're accessed
through the kernel's page tables (for which the same rule
applies as what we do with the mlock()ed pages).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

