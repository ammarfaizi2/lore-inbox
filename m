Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275760AbRI0Ev4>; Thu, 27 Sep 2001 00:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275764AbRI0Evq>; Thu, 27 Sep 2001 00:51:46 -0400
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:35528 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S275760AbRI0Evd>; Thu, 27 Sep 2001 00:51:33 -0400
Date: Thu, 27 Sep 2001 14:51:50 +1000 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
Reply-To: Tim Connors <tcon@Physics.usyd.edu.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: resume before mounting root [diff against vanilla 2.4.9]
In-Reply-To: <200109270302.f8R32pl12537@saturn.cs.uml.edu>
Message-ID: <Pine.SOL.3.96.1010927143756.6329A-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Albert D. Cahalan wrote:

> Pavel Machek writes:
> > [Albert Cahalan]
> 
> >> Solution for the filesystem problems:
> >>
> >> 1. at suspend, basically unmount the filesystem (keep the mount tree)
> >> 2. at resume, re-validate open files
> >
> > Wrong solution. ;-).
> >
> > Solution to filesystem problems: at suspend, sync but don't do
> > anything more. At resume, don't try to mount anything (so that you
> > don't replay transactions or damage disk in any other way).
> 
> That is totally broken, because I may mount the disk in between
> the suspend and resume. I might even:
> 
> 1. boot kernel X
> 2. suspend kernel X
> 3. boot kernel Y
> 4. suspend kernel Y
> 5. resume kernel X
> 6. suspend kernel X
> 7. resume kernel Y
> 8. suspend kernel Y
> 9. goto #5
> 
> You really have to close the logs and mark the disks clean
> when you suspend. The problems here are similar the the ones
> NFS faces. Between the suspend and resume, filesystems may be
> modified in arbitrary ways.

I missed the rest of the thread, but if you are talking about what I think
you are talking about, I'll go <AOL>Me too</AOL>

A horrible combination of accidents with scripts that set lilo to boot
to the hibernated partition if last suspended, and an apparent BIOS bug
that allowed me to boot out of a hibernated partition for a second
time meant that my laptop came out of regular hibernation mode (as
opposed to using swsusp for "hibernation") 2 months
after I originally suspended the machine. After I had gone through
numerous kernel upgrades and reboots, and after I had partially
repartioned the drive. Needless to say, there were a number of partitions
that were toast after this issue. Fortunately, I had made a backup of my
drive (including me thesis!) only a week beforehand, and /home was fine.
Not bad concidering the last backup was from 3 months ago!


-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

This is a dirty hack!  It might burn your PC and kill your cat!
  -- mpg123.c source


