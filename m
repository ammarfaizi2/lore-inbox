Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSA3Axx>; Tue, 29 Jan 2002 19:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSA3Axe>; Tue, 29 Jan 2002 19:53:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:36360 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287552AbSA3AxZ>;
	Tue, 29 Jan 2002 19:53:25 -0500
Date: Tue, 29 Jan 2002 22:52:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rob Landley <landley@trommello.org>, Skip Ford <skip.ford@verizon.net>,
        <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291610020.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201292245000.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:
> On Tue, 29 Jan 2002, Rik van Riel wrote:
> >
> > That's fine with me, but _who_ do I send VM patches to if
> > I can't send them to you ?
>
> The VM stuff right now seems to be Andrea, Dave or you yourself (right
> now I just wish you would split up your patches like Andrea does, that
> way I can cherry-pick).

I will.  It's not split up at the moment because I'd like to
work a bit more on -rmap before submitting it for inclusion
and bitkeeper is a really nice tool to help me carry the patch
from version to version.

If -rmap makes it into the kernel I'll work with small patches
in the same style as Andrea, that's just the easiest way to
work.

I'll also take some of rusty's scripts to automatically check
if a patch (1) has been applied to the latest kernel or
(2) if it still applies cleanly.

Basically I'm looking for a way to minimise the work of
carrying the -rmap VM across kernel versions, so I can spend
my time doing development and cleaning up the code further.

> The VM is a big issue, of course. And that one isn't likely to go away
> anytime soon as a point of contention. And it's not easy to modularize,
> apart from the obvious pieces (ie "filemap.c" vs the rest).

Actually some stuff can be modularised somewhat. Christoph
Hellwig for example has a nice patch which replaces all
knowledge of page->wait with wake_up_page().

This makes the fact of whether we're using per-page waitqueues
or hashed waitqueues completely invisible to the rest of the
kernel.

Similar things are possible for other areas of the code.

> You may not believe me when I say so, but I personally _really_ hope your
> rmap patches will work out. I may not have believed in your patches in a
> 2.4.x kind of timeframe, but for 2.6.x I'm more optimistic. As to how to
> actually modularize it better to make points of contention smaller, I
> don't know how.

One thing William Irwin (and others, myself too) have been
looking at is making the pagemap_lru_lock per-zone.

This would allow us to "split up" memory in zones and have
each CPU start the allocation chain at its own zone.

This works out in practice because the reverse mapping code
allows us to scan and free memory by physical address,
meaning that reclaim_page() becomes a per-CPU local thing
under light memory loads.

Of course the current problem with that code is truncate
and the lock ordering between the pagemap_lru_lock and the
page_cache_lock ... something to look at later.

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

