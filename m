Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTB0IPj>; Thu, 27 Feb 2003 03:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTB0IPj>; Thu, 27 Feb 2003 03:15:39 -0500
Received: from daimi.au.dk ([130.225.16.1]:27052 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261868AbTB0IPg>;
	Thu, 27 Feb 2003 03:15:36 -0500
Message-ID: <3E5DCB89.9086582F@daimi.au.dk>
Date: Thu, 27 Feb 2003 09:25:45 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
		<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
		<3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> 
> Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > /var is clearly the right place for this;
> >
> > Is it?
> 
> Yes.  On some systems, /var and /tmp are the _only_ read-write filesystems.

OK, but then on such a system with my approach it would be possible to
make /mtab.d a symlink pointing to somewhere under /var.

> 
> > > if /var isn't mounted initially, I'd suggest that mount should
> > > simply not update any file at that point, and the init-script that
> > > mounts /var can be responsible from propagating information from
> > > /proc/mounts to /var/whatever.
> >
> > Would you fsck /var while it is mounted?
> 
> No, of course not; that's why I suggest it's up to the init scripts to
> make sure that /proc/mounts gets propagated to /var/whatever.  They
> usually will know enough about what's going on to take care of any
> special cases and add any extra info that's relevant.

But AFAIK fsck uses mtab.

> 
> If a program such as `mount' wants to use mtab and finds that it's not
> present (possibly because /var isn't mounted), it should either use
> /proc/mounts instead, or just ignore it.

If mtab does not exist mount will attempt to create a new one with
only the root listed.

> 
> > I think part of the problem is that /var is used for both files
> > we want to keep across reboot, and files we do not want to keep
> > across reboot.
> 
> [/var/run is for `non-persistant' files]

But that doesn't solve the problem with ordering. If we don't want
to change a lot of userspace utilities and the order in which things
are done during boot, we need /var/run mounted earlier than /var.
And /var/run is not the only directory with files we do not want to
keep across boot. There are some in /var/lock too, and AFAIR a few
other locations.

> 
> > There are cases where it is undesirable to have mtab in /var,
> > but if mount expect to find mtab somewhere under /var, we can't
> > even use a symlink to get it out of there, because /var needs
> > to be mounted before the symlink can be followed.
> 
> It will simply appear to mount as if the file isn't present, in which
> case it should gracefully stop trying to use it [see above].
> 
> It seems like the attempt here is to somehow make everything just work
> magically _without_ modifying any tools that use mtab -- and I think
> that just isn't doable in every situation.

Maybe not, but I certainly don't want to change every program that
reads mtab. If we can limit the changes to those tools that needs
to write mtab, it might be feasible.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
