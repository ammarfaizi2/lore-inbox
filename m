Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTCQGxI>; Mon, 17 Mar 2003 01:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbTCQGxI>; Mon, 17 Mar 2003 01:53:08 -0500
Received: from holomorphy.com ([66.224.33.161]:60120 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261874AbTCQGxH>;
	Mon, 17 Mar 2003 01:53:07 -0500
Date: Sun, 16 Mar 2003 23:03:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
Message-ID: <20030317070334.GO20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <20030316213516.GM20188@holomorphy.com> <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, William Lee Irwin III wrote:
>> I'm heavily on the side of deterministic bounds here (these things trip
>> the NMI oopser, so if the bounds aren't deterministic, neither is
>> stability), so I favor manfred's proc_pid_readdir() algorithm.

On Mon, Mar 17, 2003 at 07:22:15AM +0100, Ingo Molnar wrote:
> no, the code in question here is worst-case O(nr_tasks). It is worst-case
> quadratic only if the number of syscalls done during a full 'ps' readdir()
> sequence is considered as well. This thing will never trigger the NMI
> oopser. And in the common-case it has constant overhead.

Hmm. I was under the (false) impression it filled as many as directory
entries as possible given count. Something else strange is going on then.

The NMI oopses are mostly decoded by hand b/c in-kernel (and other)
backtrace decoders can't do it automatically. I might have to generate
some fresh data, with some kind of hack (e.g. hand-coded NMI-based kind
of smp_call_function) to trace the culprit and not just the victim.
The victims were usually stuck in fork() or exit().


-- wli
