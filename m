Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWBCSaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWBCSaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWBCSaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:30:11 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21522 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751401AbWBCSaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:30:09 -0500
Date: Fri, 3 Feb 2006 19:30:07 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203183006.GB57965@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	Dave Jones <davej@redhat.com>,
	Nigel Cunningham <nigel@suspend2.net>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060203104129.GC2830@elf.ucw.cz> <20060203142915.GA44720@dspnet.fr.eu.org> <200602031824.45467.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602031824.45467.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 06:24:44PM +0100, Rafael J. Wysocki wrote:
> I use it on a daily basis.  It works.

The plural of anecdote is not data.  Nobody except Pavel and you ever
wrote code to work in the userland part of your suspend.  But the aim
is to have GUI-type code written by other people running between the
snapshotting and the system shutdown, right?  Code that is pretty much
by definition just plain untrustable in the first place.

The interactions with a frozen, direct-rendering X are going to be
quite amusing too.  You'll have to be very careful to switch VTs to a
suspend-aware framebuffer before snapshotting.  That could help
reducing your video-card related problems though.


> The suspending helper should not use mounted filesystems after it
> calls the atomic snapshot ioctl().

You can s/mounted// on that.  It's pretty much impossible to unmount
filesystems on a running system, it's always kept busy by something.
Especially system filesystems.


> The resuming helper should be run from
> an initrd and all filesystems should be unmounted at that time (of course
> it should not attempt to mount them).

Mandatory initrd?  How nice...


> > Will the fs be in a coherent state after resume?
> 
> Yes, it will, as long as the helpers follow some strict rules (above).

That's exactly what I'm terribly afraid of.  You have no way to
enforce them, so they won't be respected.  And filesystems will die
randomly and unpredictably.


> > The idea of trying to save a state that can be modified dynamically
> > while you're saving in unpredictable ways makes me very, very afraid.
> > At least when you're in the kernel you can have complete control over
> > the machine when needed.
> 
> Not necessarily.  For example, if you suspend the box and then start it with
> a wrong kernel that is unable to read the image, it will mount the file
> systems and you loose the saved state.

You can always limit the damage by syncing the disks before
snapshotting.  This way you'll only lose the running processes if you
don't actually resume.  While having the in-memory cache of the state
of the filesystem being different of the real on-disk state eats
filesystems for breakfast.  The output of fsck is not pretty.
BTDTGTTS.

  OG.

