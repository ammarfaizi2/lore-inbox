Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSDCGjf>; Wed, 3 Apr 2002 01:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSDCGjZ>; Wed, 3 Apr 2002 01:39:25 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:60664 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S292730AbSDCGjO>; Wed, 3 Apr 2002 01:39:14 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 2 Apr 2002 23:37:50 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 vs. ext3 recovery after crash
Message-ID: <20020403063750.GQ4735@turbolinux.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020402225256.9671A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 02, 2002  23:02 -0500, Bill Davidsen wrote:
> I have a laptop (Dell Inspiron C600) which, like most Dell laptops,
> crashes every time I log out of X. On some occasions on reboot I get a
> message about replaying the journal, while occasionally I get a full ext2
> style multi-pass 12 minute recovery. I don't see why the ext3 isn't always
> used, I know it's going to crash, I always do a sync and wait ten seconds
> for journal writes, etc, to take place.

You should be able to see easily if it is being checked by a forced
fsck, from a message like "maximal mount count reached, forcing fsck".

You can use the "tune2fs -c" option to increase the number of mounts
between full checks (or "tune2fs -c 0" to turn it off, and then use
"tune2fs -i 1m" to reduce the interval between checks to once a month or
whatever).  Note that it is _strongly_ recommended NOT to turn off both
mount- and time-based forced fscks on your filesystem, because things
like bad kernels, bad disks, RAM, cables, etc can still cause corruption.

Note also that some laptops can lose data at shutdown (even on a clean
shutdown) because their disks have problems with flushing the cache.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

