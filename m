Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUBWSQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUBWSQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:16:59 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:3742 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261984AbUBWSPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:15:32 -0500
Message-ID: <403A4328.5010302@colorfullife.com>
Date: Mon, 23 Feb 2004 19:15:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: piggin@cyberone.com.au
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] fix shmat
References: <E1AvBNO-0004QF-00@bkwatch.colorfullife.com>
In-Reply-To: <E1AvBNO-0004QF-00@bkwatch.colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From the bitkeeper commit message queue:

>	
>	sys_shmat() need to be declared asmlinkage.  This causes breakage when we
>	actually get the proper prototypes into caller's scope.
>  
>
Why? sys_shmat is not a system call. Or at least there is a comment just 
before the implementation that this is not a syscall.
I think either the asmlinkage or the comment are wrong:
/*
 * Fix shmaddr, allocate descriptor, map shm, add attach descriptor to 
lists.
 *
 * NOTE! Despite the name, this is NOT a direct system call entrypoint. The

>  * "raddr" thing points to kernel space, and there has to be a wrapper around
>  * this.
>  */
>-long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
>+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
> {
> 	struct shmid_kernel *shp;
> 	unsigned long addr;
>

I'd propose to remove the asmlinkage and to move the prototype (without 
asmlinkage) back from syscalls.h to shm.h - what do you think?
--
    Manfred

