Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUBWS3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUBWS3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:29:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:2523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261987AbUBWS3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:29:19 -0500
Date: Mon, 23 Feb 2004 10:21:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] fix shmat
Message-Id: <20040223102135.2f878f93.rddunlap@osdl.org>
In-Reply-To: <403A4328.5010302@colorfullife.com>
References: <E1AvBNO-0004QF-00@bkwatch.colorfullife.com>
	<403A4328.5010302@colorfullife.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 19:15:04 +0100 Manfred Spraul <manfred@colorfullife.com> wrote:

|  From the bitkeeper commit message queue:
| 
| >	
| >	sys_shmat() need to be declared asmlinkage.  This causes breakage when we
| >	actually get the proper prototypes into caller's scope.
| >  
| >
| Why? sys_shmat is not a system call. Or at least there is a comment just 
| before the implementation that this is not a syscall.
| I think either the asmlinkage or the comment are wrong:
| /*
|  * Fix shmaddr, allocate descriptor, map shm, add attach descriptor to 
| lists.
|  *
|  * NOTE! Despite the name, this is NOT a direct system call entrypoint. The
| 
| >  * "raddr" thing points to kernel space, and there has to be a wrapper around
| >  * this.
| >  */
| >-long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
| >+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
| > {
| > 	struct shmid_kernel *shp;
| > 	unsigned long addr;
| >
| 
| I'd propose to remove the asmlinkage and to move the prototype (without 
| asmlinkage) back from syscalls.h to shm.h - what do you think?

It's not a syscall AFAICT.
It's not listed in any .S files, like most syscalls are.
However, it is listed in kernel/sys.c as a "cond_syscall",
which I'm guessing is incorrect.

I'd like to rename it so that it doesn't begin with "sys_".

--
~Randy
