Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274424AbRJNGMe>; Sun, 14 Oct 2001 02:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274426AbRJNGMY>; Sun, 14 Oct 2001 02:12:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60690 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274424AbRJNGMK>; Sun, 14 Oct 2001 02:12:10 -0400
Date: Sun, 14 Oct 2001 08:12:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jelson <jelson@circlemud.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
Message-ID: <20011014081233.A31752@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu> <20011005205136.A1272@elf.ucw.cz> <m1n132x4qg.fsf@frodo.biederman.org> <20011008122013.B38@toy.ucw.cz> <m1wv1zqk37.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wv1zqk37.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Yep. And linmodem driver does signal processing, so it is big and
> > > > ugly. And up till now, it had to be in kernel. With your patches, such
> > > > drivers could be userspace (where they belong!). Of course, it would be 
> > > > very good if your interface did not change...
> > > 
> > > I don't see how linmodem drivers apply.  At least not at the low-level
> > > because you actually have to driver the hardware, respond to interrupts
> > > etc.  On some of this I can see a driver split like there is for the video
> > 
> > You don't actually need interrupts -- you *know* when next sample arrives.
> > And port io is completely fine with iopl() ;-).
> 
> But DMA? You are talking about what amounts to a sound card driver.
> And since in the cases that burn cpu time you have to process raw
> sound samples into modem data, you need to shift a fair amount of
> data. inb and outb just don't have the bandwidth.  So you need a
> kernel side component that drives the hardware to some extent.

You need to push 8kHz/16bit, that's 16 kilobytes per second. Or maybe
you can sample at 11kHz, getting 20 kilobytes per second. Comfortably
done with inb/outb.

> Additionally you still don't need a FUSD driver for that case.  All
> you need is to have is a ptty.  Because that is what modem drivers
> are now.  And the ptty route has binary and source compatiblity
> to multiple unix platforms.

I do not think tty/pty pair does cut it for AT emulation. Can you
really emulate all neccessary features using pty/tty?
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
