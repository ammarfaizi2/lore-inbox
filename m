Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTAFE2z>; Sun, 5 Jan 2003 23:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTAFE2z>; Sun, 5 Jan 2003 23:28:55 -0500
Received: from h-64-105-35-112.SNVACAID.covad.net ([64.105.35.112]:54210 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265936AbTAFE2y>; Sun, 5 Jan 2003 23:28:54 -0500
Date: Sun, 5 Jan 2003 20:37:25 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch(2.5.54): devfs shrink - integration candidate
Message-ID: <20030105203725.A10808@adam.yggdrasil.com>
References: <20030105201413.A10685@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030105201413.A10685@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Jan 05, 2003 at 08:14:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	The sixth iteration of my devfs code shink is available here:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.54-v6.patch
	I believe the deletions make the patch so big that the
linux-kernel mailing list filters prevent me from submit an email that
includes it.

	This patch reduces include/linux/devfs*.h and fs/devfs from
3655 lines to 1239, a reduction of 2450 lines, nearly a factor three.
That may not be as impressive as the original 5X reduction, but that
is mostly because I've restored a bunch of functionality that I hope
to eliminate in the future.

	I'd like to thank Richard Gooch for writing devfs.  I think it
was a great idea and the effort involved in implementing it,
especially when it was not clear that it could work well, was probably
about 30-100 times my effort in shrinking it.  I immediately became a
convert within a day of trying it.  I'd be happy for Richard to take
over this code and continue maintaining devfs.  If he doesn't want to,
I'm willing to and I'm also happy to let someone else do it if they
want.

	This is nearly the same patch that I attempted to post on
January 2, but apparently some well intentioned spam filter blocked
it.  I had this problem once before, also when submitting a big patch
with a lot of deletions sent as a MIME attachment.  This time I'm
submitting the patch as part of the text of my message.

	The there are no code changes between this version and the one
that I tried to post on January 2.  In the meantime, I've used it and
stared at it more, and now I'm posting this as a candiate for
integration into Linus's kernel.

	The January 2 version introduced two significant changes:
isolating the filesystem driver to a separate file that only exports
two symbols (devfs_vfsmount and init_devfs_fs), and making that patch
a change to fs/devfs rather than a new filesystem.  (If anyone would
prefer that I submit this as a separate file system, please let me
know.)

        If you want devfsd functionality (well, at least the
"REGISTER" and "LOOKUP" events), you can get my user level program
devfs_helper, which is a reduced functionality replacement program for
devfsd from the following URL.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs_helper/devfs_helper-0.1.tar.gz

	devfs_helper is program that is exec'ed on each event rather
than being a daemon that waits on events.  When the new module_param
code is further developed, I will default the devfs_helper to be
turned off until a user level program sets the name of the program.

	Finally, I'd like to move forward toward getting this into
Linus's kernel.  Any blessings, curses, requests for changes or advice
on the best way to proceed would be appreciated.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
