Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288116AbSAMUgq>; Sun, 13 Jan 2002 15:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288124AbSAMUgg>; Sun, 13 Jan 2002 15:36:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:52485 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288116AbSAMUgX>; Sun, 13 Jan 2002 15:36:23 -0500
Message-ID: <3C41EE51.E45D22C7@zip.com.au>
Date: Sun, 13 Jan 2002 12:30:09 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: jogi@planetzork.ping.de, Ed Sweetman <ed.sweetman@wmich.edu>,
        Andrea Arcangeli <andrea@suse.de>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C41E415.9D3DA253@zip.com.au>,
		<20020113184249.A15955@planetzork.spacenet>,
		<E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy>
		<20020112121315.B1482@inspiron.school.suse.de>
		<20020112160714.A10847@planetzork.spacenet>
		<20020112095209.A5735@hq.fsmlabs.com>
		<20020112180016.T1482@inspiron.school.suse.de>
		<005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> 
		<20020113184249.A15955@planetzork.spacenet>
		<1010946178.11848.14.camel@phantasy>  <3C41E415.9D3DA253@zip.com.au> <1010952276.12125.59.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> > Benchmarks are well and good, but until we have a solid explanation for
> > the throughput changes which people are seeing, it's risky to claim
> > that there is a general benefit.
> 
> I have an explanation.  We can schedule quicker off a woken task.  When
> an event occurs that allows an I/O-blocked task to run, its time-to-run
> is shorter.  Same event/response improvement that helps interactivity.
> 

Sounds more like handwaving that an explanation :)

The way to speed up dbench is to allow the processes which want to delete
files to actually do that.  This reduces the total amount of IO which the
test performs.  Another way is to increase usable memory (or at least to
delay the onset of balance_dirty going synchronous).  Possibly it's something
to do with letting kswapd schedule earlier.  Or bdflush.

In the swapstorm case, it's again not clear to me.  Perhaps it's due to prompter
kswapd activity, perhaps due somehow to improved request merging.

As I say, without a precise and detailed understanding of the mechanisms
I wouldn't be prepared to claim more than "speeds up dbench and swapstorms
for some reason".

(I'd _like_ to know the complete reason - that way we can stare at it
and maybe make things even better.  Doing a binary search through the
various chunks of the mini-ll patch would be instructive).

-
