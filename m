Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288809AbSAIFOW>; Wed, 9 Jan 2002 00:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSAIFOM>; Wed, 9 Jan 2002 00:14:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26641 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288809AbSAIFN6>; Wed, 9 Jan 2002 00:13:58 -0500
Message-ID: <3C3BD053.DED314A9@zip.com.au>
Date: Tue, 08 Jan 2002 21:08:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com> from "Ken Brownfield" at Jan 08, 2002 05:32:54 PM <E16O6KE-00087x-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Andrew's patches give you 1mS worst case latency for normal situations, that
> is below human perception, and below scheduling granularity.

The full ll patch is pretty gruesome though.

The high-end audio synth guys claim that two milliseconds is getting
to be too much.  They are generating real-time audio and they do
have more than one round-trip through the software.  It adds up.

Linux is being used in so many different applications now.  You are,
I think, one of the stronger recognisers of the fact that we do not
only use Linux to squirt out html and to provide shell prompts to snotty
students.  Good scheduling responsiveness is a valuable feature.

I haven't seen any figures for embedded XP, but it is said that
if you bend over backwards you can get 10 milliseconds out of NT4,
and 4-5 out of the fabled BeOS.  This is one area where we can
fairly easily be very much the best.  It's low-hanging fruit.

Internal preemptability is, in my opinion, the best way to deliver
this.

I accept your point about it making debugging harder - I would
suggest that the preempt code be altered so that it can be disabled
at runtime, rather than via a rebuild.  I suspect this can be
done at zero cost by setting init_task's preempt count to 1000000
via a kernel boot option.  And at almost-zero cost via a sysctl.

I would further suggest that support be added to the kernel to
allow general users to both detect and find the source of latency
problems.  That's actually pretty easy - realfeel running at
2 kHz only consumes 2-3% of the CPU.  It can just be left ticking
over in the background.

With preemptability merged in 2.5 we can then work to fix the
long-held locks.  Most of them are simple.  Some of them are
very much not.  I'll gladly help with that.

-
