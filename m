Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310540AbSCTWPg>; Wed, 20 Mar 2002 17:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312117AbSCTWP1>; Wed, 20 Mar 2002 17:15:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43279 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310540AbSCTWPT>; Wed, 20 Mar 2002 17:15:19 -0500
Date: Wed, 20 Mar 2002 23:15:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Daniela Engert <dani@ngrt.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Olivier Galibert <galibert@pobox.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020320221514.GB23957@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020319225609.A12655@ucw.cz> <20020320065425.D27F3DD1C@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Not all of them safely, though. Many a drive will corrupt data if it
> >> > receives a command when not spinned up. You need to issue a wake command
> >> > first, which hdparm doesn't, it just leaves it to the kernel to issue a
> >> > read command or whatever to wake the drive ...
> >> 
> >> Is this common disk bug, or are they permitted to behave like that?
> >
> >This behavior is permitted by the specification, as far as I know -
> 
> Actually not. Have a look at page 36 of the current ATA6
> specification.

Good. So noflushd is safe.
								Pavel

> If a disk has entered power state PM3:sleep, its interface is turned
> off! You no longer can issue any command except for a DEVICE RESET to
> this unit. A reset is required to initiate a state transition from
> PM3:sleep to PM2:standby (there are no other state transitions).

I do not think we are using PM3:sleep in noflushd, but we even
could. AFAICT, ide layer resets interface if it does not respond.

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
