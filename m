Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSIZPQN>; Thu, 26 Sep 2002 11:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbSIZPQN>; Thu, 26 Sep 2002 11:16:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64395 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261377AbSIZPQM>;
	Thu, 26 Sep 2002 11:16:12 -0400
Date: Thu, 26 Sep 2002 17:27:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <200209261501.g8QF1pc02251@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209261712420.20778-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Linus Torvalds wrote:

> This patch seems trivially broken by having two futexes on the same
> page.  When the first futex removes itself, it will clear the sticky
> bit, even though the other futex is still pinning the same page.

sigh. And we cannot even properly detect which unpin_page() was the last
unpinning of the page - there can be so many other reasons a page's count
is elevated. And keeping a page sticky forever is no solution either, the
number of sticky pages would increase significantly, causing real fork()
problems.

> Trust me, you'll have to use the page list approach.

yeah, will try that now. I'm a bit worried about the mandatory cross-CPU
TLB flushes though.

	Ingo

