Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbQLJBnm>; Sat, 9 Dec 2000 20:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132700AbQLJBnd>; Sat, 9 Dec 2000 20:43:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29198 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132672AbQLJBnQ>; Sat, 9 Dec 2000 20:43:16 -0500
Date: Sat, 9 Dec 2000 17:11:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Alexander Viro <viro@math.psu.edu>, Andries Brouwer <aeb@veritas.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <Pine.LNX.3.96.1001209221321.19153A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10012091710250.1177-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Mikulas Patocka wrote:
> 
> I did a test. I disabled readahead except for reading all 4 buffers in
> map_4sectors.
> 
> I observed 14% slowdown on walking directories with find and 4% slowdown
> on grepping one my working directory (10M, 281 files).
> 
> If you can't make it otherwise you can rip readahead out. If there is a
> possibility to keep it, it would be better.

The absolutely best thing would be to keep the directories in the page
cache. At which point the whole issue becomes pretty moot and we could use
the page-cache readahead code. Which gets the end right, and can handle
stuff that isn't physically contiguous on disk.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
