Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319057AbSHMThU>; Tue, 13 Aug 2002 15:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319077AbSHMThU>; Tue, 13 Aug 2002 15:37:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26884 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319057AbSHMThT>; Tue, 13 Aug 2002 15:37:19 -0400
Date: Tue, 13 Aug 2002 12:43:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208132111400.7951-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131241550.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> exit signal 0 is already being used and relied on by kmod - i originally
> implemented it that way. In that case the child thread becomes a zombie
> until the parent exits, and then it gets reparented to init. I did not
> want to break any existing semantics (no matter how broken they appeared
> to me) thus i introduced CLONE_DETACHED. But thinking about it, 'a zombie
> staying around indefinitely' is not a semantics that it worth carrying too
> far?

I think it makes more sense to say that since there was no notification of 
the parent, we should just reparent at that point.

 But in case, if signal 0 is the preferred interface then i'm all for
> it - this is not really a clone() property but an exit-signalling
> property.

Right. I think that it makes more sense to do it that way. Clearly the 
parent doesn't care about the exit if the signal is zero.

		Linus

