Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278633AbRKHV5t>; Thu, 8 Nov 2001 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRKHV5k>; Thu, 8 Nov 2001 16:57:40 -0500
Received: from cayuga.grammatech.com ([209.4.89.66]:26126 "EHLO grammatech.com")
	by vger.kernel.org with ESMTP id <S278633AbRKHV5e>;
	Thu, 8 Nov 2001 16:57:34 -0500
Message-ID: <3BEAFFC6.EAC56763@grammatech.com>
Date: Thu, 08 Nov 2001 16:57:26 -0500
From: David Chandler <chandler@grammatech.com>
Organization: GrammaTech, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <Pine.LNX.3.95.1011108162912.239A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a seg fault on both 2.2 and 2.4 kernels by running the following
one-line C program:
	int main() { int k =  (int *)0x0; }

Debugging the offender,
	int main() { int k =  (int *)0xc0000000; }
is not very informative: single-stepping over the sole command just
hangs, and you have to press Control-C to interrupt gdb, at which point
you can single-step right into the same problem again.

When the program hangs, 'top' says that the CPU is fully utilized and
the system is spending 80% of its time in the kernel and 20% in the
offending process.

Have you not been able to duplicate it on a 2.4 kernel on x86?  If not,
please tell me which 2.4 kernel correctly seg faults.


David Chandler

-- 

_____
David L. Chandler.                              GrammaTech, Inc.
mailto:chandler@grammatech.com         http://www.grammatech.com


"Richard B. Johnson" wrote:
> 
> On Thu, 8 Nov 2001, David Chandler wrote:
> 
> > Dick,
> >
> > You're right that the one-liner below may not necessarily produce a seg
> > fault, but shouldn't it terminate normally if it doesn't?  After all,
> > the program just *reads*.  Hanging does not seem to be an option!
> >
> You may want to see if any deliberate seg-fault actually gets
> delivered. Try to read *(0).  If that works (seg-faults), then
> there may be a problem with some boundary condition on paging.
> 
> I can't duplicate the problem here. You can also try to trace
> the code execution to see if it falls into some user-space loop.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
