Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRCUOVM>; Wed, 21 Mar 2001 09:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRCUOVB>; Wed, 21 Mar 2001 09:21:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21219 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131474AbRCUOUs>;
	Wed, 21 Mar 2001 09:20:48 -0500
Message-ID: <3AB8B877.D36E8719@mandrakesoft.com>
Date: Wed, 21 Mar 2001 09:19:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Will Newton <will@misconception.org.uk>
Cc: Tim Waugh <twaugh@redhat.com>, Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103211333440.1541-100000@dogfox.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Newton wrote:
> On Tue, 20 Mar 2001, Jeff Garzik wrote:
> > I am not sure that I agree, however, that an "irq=none" on the kernel
> > cmd line should affect the operation of the Via code.  I would much
> > rather fix the Via code as I suggest above.
> 
> irq=none seems pretty unequivocal to me, I'm not sure how easy it is to
> explain to a user that irq=none doesn't do what it says.

For this specific case, Via motherboards, we know exactly whether or not
an interrupt was assigned to the parallel port, and whether or not the
parallel port is in an interrupt-driven mode.  Attempting to pretend
that the parallel port is not in an interrupt driven mode by passing
irq=none is folly.

If irq=none is passed to tell the Via code to -force- the parallel port
into a non-irq-driven mode is one thing.  If irq=none is passed to hide
a problem with spurious interrupts, we need to fix that problem, not
hide it.

So as I see it, I should fix the Via code to read (only!) the parallel
port configuration from BIOS, and set up the parallel port that way.  I
still am not convinced that irq=<anything> should affect the Via code at
all.  Maybe I can print out a message "irq=foo ignored".

Optionally, I could handle irq=none by force-disabling the parallel
port's interrupt driven modes, if they are active.  I don't want to do
this, but may be forced to by circumstance...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
