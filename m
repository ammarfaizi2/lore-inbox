Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbTIBIhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTIBIhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:37:32 -0400
Received: from hera.kernel.org ([63.209.29.2]:36517 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263602AbTIBIhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:37:31 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] might_sleep() improvements
Date: Tue, 02 Sep 2003 01:36:51 -0700
Organization: OSDL
Message-ID: <bj1kr3$a2g$1@build.pdx.osdl.net>
References: <20030902075145.GA12817@sfgoth.com> <3F545175.1080505@cyberone.com.au>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1062491812 10320 172.20.1.2 (2 Sep 2003 08:36:52 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 2 Sep 2003 08:36:52 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> I think these should be pushed down to where the sleeping
> actually happens if possible.

No, that ends up doing the wrong thing for most of the really common cases.

In particular, most of the memory allocation functions very seldom actually
sleep. After all, they'll find plenty of free memory (or easily freeable
memory) without having to wait for any pageouts or anything like that.

Yet the bug is there - the call _could_ have slept.

So "might_sleep()" really does what the name suggests: it is used to say
that a particular case _may_ sleep, even if it ends up being unlikely.

Because what we're after is not a bug actually happening, but a latent bug
that has been hidden by the fact that it happens so rarely in practice.

This is why "might_sleep()" should happen as early as possible, and not
get pushed down.

                Linus
