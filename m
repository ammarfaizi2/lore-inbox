Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276977AbRJHQIQ>; Mon, 8 Oct 2001 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276975AbRJHQIG>; Mon, 8 Oct 2001 12:08:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46906 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276977AbRJHQHt>; Mon, 8 Oct 2001 12:07:49 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: sis630/celeron perf sucks?
In-Reply-To: <20011006130647.B26223@work.bitmover.com>
	<01100618241801.05593@localhost.localdomain>
	<20011007214009.A3608@work.bitmover.com>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 08 Oct 2001 09:58:02 -0600
In-Reply-To: <20011007214009.A3608@work.bitmover.com>
Message-ID: <m1adz2w2d1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> > Run memtest86 to see what your memory bandwidth is.
> 
> As far as I know, LMbench tells me what my memory bandwidth is just fine.
> I don't care if it is telling me the limit (I know it isn't) I only need
> to know relative speeds across platforms.  It does that.

Getting some real memory bandwidth data out of it would be interesting
for tracking the proble.  By the time you get to pipe bandwidth the
fact you changed kernels could easily have an effect.

I think LMbench has the equivalent of streams in it so those would be useful.

> > Yup.  Blame Intel's marketing department.  This isn't a SIS problem, that's 
> > pure Intel's crippling of the DeCeleron...
> 
> I checked with a guy who works here, he used to work in Intel's processor
> group on performance, and he tells me it isn't the processor, it's the 
> motherboard.  Which jives nicely with the data.

The PII bus has 64 data pins and transfers data over them at the processor
FSB clock rate.  So the processor maximums look something like:
66Mhz  528MB/s
100Mhz 800MB/s
133Mhz 1064MB/s

The data bus for SDRAM happens to follow the same rules, except the
address for the data also happens to go over the data bus, which gives
the processor a small advantage, in pure bandwidth.  The biggest hit
SDRAM takes from protocol overhead is when either (a) you don't burst 
or (b) you are doing back to back reads and writes.  Writes go into
the SDRAM pipeline immediately but reads can't come out of the
pipeline immediately.

And you were getting at most 1/5th of the theoretical which looks
ugly.  Not that I have seen the PII core get close to it's bus
potential except under special conditions.

> I'm just hoping there is some SiS genius out there who will ask me
> 
> "Did you remember to turn off the go 3x slower mode in the BIOS?"
> 
> and I'll hang my head in shame and ask to be directed to that magic
> BIOS switch.

Have you verified that the MTRR's are enabled on your memory?  I
suppose there could also be a bad memory controller setting as well.
You might be able to look at the at the linuxBIOS code and see if
your BIOS is doing something different.

Eric

