Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292308AbSBUCFF>; Wed, 20 Feb 2002 21:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292309AbSBUCE4>; Wed, 20 Feb 2002 21:04:56 -0500
Received: from zok.sgi.com ([204.94.215.101]:11227 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292308AbSBUCEv>;
	Wed, 20 Feb 2002 21:04:51 -0500
Date: Wed, 20 Feb 2002 18:04:49 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
cc: Erich Focht <focht@ess.nec.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for
 non-current tasks
In-Reply-To: <20020220173242.2BDF.K-SUGANUMA@mvj.biglobe.ne.jp>
Message-ID: <Pine.SGI.4.21.0202201757150.566479-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Kimio Suganuma wrote:
> 
> CPU hotplug needs to change cpus_allowed in definite time.
> When a process is sleeping for 100000 seconds, how can we offline
> a CPU the process belongs?

Good - I figured I'd hear from you on this - thanks.

Are you thinking "definite time" on the order of a second?
I presume you don't require millisecond response time, and that
minute response time would be too slow, right?

And just brainstorming ... if a process is sleeping for a long
time, and the last cpu it executed on is being taken offline,
what need is there to wake up the process?  Let the process
stay asleep, and find it a new home when it wakes up for other
reasons.

In other words, perhaps  the goal of having the smallest,
simplest, least intrusive, most clearly correct code is more
important here than waking up a process just to tell it that
it's last cpu went offline.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

