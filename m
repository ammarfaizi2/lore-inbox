Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319016AbSHMTNg>; Tue, 13 Aug 2002 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319024AbSHMTNg>; Tue, 13 Aug 2002 15:13:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6111 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319016AbSHMTNf>;
	Tue, 13 Aug 2002 15:13:35 -0400
Date: Tue, 13 Aug 2002 21:16:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131148340.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132111400.7951-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> The fact that the child doesn't want to send a signal to the parent on
> exit is a totally different matter, and should already be supported by
> just giving a zero signal number.

exit signal 0 is already being used and relied on by kmod - i originally
implemented it that way. In that case the child thread becomes a zombie
until the parent exits, and then it gets reparented to init. I did not
want to break any existing semantics (no matter how broken they appeared
to me) thus i introduced CLONE_DETACHED. But thinking about it, 'a zombie
staying around indefinitely' is not a semantics that it worth carrying too
far? But in case, if signal 0 is the preferred interface then i'm all for
it - this is not really a clone() property but an exit-signalling
property.

	Ingo

