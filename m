Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVCONBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVCONBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVCONBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:01:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12909
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261209AbVCONAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:00:51 -0500
Date: Tue, 15 Mar 2005 14:00:46 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315130046.GK7699@opteron.random>
References: <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315112712.GA3497@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 12:27:12PM +0100, Ingo Molnar wrote:
> this combination of arguments i think tips the balance in favor of
> seccomp, but still, i hate the fact that the anti-ptrace sentiment was
> used as a vehicle to get this feature into the kernel.

Why should I use excuses to get this feature into the kernel if this
wasn't the best way to reach my goal? Do you think I'm shooting myself
in the foot and that I'd be better off using ptrace?

One other reason of using seccomp that you didn't mention is how simple
it is for me to code everything using seccomp (and this also makes me
much more confortable about its security, regardless of ptrace). Seccomp
is an arch indipendent API, ptrace is not.

It's not just the security of ptrace that is less desiderable, but it's
also the API itself that is much less desiderable, since it's so
lowlevel.

> which quite likely wont be provable in the foreseeable future).

Please mention a _single_ bug that could allow you to escape the seccomp
jail in linux since 2.4.0 on x86 and x86-64 (and with escape I don't
mean sniffing data with mmx not being backwards compatible, or f00f DoS,
I mean executing code into the host as user nobody). I'm not aware of a
_single_ seccomp bug that could allow you to escape the seccomp jail
since 2.4.0 and probably much earlier.

Either you answer the above or you may want to stop spreading FUD about
seccomp (and in turn about Cpushare security).

You know that a seccomp security bug is guaranteed to be a _major_
security bug for linux at large, not just for Cpushare, so I don't see
why you claim it's not provable to be secure, since what you're really
saying is that it's not provable that Linux is secure in multiuser
environment.

Personally I'm very confortable that linux security is ok in
read/write/signal/exit syscalls/irqs. At least as far as the software is
concerned.

It's not like there was no auditing, since those code paths are the most
heavily executed and if people go search into mremap is not because they
wouldn't get any benefit in exploiting read(2) or write(2) instead of
mremap. They look into mremap because they didn't find anything
expoitable in read/write.

There have been positive comments from people about seccomp not just for
my private project, so perhaps it will be used by others too.

In large grid environments security is important too, not just for
Cpushare. In a large grid environment if one of those nodes is
compromised by one user during his computations, this user may see and
alter the results for the other computations of the other users and at
least Cpushare is designed to detect and react to those conditions since
the first place.

Infact once I add trusted computing to Cpushare, it might become more
secure and reliable than a supercomputer for rent that is missing the
trusted computing in the hardware.

> technical comment: seccomp goes outside the audit/selinux framework,
> which i believe is a bug. Andrea?

I intentionally left it out of audit/selinux. To the less dependencies
it has on other parts of the kernel and the simpler it is, the better
IMHO. Seccomp should be fixed in stone, people shouldn't go hack on it
every day.
