Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTAGTS6>; Tue, 7 Jan 2003 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTAGTS6>; Tue, 7 Jan 2003 14:18:58 -0500
Received: from egil.codesourcery.com ([66.92.14.122]:6026 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S267611AbTAGTS4>; Tue, 7 Jan 2003 14:18:56 -0500
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Set TIF_IRET in more places
From: Zack Weinberg <zack@codesourcery.com>
Date: Tue, 07 Jan 2003 11:27:32 -0800
In-Reply-To: <20030107111905.GA949@bjl1.asuk.net> (Jamie Lokier's message of
 "Tue, 7 Jan 2003 11:19:05 +0000")
Message-ID: <87of6s3gm3.fsf@egil.codesourcery.com>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.2 (i386-pc-linux-gnu)
References: <87isx2dktj.fsf@egil.codesourcery.com>
	<20030107111905.GA949@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

> Zack Weinberg wrote:
>> Consider SA_RESTORER - there isn't a guarantee that user space will
>> use the same code as the kernel's trampoline.  glibc happens to, but
>> only because GDB has a hardwired idea of what a signal trampoline
>> looks like.  Of course, you could simply document that sigreturn() is
>> another of the system calls that must be made through int 0x80.
>
> Glibc must use the same code as the kernel's trampoline because of
> MD_FALLBACK_FRAME_STATE_FOR() in GCC's exception handling...  (or
> libgcc.so must change).
>
> It explicitly checks for the opcode sequences 0x58b877000000cd80 and
> 0xb8ad000000cd80 in order to unwind exception frames around a
> handled signal.  Ugly, isn't it?

We're open to better ideas ...

>> Tangentially, I've seen people claim that the trampoline ought to be
>> able to avoid entering the kernel, although I'm not convinced (how
>> does the signal mask get reset, otherwise?)
>
> Welcome to a wonderful if rather unsightly optimisation:
[...]

I would want to be very sure that this was actually a performance win
before implementing it, and since it requires data tables in user
space I don't see how it could possibly be done in the vsyscall page.

zw
