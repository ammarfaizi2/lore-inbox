Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265929AbSKBKvc>; Sat, 2 Nov 2002 05:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265930AbSKBKvc>; Sat, 2 Nov 2002 05:51:32 -0500
Received: from [202.88.171.30] ([202.88.171.30]:5770 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S265929AbSKBKvb>;
	Sat, 2 Nov 2002 05:51:31 -0500
Date: Sat, 2 Nov 2002 16:24:19 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dcache_rcu [performance results]
Message-ID: <20021102162419.A7894@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021030161912.E2613@in.ibm.com.suse.lists.linux.kernel> <20021031162330.B12797@in.ibm.com.suse.lists.linux.kernel> <3DC32C03.C3910128@digeo.com.suse.lists.linux.kernel> <20021102144306.A6736@dikhow.suse.lists.linux.kernel> <p734rb0s2qb.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p734rb0s2qb.fsf@oldwotan.suse.de>; from ak@suse.de on Sat, Nov 02, 2002 at 11:08:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:08:44AM +0100, Andi Kleen wrote:
> Dipankar Sarma <woofwoof@hathway.com> writes:
> > 
> > I should add that this is a general trend we see in all workloads
> > that do a lot of open/closes and so much so that performance is very
> > sensitive to how close to / your application's working directory
> > is. You would get much better system time if you compile a kernel
> > in /linux as compared to say /home/fs01/users/akpm/kernel/linux ;-)
> 
> That's interesting. Perhaps it would make sense to have a fast path
> that just does a string match of the to be looked up path to a cached copy 
> of cwd and if it matches works as if cwd was the root. Would need to be 
> careful with chroot where cwd could be outside the root and clear the
> cached copy in this case. Then you could avoid all the locking overhead
> for directories above your cwd if you stay in there.

Well, on second thoughts I can't see why the path length for pwd
would make difference for kernel compilation - it uses relative
path and for path lookup, if the first character is not '/', then
lookup is done relative to current->fs->pwd. I will do some more
benchmarking on and verify.

I did get inputs from Troy Wilson who does specweb measurements
that the path name length of the location of the served files
make a difference. I presume his webserver setup used full path names.

Thanks
Dipankar
