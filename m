Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313552AbSDLLmx>; Fri, 12 Apr 2002 07:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313554AbSDLLmx>; Fri, 12 Apr 2002 07:42:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29446 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313552AbSDLLmv>; Fri, 12 Apr 2002 07:42:51 -0400
Date: Fri, 12 Apr 2002 13:42:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020412114252.GB1893@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com> <20020409015657.A28889@kushida.apsleyroad.org> <20020409222214.GK5148@atrey.karlin.mff.cuni.cz> <20020412114422.A24021@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It works for me, 2.4.18 on HP omnibook xe3.
> > 
> > You may want to watch /proc/stats to see if it is read or write
> > activity that wakes disk up.
> 
> It's write activity, due to atime updates.  I was using nodiratime, but
> that's not good enough because every time an executable is run a load of
> things are accessed.
> 
> I found it interesting that some write activity happens almost
> immediately after the access -- and noflushd is connected in some way.
> If I do this:
> 
>     while :; do cat /proc/stat; sleep 1; done
> 
> Then I see a few writes have occurred at nearly every iteration.  I
> think that is due to the atime updates, because using "noatime" there
> are no writes at most iterations.

Well, that's no problem. noflushd stops kflushd, so it should work
even with atime. [It works for me with atimes!]

> But more interesting: I only see those few-per-second atime writes while
> noflushd is running.  If I kill noflushd then they go away.

?

> I am a bit surprised that "noatime" makes a difference -- I thought that
> if noflushd spun down a disk, then pending inode writes should be
> delayed until a read or excess memory pressure forces a spin up.

Tha'ts idea behind noflushd. I don't know why it does not work for
you.

> So: "noatime" is definitely required, to spin the disk down for more
> than an instant.  But even that is not good enough.  I have 192MB RAM,
> btw.  Is that enough to expect longer spin down times than 20s?

With noflushd, noatime should not and is not required.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
