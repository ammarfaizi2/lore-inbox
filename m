Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318171AbSHDTCT>; Sun, 4 Aug 2002 15:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSHDTCT>; Sun, 4 Aug 2002 15:02:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22800 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318171AbSHDTCT>; Sun, 4 Aug 2002 15:02:19 -0400
Date: Sun, 4 Aug 2002 12:05:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Hans Reiser <reiser@namesys.com>, Andreas Gruenbacher <agruen@suse.de>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
In-Reply-To: <Pine.LNX.4.44L.0208041555500.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208041202390.10314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Aug 2002, Rik van Riel wrote:
> 
> > In particular, it is useless for the sub-caches to try to maintain their
> > own LRU lists and their own accessed bits. But that doesn't mean that
> > they can _act_ as if they updated their own accessed bits, while really
> > just telling the page-based thing that that page is active.
> 
> I'm not sure I agree with this.  For eg. the dcache you will want
> to reclaim the less used entries on a page even if there are a few
> very intensely used entries on that page.

True in theory, but I doubt you will see it very much in practice. 

Most of the time when you want to free dentries, it is because you have a 
_ton_ of them. 

The fact that some will look cold even if they aren't should not matter 
that much statistically.

Yah, it's a guess. We can test it.

		Linus

