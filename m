Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbSIRRXp>; Wed, 18 Sep 2002 13:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267360AbSIRRXp>; Wed, 18 Sep 2002 13:23:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36331 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267312AbSIRRXo>;
	Wed, 18 Sep 2002 13:23:44 -0400
Date: Wed, 18 Sep 2002 19:36:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918164553.GB28202@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209181932580.24794-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, William Lee Irwin III wrote:

> > i agree that this is okay, as an added mechanism. Nevertheless this does
> > not eliminate the 'box locks up for seconds' (or even minutes) situation.  
> 
> The lockups I see range from hours to "it spun over the weekend, time to
> pull the plug".

this can happen if there's a genuine PID space squeeze wrt. nr_threads -
that is solved by adding Linus' suggestion to the PID allocator. I believe
you saw that problem, not any inherent get_pid() algorithmic inefficiency.

nevertheless we do lock up for 32 seconds if there are 32K PIDs allocated
in a row and last_pid hits that range - regardless of pid_max. (Depending
on the cache architecture it could take significantly more.)

	Ingo

