Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319133AbSHMSp7>; Tue, 13 Aug 2002 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319134AbSHMSp7>; Tue, 13 Aug 2002 14:45:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319133AbSHMSp5>; Tue, 13 Aug 2002 14:45:57 -0400
Date: Tue, 13 Aug 2002 11:52:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131121310.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208131148340.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:
> 
> So add the capability to mark the child for proper exit semantics.

Actually, this has nothing at all to do with exit(). 

The same thing comes up when you want to do an execve() (yes, I know 
pthreads doesn't support a thread starting another process, but the fact 
that pthreads is broken is no excuse for broken interfaces).

If the parent needs to be notified that the stack slot is no longer in 
use, it needs to happen for execve() too, not just exit().

In fact, I'd say that this thing is tied in to "mm_release()", not
"exit()".

The fact that the child doesn't want to send a signal to the parent on 
exit is a totally different matter, and should already be supported by 
just giving a zero signal number.

			Linus

