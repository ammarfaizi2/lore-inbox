Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSBUVZ7>; Thu, 21 Feb 2002 16:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292779AbSBUVZk>; Thu, 21 Feb 2002 16:25:40 -0500
Received: from rj.sgi.com ([204.94.215.100]:38556 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S292778AbSBUVZf>;
	Thu, 21 Feb 2002 16:25:35 -0500
Date: Thu, 21 Feb 2002 13:25:32 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Erich Focht <efocht@ess.nec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech <lse-tech@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.LNX.4.33.0202211723520.14005-100000@localhost.localdomain>
Message-ID: <Pine.SGI.4.21.0202211313200.561412-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> The concept is the following: there are new per-CPU
> system threads (so-called migration threads) that handle
> a per-runqueue 'migration queue'.

Thanks, Ingo.

Could you, or some other kind soul who understands this, to
explain why the following alternative for migrating proceses
currently running on some other cpu wouldn't have been better
(simpler and sufficient):

    - add another variable to the task_struct, say "eviction_notice"
    - when it comes time to tell a process to migrate, set this
	eviction_notice (and then continue without waiting)
    - rely on code that fires each time slice on the cpu currently
        hosting the evicted process to notice the eviction notice and
	serve it (migrate the process instead of giving it yet another
	slice).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

