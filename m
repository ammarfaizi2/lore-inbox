Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277791AbRJIPpk>; Tue, 9 Oct 2001 11:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277790AbRJIPp3>; Tue, 9 Oct 2001 11:45:29 -0400
Received: from ns.suse.de ([213.95.15.193]:57610 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277788AbRJIPpU>;
	Tue, 9 Oct 2001 11:45:20 -0400
Date: Tue, 9 Oct 2001 17:45:50 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: <Jose_Jorge@teklynx.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kapmidled and AMD K6-2
In-Reply-To: <OFD647EAB7.926A3491-ONC1256AE0.00534E9E@bradycorp.com>
Message-ID: <Pine.LNX.4.30.0110091735160.31520-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 Jose_Jorge@teklynx.fr wrote:

> for the AMD K6-2 on a DFI motherboard AT/ATX, using the AT power supply,
> this option is buggy. I mean the cycles kapmidled works doesn't cool the
> processor, they hot him.

Initially, I thought was odd. The spec seemed straight forward
enough, and doesn't say we have to do any special magic.
Just that "During the execution of the HLT instruction, the AMD-K6-2
processor executes a Halt special cycle."

The next bit is interesting however..

"After BRDY# is sampled asserted during this cycle, and then EWBE#
is also sampled asserted (if not masked off), the processor enters
the halt state in which the processor disables most of its internal
clock distribution."

EWBE is a feature that is enabled with bits 2-3 of the EFER MSR.
This controls the behaviour of the CPU with respect to ordering
of write cycles. Behaviour here can affect performance, and from
my interpretation of the above, the amount of power saving that
is possible.

You can control the EWBE register using powertweak
(http://www.powertweak.org), but if you don't want to/are unable
to build that, and want to do some further tests, let me know
and I'll hack something up.

If this feature is affecting temperature dramatically, it may
be worth us clearing this on boot up.

I've heard reports from Athlon users who also say HLT doesn't
do anything regarding temperature for their systems. I wonder
if it also has a similar feature tucked away in an MSR somewhere..

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

