Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266176AbRGKURZ>; Wed, 11 Jul 2001 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbRGKURP>; Wed, 11 Jul 2001 16:17:15 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:25847 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266074AbRGKURH>; Wed, 11 Jul 2001 16:17:07 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112016.f6BKGgVq009480@webber.adilger.int>
Subject: Re: disk full or not?  you decide...
In-Reply-To: <3B4CA943.5EC6A127@zapmedia.com> "from Shawn Veader at Jul 11, 2001
 03:30:11 pm"
To: Shawn Veader <shawn.veader@zapmedia.com>
Date: Wed, 11 Jul 2001 14:16:42 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Veader writes:
> we are using reiserfs on a system running 2.4.3  we noticed recently
> that the partition reported itself as being full. after a reboot
> the system reported having 6G freed. now again after a day of use
> the space has dissappered.
> ----
> does anyone know why this is happening? our guess is that the logs
> to reiser are getting quite large. how do we flush them and force
> a garbage collection? we save and remove several large files on this
> partition as the system is running. therefore, i figure that the
> space is kept around till the log is flushed in case it is needed for
> replaying the journal. am i totaly off?

The problem is that something is keeping these files open, and the
space cannot be freed until the process exits (or closes the files).
You can use lsof to tell you which files are open, and which process is
using them.  If it is your own code that is causing this problem, you
need to ensure that you close all of the files that you open when you
are done with them.

The reiserfs journal is a fixed size, so it cannot be that.

Note also that on reiserfs, if you have such a process which keeps
files open after they are deleted and then you have a crash, the file
is "orphaned" and the space is "lost" until you run reiserfsck again.
It may be that Chris Mason's patch for this is in the latest kernels,
but it may not be, and it might not be in the kernel you are running.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
