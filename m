Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281821AbRKVXrk>; Thu, 22 Nov 2001 18:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281819AbRKVXrb>; Thu, 22 Nov 2001 18:47:31 -0500
Received: from ns01.netrox.net ([64.118.231.130]:7860 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281818AbRKVXrO>;
	Thu, 22 Nov 2001 18:47:14 -0500
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 22 Nov 2001 18:45:51 -0500
Message-Id: <1006472754.1336.0.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 03:59, Ingo Molnar wrote:

> the attached set-affinity-A1 patch is relative to the scheduler
> fixes/cleanups in 2.4.15-pre9. It implements the following two
> new system calls: [...]

Ingo, I like your implementation, particularly the use of the
cpu_online_map, although I am not sure all arch's implement it yet.  I
am curious, however, what you would think of using a /proc interface
instead of a set of syscalls ?

Ie, we would have a /proc/<pid>/cpu_affinity which is the same as your
`unsigned long * user_mask_ptr'.  Reading and writing of the proc
interface would correspond to your get and set syscalls.  Besides the
sort of relevancy and useful abstraction of putting the affinity in the
procfs, it eliminates any sizeof(cpus_allowed) problem since the read
string is the size in characters of cpus_allowed.

I would use your syscall code, though -- just reimplement it as a procfs
file. This would mean adding a proc_write function, since the _actual_
procfs (the proc part) only has a read method, but that is simple.

Thoughts?

	Robert Love

