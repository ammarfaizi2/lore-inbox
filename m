Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288142AbSACCf5>; Wed, 2 Jan 2002 21:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287970AbSACCft>; Wed, 2 Jan 2002 21:35:49 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:24851 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288142AbSACCfb>; Wed, 2 Jan 2002 21:35:31 -0500
Date: Wed, 2 Jan 2002 18:39:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Steinar Hauan <hauan@cmu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: smp cputime issues (patch request ?)
In-Reply-To: <20020103022705.A3163@werewolf.able.es>
Message-ID: <Pine.LNX.4.40.0201021836420.1034-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, J.A. Magallon wrote:

>
> On 20020102 Steinar Hauan wrote:
> >hello,
> >
> >  we are encountering some weird timing behaviour on our linux cluster.
> >
> >  specifically: when running 2 copies of selected programs on a
> >  dual-cpu system, the cputime reported for each process is up to 25%
> >  higher than when the processes are run on their own. however, if running
> >  two different jobs on the same machine, both complete with a cputime
> >  equal to when run individually. sample timing output attached.
> >
>
> Cache pollution problems ?
>
> As I understand, your job does not use too much memory, does no IO,
> just linear algebra (ie, matrix-times-vector or vector-plus-vector
> operations). That implies sequential access to matrix rows and vectors.
>
> I will try to guess...
>
> Problem with linux scheduler is that processes are bounced from one CPU
> to the other, they are not tied to one, nor try to stay in the one they
> start, even if there is no need for the cpu to do any other job.
> On an UP box, the cache is useful to speed up your matrix-vector ops.
> One process on a 2-way box, just bounces from one cpu to the other,
> and both caches are filled with the same data. Two processes on two
> cpus, and everytime they 'swap' between cpus they trash the previous
> cache for the other job, so when it returs it has no data cached.
>
> Solutions:
> - cpu affinity patch: manually tie processes to cpus
> - new scheduler: a patch for the scheduler that tries to
>   keep processes on the cpu they start was talked about on the list.
>
> I would prefer the second option. I think it is named something like
> 'multiqueue scheduler', and its 'father' could be (AFAIR) Davide Libezni.
> Look for that on the list archives. Problem: I think the patch only
> exists for 2.5.

The patch is here :

http://www.xmailserver.org/linux-patches/xsched-2.5.2-pre4-0.58.diff

I did not read the whole thread but if your two tasks are strictly cpu
bound and you've two cpus, you should not have problems even with the
current scheduler.




- Davide


