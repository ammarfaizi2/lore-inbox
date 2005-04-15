Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVDOXl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVDOXl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVDOXl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:41:57 -0400
Received: from fmr19.intel.com ([134.134.136.18]:5267 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262356AbVDOXlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:41:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16992.20513.551920.826472@sodium.jf.intel.com>
Date: Fri, 15 Apr 2005 16:37:05 -0700
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, <inaky@linux.intel.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: FUSYN and RT
In-Reply-To: <20050415225137.GA23222@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	<1113352069.6388.39.camel@dhcp153.mvista.com>
	<1113407200.4294.25.camel@localhost.localdomain>
	<20050415225137.GA23222@nietzsche.lynx.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Bill Huey (hui) <bhuey@lnxw.com> writes:

> Ok, I've been thinking about these issues and I believe there are a
> number of misunderstandings here. The user and kernel space mutexes
> need to be completely different implementations. I'll have more on
> this later.

> First of all, priority transitivity should be discontinuous at the
> user/kernel space boundary, but be propagated by the scheduler, via
> an API or hook, upon a general priority boost to the thread in
> question.

This is not necessarily true. My temperature-regulating thread should
be able to promote a task so it works around priority invertion, no
matter if they are sharing a kernel or user space lock. 

By following your method, the pi engine becomes unnecesarily complex;
you have actually two engines following two different propagation
chains (one kernel, one user). If your mutexes/locks/whatever are the
same with a different cover, then you can simplify the whole
implementation by leaps.

> With all of that in place, you do a couple of things for the mutex
> implementation. First, you convert as much code of the current RT
> mutex code to be type polymorphic as you can:

> ...

> I'd apply these implementation ideas across both mutexes, but keep
> the individual mutexes functionality distinct. I look at this
> problem from more of a reusability perspective than anything else.
 
You are talking of what is implemented in fusyn already; the only
differences are that (a) I don't use macros, but funcition pointers
(mutex ops) and (b) transitivity across user/kernel space is allowed.

> There will be problems trying to implement a Posix read/write lock

As long as the concept of rwlock allows for it to have multiple owners
(read locks need to have them), the procedure is mostly the
same. However, this not being POSIX, nobody (yet) has asked for it.

-- 

Inaky

