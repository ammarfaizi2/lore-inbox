Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbRGLQFo>; Thu, 12 Jul 2001 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbRGLQFe>; Thu, 12 Jul 2001 12:05:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9994 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266157AbRGLQFV>; Thu, 12 Jul 2001 12:05:21 -0400
Date: Thu, 12 Jul 2001 09:03:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] show_trace() module_end = 0?
In-Reply-To: <Pine.LNX.4.21.0107121631490.1934-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107120858380.6595-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jul 2001, Hugh Dickins wrote:
>
> show_trace() contains an erroneous line, introduced in 2.4.6-pre4,
> which disables trace on module text: appears to be from temporary
> testing, since code and comments for tracing module text remain.

It as actually disabled on purpose.

It's there because without it the backtrace is sometimes so full of crud
that it is almost impossible to read.

I chose to disable the module back-trace, because what we should _really_
do is to walk the vmalloc space and verify whether it's a valid address or
not. But as I don't use modules myself, I didn't have much incentive to do
so, or to test that it worked.

The simple "disable module backtraces" approach at least makes the normal
backtraces possible to read sanely (well, you still have the issue that
gcc often ends up leaving tons of empty stackslots around and those can
contain stale information, but that can't be fixed as easily).

		Linus

