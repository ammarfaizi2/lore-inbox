Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSIRMoH>; Wed, 18 Sep 2002 08:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbSIRMoG>; Wed, 18 Sep 2002 08:44:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35021 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266480AbSIRMoG>;
	Wed, 18 Sep 2002 08:44:06 -0400
Date: Wed, 18 Sep 2002 14:56:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918123206.GA14595@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209181452050.19672-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Andries Brouwer wrote:

> I still don't understand the current obsession with this stuff. It is
> easy to have pid_max 2^30 and a fast algorithm that does not take any
> more kernel space.

it's only an if(unlikely()) branch in a 1:4096 slowpath to handle this, so
why not? If it couldnt be done sanely then i wouldnt argue about this, but
look at the code, it can be done cleanly and with very low cost.

> It seems to me you are first creating an unrealistic and unfavorable
> situation (put pid_max at some artificially low value, [...]

we want the default to be low, so that compatibility with the older SysV
APIs is preserved. Also, why use a 128K bitmap to handle 1 million PIDs on
a system that has at most 1000 tasks running? I'd rather use an algorithm
that scales well from low pid_max to a larger pid_max as well.

> Please leave pid_max large.

why? For most desktop systems even 32K PIDs is probably too high. A large
pid_max only increases the RAM footprint. (well not under the current
allocation scheme but still.)

	Ingo

