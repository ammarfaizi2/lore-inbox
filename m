Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSHDS4s>; Sun, 4 Aug 2002 14:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSHDS4r>; Sun, 4 Aug 2002 14:56:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13321 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318207AbSHDS4p>; Sun, 4 Aug 2002 14:56:45 -0400
Date: Sun, 4 Aug 2002 15:59:46 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hans Reiser <reiser@namesys.com>, Andreas Gruenbacher <agruen@suse.de>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
In-Reply-To: <Pine.LNX.4.44.0208041146380.10314-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208041555500.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Linus Torvalds wrote:
> On Sun, 4 Aug 2002, Rik van Riel wrote:
> >
> > Linus has indicated that he would like to have it page based,
> > but implementation issues point towards letting the subcache
> > manage its objects by itself ;)
>
> The two are not mutually incompatible.

> In particular, it is useless for the sub-caches to try to maintain their
> own LRU lists and their own accessed bits. But that doesn't mean that
> they can _act_ as if they updated their own accessed bits, while really
> just telling the page-based thing that that page is active.

I'm not sure I agree with this.  For eg. the dcache you will want
to reclaim the less used entries on a page even if there are a few
very intensely used entries on that page.

This is because then new dcache allocations can come from the
empty space on this page and the dcache doesn't have to grow in
order to allocate new entries.

If we were to go fully page-based, it'd become impossible to evict
dcache entries from any page with at least one heavily used entry
and the dcache will use much more space than otherwise required.
In reality it'd be even worse because we cannot evict any dcache
entry which is pinned by eg. inodes or directory entries.

Please tell me if I've overlooked something, it would be nice if
the page based scheme could work out after all ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

