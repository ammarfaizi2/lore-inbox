Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269811AbRHDGkN>; Sat, 4 Aug 2001 02:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269812AbRHDGkE>; Sat, 4 Aug 2001 02:40:04 -0400
Received: from [63.209.4.196] ([63.209.4.196]:21252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269811AbRHDGjz>; Sat, 4 Aug 2001 02:39:55 -0400
Date: Fri, 3 Aug 2001 23:37:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108040055090.11200-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108032330450.1193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001, Ben LaHaise wrote:
>
> Within reason.  I'm actually heading to bed now, so it'll have to wait
> until tomorrow, but it is fairly trivial to reproduce by dd'ing to an 8GB
> non-sparse file.  Also, duplicating a huge file will show similar
> breakdown under load.

Well, I've made a 2.4.8-pre4.

This one has marcelo's zone fixes, and my request suggestions. I'm writing
email right now with the 8GB write in the background, and unpacked and
patched a kernel. It's certainly not _fast_, but it's not too painful to
use either.  The 8GB file took 7:25 to write (including the sync), which
averages out to 18+MB/s. Which is, as far as I can tell, about the best I
can get on this 5400RPM 80GB drive with the current IDE driver (the
experimental IDE driver is supposed to do better, but that's not for
2.4.x)

An added advantage of doing the waiting in the request handling was that
this way it automatically balances reads against writes - writes cannot
cause reads to fail because they have separate request queue allocations.

Does it work reasonably under your loads?

		Linus

