Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSKCRB4>; Sun, 3 Nov 2002 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbSKCRB4>; Sun, 3 Nov 2002 12:01:56 -0500
Received: from science.horizon.com ([192.35.100.1]:4671 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S262196AbSKCRB4>; Sun, 3 Nov 2002 12:01:56 -0500
Date: 3 Nov 2002 17:08:23 -0000
Message-ID: <20021103170823.10591.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: What's left over.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to complicate things, consider this setup:

# cat /proc/swaps
Filename			Type		Size	Used	Priority
/dev/md5                        partition	999864	16904	0
/dev/md6                        partition	999864	16924	0
/dev/md7                        partition	999864	16920	0

Those are all RAID-1 mirrors, a measure whose ass-saving value I have
enjoyed.

While a crash dump to just half of one of those mirrors is fine, finding it
might be a little bit tricky.  And the fact that the kernel reassembles
the mirrors automatically on boot might make retrieving the data a little
bit tricky, too.

(After a crash, the mirrors will be inconsistent, so one will get copied
over the other, but I'm not too clear on which direction it'll happen in.)

I can't NOT reassemble at least some mirrors on boot because / is mirrored!

Now, to that, add the case that each of those is significantly smaller than
main memory.  (2/3 size would still allow swap = 2*ram.)


The problem is that hardware is getting more and more sopisticated and
requiring ever more elaborate device drivers.  Eventually you have to
have a cutoff and say that something is too complex to talk to after a
crash, even though it's theoretically available.  Where is that line?
USB?  iSCSI?  This situation?

A reasonable fallback is to just drop in a cheap crappy dedicated
IDE drive for catching crash dumps, but I'd like the crash dumper to
know how to wake it up from sleep mode; I'd hate to leave it spinning
all the time...
