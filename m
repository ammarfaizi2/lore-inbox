Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265913AbSKBKCP>; Sat, 2 Nov 2002 05:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265916AbSKBKCP>; Sat, 2 Nov 2002 05:02:15 -0500
Received: from ns.suse.de ([213.95.15.193]:39181 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265913AbSKBKCO>;
	Sat, 2 Nov 2002 05:02:14 -0500
To: Dipankar Sarma <woofwoof@hathway.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dcache_rcu [performance results]
References: <20021030161912.E2613@in.ibm.com.suse.lists.linux.kernel> <20021031162330.B12797@in.ibm.com.suse.lists.linux.kernel> <3DC32C03.C3910128@digeo.com.suse.lists.linux.kernel> <20021102144306.A6736@dikhow.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Nov 2002 11:08:44 +0100
In-Reply-To: Dipankar Sarma's message of "2 Nov 2002 10:21:23 +0100"
Message-ID: <p734rb0s2qb.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <woofwoof@hathway.com> writes:
> 
> I should add that this is a general trend we see in all workloads
> that do a lot of open/closes and so much so that performance is very
> sensitive to how close to / your application's working directory
> is. You would get much better system time if you compile a kernel
> in /linux as compared to say /home/fs01/users/akpm/kernel/linux ;-)

That's interesting. Perhaps it would make sense to have a fast path
that just does a string match of the to be looked up path to a cached copy 
of cwd and if it matches works as if cwd was the root. Would need to be 
careful with chroot where cwd could be outside the root and clear the
cached copy in this case. Then you could avoid all the locking overhead
for directories above your cwd if you stay in there.

-Andi
