Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHaMtf>; Sat, 31 Aug 2002 08:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSHaMtf>; Sat, 31 Aug 2002 08:49:35 -0400
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:28351 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S317468AbSHaMte>; Sat, 31 Aug 2002 08:49:34 -0400
Date: Sat, 31 Aug 2002 14:53:54 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: pwaechtler@mac.com
cc: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues
In-Reply-To: <CDB36B91-BB99-11D6-B9F3-00039387C942@mac.com>
Message-ID: <Pine.GSO.4.40.0208311440520.7165-100000@ultra60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 29 Aug 2002 pwaechtler@mac.com wrote:

> I know that it's nowhere stated, but POSIX mqueues are perfectly
> designed to be
> implemented in userspace with locking facilities provided by the system.
> ...
> with proper locking. I am not very happy about the fact, that with
> futexes the whole
> cooperating system get stuck when 1 process crashes inside a critical
> region
> (yes, then your system is screwed anyway).
> BUT the messages are not copied between user- and kernelspace like they
> are
> in SysV  msgsnd.
Is coping between user and kernel spaces so bad? As you pointed
out there are problems with only user space implementation.

> POSIX mqueues have "kernel persistence", i.e. they live until
> mq_unlink() is called.
> They do not vanish with the creator on exit().
Yes. But I don't see what is wrong with our system? Our queues _don't_
vanish with creator exit. (Our add on to exit() (and fork) is to keep
track of processes that have opened mqueue. Then mq_unlink() can
postpone deleting queue to the time when it isn't opened by anyone)

> Without rlimits you can easily consume all available kernel memory (DoS)
> by creating
> a mqueue and filling it with garbage.
To this I answer in an answer to your next post :)

>
> When implemented in kernel space, you have to create a thread with the
> brand new
> sys_clone_startup (or whatever name it gets) as notification
> (SIGEV_THREAD) - which
> is SCOPE_SYSTEM, no control about this and not always what is desired.
I don't fully understand it. Can you explain it in more details?

Thanks

Krzysiek Benedyczak

