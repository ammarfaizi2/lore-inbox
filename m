Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278743AbRJVMD3>; Mon, 22 Oct 2001 08:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278742AbRJVMDT>; Mon, 22 Oct 2001 08:03:19 -0400
Received: from zero.aec.at ([195.3.98.22]:55566 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278746AbRJVMDD>;
	Mon, 22 Oct 2001 08:03:03 -0400
To: =?iso-8859-1?Q?Roar_Thron=E6s?= <roart@nvg.ntnu.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: increase the number of system call parameters
In-Reply-To: <Pine.LNX.4.33.0110221334200.1121-100000@hagbart.nvg.ntnu.no>
From: Andi Kleen <ak@muc.de>
Date: 22 Oct 2001 14:03:35 +0200
In-Reply-To: =?iso-8859-1?Q?Roar_Thron=E6s?='s message of "Mon, 22 Oct 2001 13:48:26 +0200 (CEST)"
Message-ID: <k2r8rvvq3s.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110221334200.1121-100000@hagbart.nvg.ntnu.no>,
=?iso-8859-1?Q?Roar_Thron=E6s?= <roart@nvg.ntnu.no> writes:
> Hi
> (I am sorry if this question has been asked and answered before)

> How do you increase the number of system call parameters, and how many
> can you at most have?

You can have upto 6 argument on i386. Each argument needs an register 
to pass and the i386 has only 8 and two are used for the stack pointer
and the syscall number. This leaves you 6.
Other architectures may not have that limitation.

> Would up to 12 parameters be possible, and how?

Yes. Just pass a pointer to an auxillary structure as the first argument
and do a copy_from_user on that structure at the entry point. Put the
arguments in that structure. In user space you can hide the structure in a 
stub.

Some system calls (mmap, old_select, socketcall) are in fact implemented 
like this because they were designed before the entry point supported
6 arguments.

A note on design: if you have a function call that needs 12 arguments you
probably forgot some[1] (in short it is a strong cue for a broken design,
you should probably split it in smaller calls) 

-Andi

[1] unknown author
