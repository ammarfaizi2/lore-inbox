Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbSIRRZz>; Wed, 18 Sep 2002 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbSIRRZy>; Wed, 18 Sep 2002 13:25:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4251 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267508AbSIRRZw>;
	Wed, 18 Sep 2002 13:25:52 -0400
Date: Wed, 18 Sep 2002 19:38:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44L.0209181358470.1519-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209181936430.24794-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Rik van Riel wrote:

> Agreed, you're right there.  On the other hand, walking the threads
> _once_ will take 1.5 minutes on a 500 MHz PII (according to Ingo's
> measurements).
> 
> That's about 18 times the timeout for the NMI oopser and will cause
> people real trouble.

we could fix it to 'just' lock up but still enable interrupts so that the
NMI oopser does not trigger. (we'd also have to be careful to never
write-lock the tasklist lock with IRQs disabled.) It's still a pretty lame
behavior from an OS me thinks ...

	Ingo

