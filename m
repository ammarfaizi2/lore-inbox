Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319022AbSHMUgW>; Tue, 13 Aug 2002 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319028AbSHMUgW>; Tue, 13 Aug 2002 16:36:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14856 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319022AbSHMUgV>; Tue, 13 Aug 2002 16:36:21 -0400
Date: Tue, 13 Aug 2002 13:42:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208132203120.11034-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131337570.1270-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> a quick workaround is in the attached patch but it's an incorrect fix:  
> kmod does not want to receive any signals from the helper thread for a
> reason - it can be executed from any process context, correct? I dont know
> how this should be fixed.

Hmm.. The workarounds make me suspect that maybe your right interface was 
the right one after all. 

This interface has the advantage that the exit() path for this kind of
child has _zero_ context switching overhead etc, so I do like it. Although
I get this feeling that the release_task() issue would be much more
cleanly handled by just letting schedule_tail() do the last "put_task()",
the same way we handle the pending MM issue..

Maybe the best approach is to really mix the two approaches: a separate
clone flag to say that the parent really doesn't care about waiting for
the thing, but do it this way (so that init doesn't have to spend time
cleaning up either).

		Linus

