Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318938AbSHEXjT>; Mon, 5 Aug 2002 19:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318940AbSHEXjT>; Mon, 5 Aug 2002 19:39:19 -0400
Received: from mnh-1-20.mv.com ([207.22.10.52]:14342 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318938AbSHEXjS>;
	Mon, 5 Aug 2002 19:39:18 -0400
Message-Id: <200208060042.TAA04321@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: Richard Zidlicky <rz@linux-m68k.org>, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Tue, 06 Aug 2002 00:34:19 +0200."
             <20020806003419.3457fcb9.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 19:42:31 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> Task wants to do a syscall (i.e. int 0x30 in Fiasco), the kernel
> process tracing the task sees the signal in its SIGCHLD handler. It
> pulls the registers out of the task's address space using
> PTRACE_GETREGS and sets up an interrupt frame on the kernel stack.

Hmmm, I would have the kernel process let the system call bump it out of
wait() rather than delivering a SIGCHLD.  And, I'd be inclined to lomgjmp
over to the kernel stack.

Or, even better, have it already running on the appropriate kernel stack,
so it can just read the system call from PTRACE_GETREGS and call into the
main kernel.

Similarly, with other signals, like the timer, SIGIO, or page faults, it
would just annull the signal and call into the IRQ system.  Although page 
faults will be difficult because of the inability to read err or cr3, as 
you've pointed out.

				Jeff

