Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTB0G4g>; Thu, 27 Feb 2003 01:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTB0G4g>; Thu, 27 Feb 2003 01:56:36 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:23503 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261427AbTB0G4e>; Thu, 27 Feb 2003 01:56:34 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DB2CA.32539D41@daimi.au.dk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Feb 2003 16:06:46 +0900
In-Reply-To: <3E5DB2CA.32539D41@daimi.au.dk>
Message-ID: <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:
> > /var is clearly the right place for this;
> 
> Is it?

Yes.  On some systems, /var and /tmp are the _only_ read-write filesystems.

> > if /var isn't mounted initially, I'd suggest that mount should
> > simply not update any file at that point, and the init-script that
> > mounts /var can be responsible from propagating information from
> > /proc/mounts to /var/whatever.
> 
> Would you fsck /var while it is mounted?

No, of course not; that's why I suggest it's up to the init scripts to
make sure that /proc/mounts gets propagated to /var/whatever.  They
usually will know enough about what's going on to take care of any
special cases and add any extra info that's relevant.

If a program such as `mount' wants to use mtab and finds that it's not
present (possibly because /var isn't mounted), it should either use
/proc/mounts instead, or just ignore it.

> I think part of the problem is that /var is used for both files
> we want to keep across reboot, and files we do not want to keep
> across reboot.

[/var/run is for `non-persistant' files]

> There are cases where it is undesirable to have mtab in /var,
> but if mount expect to find mtab somewhere under /var, we can't
> even use a symlink to get it out of there, because /var needs
> to be mounted before the symlink can be followed.

It will simply appear to mount as if the file isn't present, in which
case it should gracefully stop trying to use it [see above].

It seems like the attempt here is to somehow make everything just work
magically _without_ modifying any tools that use mtab -- and I think
that just isn't doable in every situation.

-Miles
-- 
Quidquid latine dictum sit, altum viditur.
