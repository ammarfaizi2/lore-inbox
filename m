Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbSIRRhI>; Wed, 18 Sep 2002 13:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267702AbSIRRhI>; Wed, 18 Sep 2002 13:37:08 -0400
Received: from holomorphy.com ([66.224.33.161]:28651 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267617AbSIRRhH>;
	Wed, 18 Sep 2002 13:37:07 -0400
Date: Wed, 18 Sep 2002 10:36:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918173653.GV3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <20020918164553.GB28202@holomorphy.com> <Pine.LNX.4.44.0209181932580.24794-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181932580.24794-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, William Lee Irwin III wrote:
>> The lockups I see range from hours to "it spun over the weekend, time to
>> pull the plug".

On Wed, Sep 18, 2002 at 07:36:00PM +0200, Ingo Molnar wrote:
> this can happen if there's a genuine PID space squeeze wrt. nr_threads -
> that is solved by adding Linus' suggestion to the PID allocator. I believe
> you saw that problem, not any inherent get_pid() algorithmic inefficiency.
> nevertheless we do lock up for 32 seconds if there are 32K PIDs allocated
> in a row and last_pid hits that range - regardless of pid_max. (Depending
> on the cache architecture it could take significantly more.)

There were only 10K tasks, with likely consecutively-allocated PID's,
and some minor background fork()/exit() activity, but there are more
offenders on the read side than get_pid() itself.

There is no question of PID space: the full 2^30 was configured in
the tests done after the PID space expansion. 


Bill
