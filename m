Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbSLSNA3>; Thu, 19 Dec 2002 08:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbSLSNA3>; Thu, 19 Dec 2002 08:00:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52620 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267627AbSLSNA2>; Thu, 19 Dec 2002 08:00:28 -0500
Date: Thu, 19 Dec 2002 08:10:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: billyrose@billyrose.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <1040255473.3e0109f183d7e@209.51.155.18>
Message-ID: <Pine.LNX.3.95.1021219080352.3855A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002 billyrose@billyrose.net wrote:

> Richard B. Johnson wrote:
> > The number of CPU clocks necessary to make the 'far' or
> > full-pointer call by pushing the segment register, the offset,
> > then issuing a 'lret' is 33 clocks on a Pentium II.
> >
> > longcall clocks = 46
> > call clocks = 13
> > actual full-pointer call clocks = 33
> 
> this is not correct. the assumed target (of a _far_ call) would issue a far 
> return and only an offset would be left on the stack to return to (oops). the 
> code segment of the orginal caller needs pushed to create the seg:off pair and 
> hence a far return would land back at the original calling routine. this is a 
> very convoluted method of making the orginal call being far, as simply calling 
> far in the first pace should issue much faster. OTOH, if you are making a 
> workaround to an already existing piece of code, this works beautifully (with 
> the additional seg pushed on the stack).
> 

The target, i.e., the label 'goto' would be the reserved page for the
system call. The whole purpose was to minimize the number of CPU cycles
necessary to call 0xfffff000 and return. The system call does not have
issue a 'far' return, it can do anything it requires. The page at
0xfffff000 is mapped into every process and is in that process CS space
already.

I have already gotten responses from people who looked at the code
and said it was broken. It is not broken. It does what is expected.
It takes the same number of CPU cycles as:

		pushl	$0xfffff000
		call	*(%esp)
		addl	$4, %esp

... which is the current proposal. It has the advantage that only
the return address is on the stack when the target code is executed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


