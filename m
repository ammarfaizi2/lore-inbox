Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132470AbRDDSDc>; Wed, 4 Apr 2001 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132474AbRDDSDX>; Wed, 4 Apr 2001 14:03:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8736 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132470AbRDDSDJ>; Wed, 4 Apr 2001 14:03:09 -0400
Date: Wed, 4 Apr 2001 20:00:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Hubertus Franke <frankeh@us.ibm.com>,
        Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
Message-ID: <20010404200037.S20911@athlon.random>
In-Reply-To: <20010404191604.O20911@athlon.random> <200104041749.KAA74097@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104041749.KAA74097@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Wed, Apr 04, 2001 at 10:49:04AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 10:49:04AM -0700, Kanoj Sarcar wrote:
> Imagine that most of the program's memory is on node 1, it was scheduled
> on node 2 cpu 8 momentarily (maybe because kswapd ran on node 1, other
> higher priority processes took over other cpus on node 1, etc). 
> 
> Then, your patch will try to keep the process on node 2, which is not
> neccessarily the best solution. Of course, as I mentioned before, if
> you have a node local cache on node 2, that cache might have been warmed
> enough to make scheduling on node 2 a good option. 

Exactly it made it a good option, and more important this heuristic can
only improve performance if compared to the mainline scheduler.

Infact I tried to reschedule the task back to its original node and it dropped
performance, anyways I cannot say to have done an extensive research on that, I
believe if we take care of some more history of the node migration we may
understand it's right time to push it back to its original node but that was
not obvious and I wanted a simple solution to boost the performance under CPU
bound load to start with.

Andrea
