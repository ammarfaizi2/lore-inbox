Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSKDCmw>; Sun, 3 Nov 2002 21:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKDCmw>; Sun, 3 Nov 2002 21:42:52 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:20913 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S264643AbSKDCmu>; Sun, 3 Nov 2002 21:42:50 -0500
Date: Sun, 3 Nov 2002 21:49:10 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021104024910.GA14849@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	Theodore Ts'o <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	davej@suse.de
References: <87y98bxygd.fsf@goat.bogus.local> <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 06:03:12PM -0800, Linus Torvalds wrote:
> The reason I like directory entries as opposed to inodes is that if you
> work this way, you can actually give different people _different_
> capabilities for the same program.  You don't need to have two different
> installs, you can have one install and two different links to it.

For several years, I have had only one suid root binary on my system.
All other 'setuid' applications are simply symlinks to this binary.

$ ls -l /bin/ping*
lrwxrwxrwx    1 root     root           14 Nov 18  2001 /bin/ping -> /usr/bin/super
-rwxr-xr-x    1 root     root        15244 Nov 18  2001 /bin/ping.suid

There is a a nice configuration file that is used to decide whether to
use suid or setgid, which parts of the environment to drop/keep. And all
of this based on the user, the time and any other conditions I would
like to enforce.

Now super does not (yet) support capabilities. But it shouldn't be too
hard to modify it so that it forks, drops capabilities, (possibly change
the euid to the original user?) and exec the actual binary.

Jan

