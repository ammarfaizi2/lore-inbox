Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268557AbTCCQ3i>; Mon, 3 Mar 2003 11:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbTCCQ3i>; Mon, 3 Mar 2003 11:29:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64133 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268557AbTCCQ3a>; Mon, 3 Mar 2003 11:29:30 -0500
Date: Mon, 3 Mar 2003 11:42:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: ChristopherHuhn <c.huhn@gsi.de>
cc: linux-kernel@vger.kernel.org, linux-smp <linux-smp@vger.kernel.org>,
       support-gsi@credativ.de
Subject: Re: Kernel Bug at spinlock.h ?!
In-Reply-To: <3E637CDC.3030409@GSI.de>
Message-ID: <Pine.LNX.3.95.1030303113729.23039A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, ChristopherHuhn wrote:

> Hi,
> 
> I'm sorry I didn't know about ksymoops as I'm not experienced with 
> kernel bugs yet.
> 
> Richard B. Johnson wrote:
> 
> >The "Re: Kernel Bug at spinlock.h ?!" is an eye-catcher because this
> >inline code cannot have any bugs or you wouldn't even have booted.
> >
> I think this is the code, that produced the BUG message:
> 
> static inline void spin_unlock(spinlock_t *lock)
> {
>         char oldval = 1;
> #if SPINLOCK_DEBUG
>         if (lock->magic != SPINLOCK_MAGIC)
>                 BUG();
> ...
> 
> The oops occured after an uptime of about 50 hours.
> 
> I just discovered the following messages in the syslog, right before 
> that oops (I never found any kernel oops logs in the syslog until now ...):
> 
> Feb 27 20:51:37 lxb039 kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000
> Feb 27 20:51:37 lxb039 kernel:  printing eip:
> Feb 27 20:51:37 lxb039 kernel: 00000000
> Feb 27 20:51:37 lxb039 kernel: *pde = 00000000
> Feb 27 20:51:37 lxb039 kernel: Oops: 0000
> Feb 27 20:51:37 lxb039 kernel: CPU:    3
> Feb 27 20:51:37 lxb039 kernel: EIP:    0010:[msr_exit+0/24]    Not tainted
> Feb 27 20:51:37 lxb039 kernel: EFLAGS: 00010246
> Feb 27 20:51:37 lxb039 kernel: eax: fffffffe   ebx: f1857cb0   ecx: 
> 00000002   edx: 00000008
> Feb 27 20:51:37 lxb039 kernel: esi: fffffff5   edi: f1857cb0   ebp: 
> f1857c90   esp: f1857c84
> Feb 27 20:51:37 lxb039 kernel: ds: 0018   es: 0018   ss: 0018
> Feb 27 20:51:37 lxb039 kernel: Process sh (pid: 29359, stackpage=f1857000)
> Feb 27 20:51:37 lxb039 kernel: Stack: f1857cb0 f1857ca8 00000000 
> f1857d38 c02a8ff1 f1857cb0 f1857d58 f1856000
> Feb 27 20:51:37 lxb039 kernel:        00000001 fffffefd ffffffff 
> 00000000 00000000 00000000 00000000 00000000
> Feb 27 20:51:37 lxb039 kernel:        00000000 00000000 fffffffe 
> 00000000 00000003 f1857da8 f1857d9c 00000000
> Feb 27 20:51:38 lxb039 kernel: Call Trace:    [rpc_call_sync+121/164] 
> [rpc_run_timer+0/240] [nfs3_rpc_wrapper+54/124] [nfs3_proc_lookup
> +194/340] [nfs_lookup+122/204]
> Feb 27 20:51:38 lxb039 kernel:   [dput+27/464] 
> [link_path_walk+2940/3200] [in_group_p+32/40] [vfs_permission+121/248] 
> [d_alloc+25/476]
> [real_lookup+169/360]
> Feb 27 20:51:38 lxb039 kernel:   [link_path_walk+2425/3200] 
> [path_walk+29/36] [path_lookup+30/44] [__user_walk+45/72] [sys_stat64+26/11
> 2] [sys_close+115/140]
> Feb 27 20:51:38 lxb039 kernel:   [system_call+51/56]
> Feb 27 20:51:38 lxb039 kernel:
> Feb 27 20:51:38 lxb039 kernel: Code:  Bad EIP value.
> 
> 
> Looks like a NFS problem, huh?

No. It looks like something got corrupted so a call occurred to
nonexistant code.

If you have two RAM sticks, swap them. Otherwise, do something to
change your RAM configuration. There is something wrong in some
RAM area that is corrupting code or pointers to code. It could also
be that 100 MHz RAM is being used at 130 MHz, etc.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


