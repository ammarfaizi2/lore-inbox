Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbULCPyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbULCPyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbULCPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:54:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48316 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261500AbULCPyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:54:49 -0500
Date: Fri, 3 Dec 2004 09:54:42 -0600
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Where should virutal filesystems live?
Message-ID: <Pine.SGI.4.53.0412030922170.46881@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently had a discussion as to where certain virtual filesystems
used to communicate with the kernel/kernel modules from userland should
live.

One of the things we discussed was cpuset, which is in 2.6.10-rc2-mm4.

The kernel docs for cpuset suggest that the cpuset virtual filesystem
be mounted at /dev/cpuset.

My position in the discussion was that this sounded wrong.  Maybe it's
the systems administration background in me but it sure seems like
/dev should be for device nodes to me.  My co-workers rightfully
countered with "then you should suggest something better..."  My fear is
that we'll end up with everybody putting stuff in /dev -- ie,
/dev/kitchensink may be a virtual filesystem in the future...

So I took a look at FHS hoping there would be something like "/dev is
for device nodes only".  FHS states that /dev is the location for
special device files.  So my opinion is that this violates FHS too.

However, since the kernel docs make the suggestions as to where these things
should end up and various distributions are likely to follow that suggestion,
it seems like a valid discussion to have here.

I looked at some examples of where virtual filesystems are mounted in
fedora core 3.  We have /sys (sysfs).  However, it seems like /sys is
for hardware stuffs and we probably don't want to mount other virtuals
under it as-is.

We have devpts mounted at /dev/pts - but it really is device related so
that's probably ok.

We have /dev/shm (tmpfs) - but that's perhaps historic at this point.

We have a usbfs mounted at /proc/bus/usb and binfmt_misc is mounted at
/proc/sys/fs/binfmt_misc.  However, it seems like folks would frown on
mounting more things under /proc and these examples aren't using the fstab
anyway.

It seems like people would also dislike it if we mount at various random
places in / like /cpuset or /kitchensink.

We have a few things in the pipe that will probably need virtual filesystems
mounted "somewhere" that we hope to get accepted in to the kernel.  Is it
possible to sort of agree on some sort of standard place to put these things?
If most people don't cringe at mounting these things in /dev/ like I do, I
can live with that.  My first concern is some sort of consensus.  My 2nd
concern is that it not be /dev :-)

I'd personally like to see something like /sys/<fs> where the various
virtual filesystems can be collected under /sys or something similar.

I look forward to seeing what folks think about this and hopefully it will
help us agree on some sort of convention to start following.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
