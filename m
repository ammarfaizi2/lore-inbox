Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316091AbSETPqK>; Mon, 20 May 2002 11:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316094AbSETPqK>; Mon, 20 May 2002 11:46:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61446 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316091AbSETPqJ>; Mon, 20 May 2002 11:46:09 -0400
Date: Mon, 20 May 2002 11:42:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: michael@hostsharing.net,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <200205201304.IAA07423@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.3.96.1020520112307.28501B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Jesse Pollard wrote:

> Michael Hoennig <michael@hostsharing.net>:

> > We wondererd why setting the guid bit on a directory makes all new files
> > owned by the group of the directory, but this does not work for the suid
> > bit, making new files owned by the owner of the directory.
> 
> The setgid bit on a directory is to support BSD activities. It used to be
> used for mail delivery.
> 
> > It would be a good solution to make files created by Apaches mod_php in
> > safe-mode, not owned by web:web (or httpd:httpd or somethign) anymore, but
> > the Owner of the directory. 
> 
> No. You loose the fact that the file was NOT created by the user.

  What's your point here? Obviously the owner of the directory wants it
that way. Linux is about choices, Windows is about "we know best." Like
creating a set-uid file it can be misused, but I ran mail on SCO for years
set-uid mail (not root) as an access control.
 
> > I do not even see a security hole if nobody other than the user itself and
> > httpd/web can reach this area in the file system, anyway. And it is still
> > the users decision that files in this (his) directory should belong to
> > him.
> 
> 1. users will steal/bypass quota controls

  How? The quota should work just as well, the code doesn't seem to care
how the owner was set, just who owns the file. I can think of several
groupware applications for using a group to get write, and having the
files owned by the uid of the application. "chmod 4775 shared_dir" comes
to mind. Yes, it has a sharp edge, you could do something dumb. See above
on o/s philosophy. And this may result in quota being correctly applied to
the filespace of a project rather than on individuals who may be creating
files in many places, some not releated to a given project.

> 2. Consider what happens if a user creates a file in such a directory and
>    it is executable. - since the file is fully owned by a different user, it
>    appears to have been created by that user. What protection mask is on
>    the file? Can the creator (not owner) make it setuid? (nasty worm
>    propagation method)

  Clearly the owner is the owner, and the creator is just another user
after the file is created.

> > Actually, the suid bit on directories works at least under FreeBSD. Is
> > there any reason, why it does not work under Linux?
> 
> I don't believe it is in the POSIX definition.

  Neither is clone() and a lot of other stuff. I would say that if POSIX
mandates behaviour or features Linux should follow, if POSIX forbids it
should be forbidden, and everything else is up for discussion. (for
discussion read SuS for POSIX if you care).

  I think the feature is a config option at kernel build time in BSD, but
I didn't go refresh my dusty memory.

  Useful tools are often dangerous, this would seem to be one of those
cases. Linux already has more cutting edges than a Swiss Army Knife, and I
think you have enumerated the dangers in this features. I don't see any
which are subtle.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

