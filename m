Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWAOE1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWAOE1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWAOE1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:27:36 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:16303
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751021AbWAOE1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:27:36 -0500
Date: Sat, 14 Jan 2006 20:24:49 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060115042449.GA9871@gnuppy.monkey.org>
References: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 06:25:36PM +0100, Esben Nielsen wrote:
> So how many locks do we have to worry about? Two.
> One for locking the lock. One for locking various PI related data on the
> task structure, as the pi_waiters list, blocked_on, pending_owner - and
> also prio.
> Therefore only lock->wait_lock and sometask->pi_lock will be locked at the
> same time. And in that order. There is therefore no spinlock deadlocks.
> And the code is simpler.

Ok, got a question. How do deal with the false reporting and handling of
a lock circularity window involving the handoff of task A's BKL to another
task B ? Task A is blocked trying to get a mutex owned by task B, task A
is block B since it owns BKL which task B is contending on. It's not a
deadlock since it's a hand off situation.

I didn't see any handling of this case in the code and I was wondering
if the traversal logic you wrote avoids this case as an inherent property
and I missed that stuff ?

bill

