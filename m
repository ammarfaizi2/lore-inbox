Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130414AbQJ2StR>; Sun, 29 Oct 2000 13:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130237AbQJ2StH>; Sun, 29 Oct 2000 13:49:07 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:3581 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130414AbQJ2Ss4>; Sun, 29 Oct 2000 13:48:56 -0500
Date: Sun, 29 Oct 2000 18:48:45 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Jesse Pollard <pollard@cats-chateau.net>
cc: Stephen Harris <sweh@spuddy.mew.co.uk>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
In-Reply-To: <00102910423100.15754@tabby>
Message-ID: <Pine.LNX.4.10.10010291846210.20547-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2000, Jesse Pollard wrote:

> On Sun, 29 Oct 2000, Stephen Harris wrote:
> >Horst von Brand wrote:
> >
> >> > > If you send SIGSTOP to syslogd on a Red Hat 6.2 system (glibc 2.1.3,
> >> > > kernel 2.2.x), within a few minutes you will find your entire machine
> >> > > grinds to a halt.  For example, nobody can log in.
> >> 
> >> Great! Yet another way in which root can get the rope to shoot herself in
> >> the foot. Anything _really_ new?
> >
> >OK, let's go a step further - what if syslog dies or breaks in some way
> >shape or form so that the syslog() function blocks...?
> >
> >My worry is the one that was originally raised but ignored:  syslog() should
> >not BLOCK regardless of whether it's local or remote.  syslog is not a
> >reliable mechanism and many programs have been written assuming they can
> >fire off syslog() calls without worry.
> 
> It was NOT ignored. If syslogd dies, then the system SHOULD stop, after a
> few seconds (depending on the log rate...).

No. You should have the OPTION of stopping the machine, if accurate syslog
information is more important to you than system functionality. This
should also be an OS function, rather than just freezing processes as and
when they call syslog()!

> I do believe that restarting syslog should be possible... Perhaps syslog
> should be started by inetd at the very beginning. Then it could be restarted
> after an exit/abort.

inetd? I'd have thought init would make a more suitable choice, perhaps
with a monitor to lock the machine up or reboot if syslog fails and can't
be restored.

> This can STILL fail if the syslog.conf is completely invalid - but then the
> system SHOULD be stopped pending the investigation of why the file has been
> corrupted, or syslogd falls back on a default configuration (record everything
> in the syslog file).

Again, that might be useful in some cases, but certainly shouldn't be the
only, or even default, mode.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
