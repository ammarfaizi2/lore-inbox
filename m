Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131404AbRCWT6B>; Fri, 23 Mar 2001 14:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131395AbRCWT5v>; Fri, 23 Mar 2001 14:57:51 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:63735 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131363AbRCWT5q>; Fri, 23 Mar 2001 14:57:46 -0500
Date: Fri, 23 Mar 2001 11:56:45 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 4 warnings in kernel/module.c 
In-Reply-To: <18150.985345528@ocs3.ocs-net>
Message-ID: <Pine.GSO.4.31.0103231154170.24288-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Keith Owens wrote:

> On Fri, 23 Mar 2001 02:41:40 -0800 (PST),
> Junfeng Yang <yjf@stanford.edu> wrote:
> >Hi, we modified the block checker and run it again on linux 2.4.1. (The
> >block checker flags an error when blocking functions are called with
> >either interrupts disabled or a spin lock held. )
> >
> >It gave us 4 warnings in kernel/module.c. Because we are unaware of the
> >contexts where these functions are called, we are not sure if these 4
> >warnings are real errors or false positives. Please help us to verify them
> >or show that they are false positives.
>
> All false positives.  The big kernel lock is a special case, you are
> allowed to sleep while holding that lock.  See release_kernel_lock()
> and reacquire_kernel_lock() in sched().

Thanks for pointing this out. We'll modify the checker again and remove
"lock_kernel" from the patterns.

