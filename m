Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277519AbRJOMjQ>; Mon, 15 Oct 2001 08:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277526AbRJOMjG>; Mon, 15 Oct 2001 08:39:06 -0400
Received: from pcephc56.cern.ch ([137.138.38.92]:57472 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S277519AbRJOMiy>; Mon, 15 Oct 2001 08:38:54 -0400
Date: Mon, 15 Oct 2001 14:38:40 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jelson <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
Message-ID: <20011015143840.G4269@kushida.jlokier.co.uk>
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu> <20011005205136.A1272@elf.ucw.cz> <m1n132x4qg.fsf@frodo.biederman.org> <20011008122013.B38@toy.ucw.cz> <m1wv1zqk37.fsf@frodo.biederman.org> <20011014081233.A31752@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011014081233.A31752@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Sun, Oct 14, 2001 at 08:12:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I do not think tty/pty pair does cut it for AT emulation. Can you
> really emulate all neccessary features using pty/tty?

Remember that if you go for a full user-space driver, you have to
duplicate the kernel's tty layer to emulate everything.  For full
compatibility, that means emulating all the ancient serial and tty
ioctls properly including Linux-specific ones, SYSV-style ones,
BSD-style ones etc.

That's already been done _and_ tested in the kernel over the years.
While repeating that in user space is possible, I suspect that a pty/tty
interface would end up providing better compatibility (in practice) for
all the different, special and ancient terminal programs.  In the cases
where pty/tty doesn't relay enough information to the pty side, we
should look at whether minor changes to the pty driver can fix that.

cheers,
-- Jamie
