Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268378AbSIRRwM>; Wed, 18 Sep 2002 13:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268369AbSIRRvP>; Wed, 18 Sep 2002 13:51:15 -0400
Received: from holomorphy.com ([66.224.33.161]:37355 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268364AbSIRRvI>;
	Wed, 18 Sep 2002 13:51:08 -0400
Date: Wed, 18 Sep 2002 10:50:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918175055.GX3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <20020918173653.GV3530@holomorphy.com> <Pine.LNX.4.44.0209181958440.25303-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181958440.25303-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, William Lee Irwin III wrote:
>> There were only 10K tasks, with likely consecutively-allocated PID's,
>> and some minor background fork()/exit() activity, but there are more
>> offenders on the read side than get_pid() itself.
>> There is no question of PID space: the full 2^30 was configured in the
>> tests done after the PID space expansion.

On Wed, Sep 18, 2002 at 07:59:50PM +0200, Ingo Molnar wrote:
> oh. Well, there are a whole lot of other places in the unpatched kernel
> that iterate over every task. So with the patch applied, all these lockups
> go away?
> 	Ingo

Not quite all of them. top(1) takes out the machine by triggering calls
to get_pid_list(), which NMI oopses fork() and exit() on other cpus.


Bill
