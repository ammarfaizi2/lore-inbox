Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312162AbSCYAJI>; Sun, 24 Mar 2002 19:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312160AbSCYAI7>; Sun, 24 Mar 2002 19:08:59 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:53890 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312162AbSCYAIs>; Sun, 24 Mar 2002 19:08:48 -0500
Date: Sun, 24 Mar 2002 17:08:43 -0700
Message-Id: <200203250008.g2P08hr18250@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
In-Reply-To: <200203200630.g2K6UNw24115@vindaloo.ras.ucalgary.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Al. What is the intended behaviour of MNT_DETACH
wrt. /proc/mounts? It appears that detaching a FS leaves behind an
apparently stale entry in /proc/mounts. Is this intentional?

This question came up after the following exchange:

I wrote:
> Felix Braun writes:
> > Hi Richard,
> > 
> > I just noticed that devfs is listed twice in /proc/mounts in linux
> > 2.4.19-pre3, which confuses my shutdown script. Under 2.4.19-pre my
> > /proc/mounts looks like this:
> > 
> > devfs /dev devfs rw 0 0
> > /dev/ide/host0/bus0/target0/lun0/part5 / reiserfs rw 0 0
> > none /dev devfs rw 0 0
> > /proc /proc proc rw 0 0
> > /dev/discs/disc0/part1 /dos vfat rw 0 0
> > /dev/discs/disc0/part9 /opt reiserfs rw,noatime 0 0
> > none /dev/pts devpts rw 0 0
> > /dev/discs/disc0/part7 /usr reiserfs rw 0 0
> > none /dev/shm tmpfs rw 0 0
> > 
> > whereas under 2.4.18 the first line didn't show up. Is that a
> > misconfiguration on my part?
> 
> No, this is due to a change in the kernel (presumably done by Al).
> What seems to be happening is that the kernel temporarily mounts devfs
> and then detaches it again using MNT_DETACH (actually, you need
> 2.4.19-pre3-ac2 to get the fix that adds MNT_DETACH). However,
> detached filesystems still appear to be listed in /proc/mounts.
> Arguably, this is incorrect.
> 
> If you were to reboot single-user, and with devfs=nomount, inspection
> of /proc/mounts would show the line:
> devfs /dev devfs rw 0 0
> 
> However, if you listed /dev, you would see that it doesn't actually
> contain a devfs. Thus, /proc/mounts is deceiving you.
> 
> Al: what is the intended behaviour of MNT_DETACH wrt. /proc/mounts?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
