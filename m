Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSG2ET0>; Mon, 29 Jul 2002 00:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSG2ET0>; Mon, 29 Jul 2002 00:19:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17412 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318008AbSG2ETZ>; Mon, 29 Jul 2002 00:19:25 -0400
Date: Sun, 28 Jul 2002 21:23:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D44C1C8.C1617A09@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207282121580.1003-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
> truncate_complete_page() _used_ to explicitly remove the page from
> the lru, but we took that out.  And it was never reliable anyway,
> because some pages were left there (invalidatepage failed).

I think we should try to fix invalidatepage instead, and just always
remove it from the LRU.

(If invalidatepage fails, we can just leave the page as an anonymous page
_off_ the LRU, and let whoever holds a reference to the page eventually
drop it, whatever).

> Anyway.  I have patches against 2.5.24, which work, which
> turn pagemap_lru_lock into an innermost, irq-safe lock.  If
> we get that in place then page_cache_release() from IRQ context
> is fine.

I'd _really_ really prefer to go the other way. I think this brokenness is
all from that one broken patch that removed the "remove from LRU".

And from what I can tell, that broken patch has no real point to it
anyway.

		Linus

