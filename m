Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRCWLGk>; Fri, 23 Mar 2001 06:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCWLGa>; Fri, 23 Mar 2001 06:06:30 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:56074 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130532AbRCWLGP>;
	Fri, 23 Mar 2001 06:06:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Junfeng Yang <yjf@stanford.edu>
cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 4 warnings in kernel/module.c 
In-Reply-To: Your message of "Fri, 23 Mar 2001 02:41:40 -0800."
             <Pine.GSO.4.31.0103230236500.3192-100000@epic8.Stanford.EDU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Mar 2001 22:05:28 +1100
Message-ID: <18150.985345528@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001 02:41:40 -0800 (PST), 
Junfeng Yang <yjf@stanford.edu> wrote:
>Hi, we modified the block checker and run it again on linux 2.4.1. (The
>block checker flags an error when blocking functions are called with
>either interrupts disabled or a spin lock held. )
>
>It gave us 4 warnings in kernel/module.c. Because we are unaware of the
>contexts where these functions are called, we are not sure if these 4
>warnings are real errors or false positives. Please help us to verify them
>or show that they are false positives.

All false positives.  The big kernel lock is a special case, you are
allowed to sleep while holding that lock.  See release_kernel_lock()
and reacquire_kernel_lock() in sched().

