Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945964AbWBCVNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbWBCVNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945968AbWBCVNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:13:22 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28828 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1945964AbWBCVNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:13:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 22:08:57 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031824.45467.rjw@sisk.pl> <20060203183006.GB57965@dspnet.fr.eu.org>
In-Reply-To: <20060203183006.GB57965@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602032208.58640.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 19:30, Olivier Galibert wrote:
> On Fri, Feb 03, 2006 at 06:24:44PM +0100, Rafael J. Wysocki wrote:
> > I use it on a daily basis.  It works.
> 
> The plural of anecdote is not data.  Nobody except Pavel and you ever
> wrote code to work in the userland part of your suspend.  But the aim
> is to have GUI-type code written by other people running between the
> snapshotting and the system shutdown, right?  Code that is pretty much
> by definition just plain untrustable in the first place.

By the same token any code that's run as/by root is untrastable and it can
destroy the system just as well.

> The interactions with a frozen, direct-rendering X are going to be
> quite amusing too.  You'll have to be very careful to switch VTs to a
> suspend-aware framebuffer before snapshotting.  That could help
> reducing your video-card related problems though.

Yes.  We are switching to a VT before snapshotting the system.

> > The suspending helper should not use mounted filesystems after it
> > calls the atomic snapshot ioctl().
> 
> You can s/mounted// on that.  It's pretty much impossible to unmount
> filesystems on a running system, it's always kept busy by something.
> Especially system filesystems.

I mean it shouldn't read files from such filesystems or write to them.  They
are mounted all the time and should not be unmounted, of course.

> > The resuming helper should be run from
> > an initrd and all filesystems should be unmounted at that time (of course
> > it should not attempt to mount them).
> 
> Mandatory initrd?  How nice...

Why?  It's quite easy to set up and virtually all distributions use it anyway.

> > > Will the fs be in a coherent state after resume?
> > 
> > Yes, it will, as long as the helpers follow some strict rules (above).
> 
> That's exactly what I'm terribly afraid of.  You have no way to
> enforce them, so they won't be respected.  And filesystems will die
> randomly and unpredictably.

Yes, this may happen if the userland helpers are buggy, but again any
root-equivalent process that is buggy can do the damage just as well.

Your point seem to be "we should implement this in the kernel to protect
the users from irresponsible authors of userland applications
and distributors".  I just don't agree with that.  [Going along this line of
reasoning we should implement fsck in the kernel too. ;-)]

> > > The idea of trying to save a state that can be modified dynamically
> > > while you're saving in unpredictable ways makes me very, very afraid.
> > > At least when you're in the kernel you can have complete control over
> > > the machine when needed.
> > 
> > Not necessarily.  For example, if you suspend the box and then start it with
> > a wrong kernel that is unable to read the image, it will mount the file
> > systems and you loose the saved state.
> 
> You can always limit the damage by syncing the disks before
> snapshotting.

Yes, we are doing that already and we are working on improving it further
(just now :-)).

Still, if you don't like the idea of userland-based suspend, we are not going
to remove the kernel-based suspend, AFAICT.

Greetings,
Rafael
