Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269551AbRHAD2f>; Tue, 31 Jul 2001 23:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269619AbRHAD2Z>; Tue, 31 Jul 2001 23:28:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19007 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269551AbRHAD2O>; Tue, 31 Jul 2001 23:28:14 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: Stuart MacDonald <stuartm@connecttech.com>, Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int>
	<3B65F1A2.30708CC1@fc.hp.com>
	<000701c119cd$ebf0c720$294b82ce@connecttech.com>
	<20010731174247.A21802@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jul 2001 21:21:54 -0600
In-Reply-To: <20010731174247.A21802@flint.arm.linux.org.uk>
Message-ID: <m18zh4zcq5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Russell King <rmk@arm.linux.org.uk> writes:

> On Tue, Jul 31, 2001 at 10:34:35AM -0400, Stuart MacDonald wrote:
> > That's very odd. That implies that serial consoles don't use the serial
> > driver at all then, as the pci serial port setup is done at the same
> > time as the regular serial port setups.
> > 
> > If a serial console is using serial.c, the pci serial ports will also
> > be available.
> 
> No.  Console initialisation is done early, before PCI is setup.  This
> means that the serial driver is relying on a static array of IO port
> addresses.  At this time, the serial driver hasn't probed any ports at
> all, so it doesn't really know what does and doesn't exist.

Hmm. I hadn't realized it was poking in the dark.
 
> The more I think about this, the more that I think we need to get rid
> of this early console initialisation.  I think Linus really wants early
> console initialisation though, and to be honest, its an extremely useful
> debugging tool for those pesky non-boots with blank displays.

I think I both agree and disagree with you.  I think it might make sense
to seperate out the debugging console drivers from the normal kernel drivers.
I have had several times where I have had to hack up a serial driver that
is initialized very early so I could see why my kernel is crashing.

If we seperated out the console drivers and modified them so they would
build for specific hardware, and would be initialized immediately upon
transition to C code.  There would be a major debugging benefit.  

Then we could probably afford to use the normal serial code for a more
normal serial console.

Does this sound like a reasonable direction to go?  You've torn open
the code and familiar with what it's guts look like.


> If someone would like to produce a patch which adds an option for early
> console vs "normal" console initialisation...  Otherwise I'll add it to
> my (longish) "to do" list.

I might have to look.  I have done some preliminary work, in getting a
very, very early serial console built so I'm not completely in the
dark.  If you like the idea of splitting the console code in two half
that uses normal routines and another have that does very, very, very
early initialization I'm more likely to :)

Eric

