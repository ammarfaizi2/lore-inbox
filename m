Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSAZCqg>; Fri, 25 Jan 2002 21:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288996AbSAZCq0>; Fri, 25 Jan 2002 21:46:26 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32268 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288995AbSAZCqL>; Fri, 25 Jan 2002 21:46:11 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 25 Jan 2002 18:53:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <Pine.LNX.4.33.0201251810270.16989-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201251851420.1647-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Linus Torvalds wrote:

>
> On Sat, 26 Jan 2002, Andi Kleen wrote:
> > On Fri, Jan 25, 2002 at 05:53:57PM -0800, Linus Torvalds wrote:
> > >
> > > On 26 Jan 2002, Andi Kleen wrote:
> > > >
> > > > It doesn't explain the Athlon speedups. On athlon cli is ~4 cycles.
> > >
> > > .. and it probably serializes the instruction stream.
> >
> > I have word from AMD engineering that it doesn't stall the pipeline
> > or serializes.
>
> Note that it may not be the "cli" itself - the "iret" may be slower if it
> has to enable interrupts that were disabled before. Ie the iret microcode
> may have the equivalent of
>
> 	/* Did eflags change? */
> 	if ((new_eflags ^ old_eflags) & IF_MASK)
> 		.. do sti/cli as appropriate ..
>
> which would mean that the "cli" itself may take 4 cycles, but the "sti"
> implicit in the iret will _also_ take 4 cycles and is optimized away when
> not needed.
>
> Which would add up to the 8 cycles needed for a ~3.4% speedup (this is
> assuming the baseline is something like 250 cycles per system call, I've
> not checked that assumption).

guys, why don't you use #rdtsc to discover where perf improvement comes from ?




- Davide


