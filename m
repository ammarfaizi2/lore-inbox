Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285247AbRLFWOH>; Thu, 6 Dec 2001 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285249AbRLFWNr>; Thu, 6 Dec 2001 17:13:47 -0500
Received: from ns.suse.de ([213.95.15.193]:21519 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285247AbRLFWNl>;
	Thu, 6 Dec 2001 17:13:41 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <20011206110713.A8404@cox.rr.com.suse.lists.linux.kernel> <3C0FD955.4510B738@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Dec 2001 23:13:40 +0100
In-Reply-To: Andrew Morton's message of "6 Dec 2001 22:03:56 +0100"
Message-ID: <p73r8q86lpn.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:
> 
> The fact that you get the same throughput on each platform with
> the block I/O part of the test indicates that the hardware and
> kernel are OK, but the C library is broken.

The usual difference is if you have a pthreads capable C library
or not. For newer glibc bonnie++ should definitely use 
putc_unlocked(); otherwise it'll eat lock overhead for each character
to take the FILE lock. 

As far as I can see bonnie++ doesn't use putc_unlocked, but putc.

With libc5 it likely would magically get a lot faster @)

-Andi
