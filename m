Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRKVUNY>; Thu, 22 Nov 2001 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281591AbRKVUNP>; Thu, 22 Nov 2001 15:13:15 -0500
Received: from [208.129.208.52] ([208.129.208.52]:48398 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281504AbRKVUNE>;
	Thu, 22 Nov 2001 15:13:04 -0500
Date: Thu, 22 Nov 2001 12:22:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, <linux-smp@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111221218150.1641-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Ingo Molnar wrote:

>
> the attached set-affinity-A1 patch is relative to the scheduler
> fixes/cleanups in 2.4.15-pre9. It implements the following two
> new system calls:
>
>  asmlinkage int sys_sched_set_affinity(pid_t pid, unsigned int mask_len,
>     unsigned long *new_mask_ptr);
>
>  asmlinkage int sys_sched_get_affinity(pid_t pid, unsigned int
>     *user_mask_len_ptr, unsigned long *user_mask_ptr);

I think that maybe it's better to have a new type :

typedef whatever-is-appropriate cpu_affinity_t;

with a set of macros :

CPU_AFFINITY_INIT(aptr)
CPU_AFFINITY_SET(aptr, n)
CPU_AFFINITY_ISSET(aprt, n)

so that we can simplify that interfaces :

asmlinkage int sys_sched_set_affinity(pid_t pid, cpu_affinity_t *aptr);
asmlinkage int sys_sched_get_affinity(pid_t pid, cpu_affinity_t *aptr);




- Davide


