Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135242AbRDVSk2>; Sun, 22 Apr 2001 14:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135243AbRDVSkS>; Sun, 22 Apr 2001 14:40:18 -0400
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:39184
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S135242AbRDVSkC>; Sun, 22 Apr 2001 14:40:02 -0400
Message-ID: <3AE3255F.61D40FDE@konerding.com>
Date: Sun, 22 Apr 2001 11:39:27 -0700
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <Pine.LNX.3.95.1010420153006.12968A-100000@chaos.analogic.com> <m33db3s0ty.fsf@otr.mynet.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
>
> > The kernel doesn't know if a process is going to use the FPU when
> > a new process is created. Only the user's code, i.e., the 'C' runtime
> > library knows.
>
> Maybe you should try to understand the kernel code and the features of
> the processor first.  The kernel can detect when the FPU is used for
> the first time.

OK, regardless of how the linux kernel actually manages the FPU for user-space

programs, does anybody have any comments on the original bugreport?

>We have found that one of our programs can cause system-wide
>corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
>run this program, the FPU gives bad results to all subsequent
>processes.

>We see this problem on dual 550MHz Xeons with 1GB RAM.  We have 64 of
>these things, and we see the problem on every node we try (dozens).
>We don't have other SMPs handy.  Uniprocessors, including other PIIIs,
>don't seem to be affected.

>Below are two programs we use to produce the behavior.  The first
>program, pi, repeatedly spawns 10 parallel computations of pi.  When
>all is well, each process prints pi as it completes.

>The second program, pt, repeatedly attaches to and detaches from
>another process.  Run pt against the root pi process until the output
>of pi begins to look wrong.  Then kill everything and run pi by itself
>again.  It will no longer produce good results.  We find that the FPU
>persistently gives bad results until we reboot.

I tried this on my dual PIII-600 runnng 2.2.19 and got exactly the behavior
described.
If it is a bug in the linux kernel (I can see nothing wrong with the source
code provided),
I would suspect probems with SMP and ptrace, somehow causing the wrong FP
registers
to be returned to a process after the scheduler restarted it.  It's very
interesting that the
PI program works fine until you run PT, but after you run PT, PI is screwed
until reboot.



