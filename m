Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275915AbSIURgo>; Sat, 21 Sep 2002 13:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275917AbSIURgo>; Sat, 21 Sep 2002 13:36:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45224 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S275915AbSIURgo>;
	Sat, 21 Sep 2002 13:36:44 -0400
Date: Sat, 21 Sep 2002 19:49:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: quadratic behaviour
In-Reply-To: <Pine.LNX.4.44.0209210958080.2702-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209211940350.452-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Sep 2002, Linus Torvalds wrote:

> But the quadratic behaviour wrt processes clearly isn't fixed.
> Suggestions welcome (and we'll need to avoid the same quadratic
> behaviour wrt the threads when we expose them).

in the case of threads my plan is to use the pid alloction bitmap for
this. It slightly overestimates the pids because orphan sessions and pgrps
are included as well, but this should not be a problem because procfs also
does a pid lookup when the specific directory is accessed. This method is
inherently restartable, the pid bitmap pages are never freed, and it's the
most cache-compact representation of the sorted pidlist. And it can be
accessed lockless ...

	Ingo

