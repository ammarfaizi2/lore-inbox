Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267302AbSIRQ3p>; Wed, 18 Sep 2002 12:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbSIRQ3p>; Wed, 18 Sep 2002 12:29:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33766 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267302AbSIRQ3m>;
	Wed, 18 Sep 2002 12:29:42 -0400
Date: Wed, 18 Sep 2002 18:41:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181835150.23619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> Give me one reason for why these two added lines aren't better than all
> the complexity we've discussed? I can pretty much _guarantee_ that it's
> faster, and it sure as hell is simpler. And all traditional uses that
> has less than a few thousand threads at most will never see the larger
> pids, so people can stare at "ps" output without going blind - the big
> pids start showing up only on boxes that might actually _need_ them.

i agree that this is okay, as an added mechanism. Nevertheless this does
not eliminate the 'box locks up for seconds' (or even minutes) situation.  
No matter how large the PID range, unless we make the PID range truly
infinite (64 or 128 bits ought to be enough), there's always going to be
PID allocation collision, and it's a frequent application pattern to
allocate threads in a row. We cannot stick our heads into the sand, a
O(N^2) algorithm will only get worse with time, the problem will not go
away magically.

and i dont think it adds any significant complexity. The fastpath is still
comparable, and another benefit of idtags is the elimination of
for_each_process() [and for_each_threads()] loops.

	Ingo

