Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263259AbTCTXHi>; Thu, 20 Mar 2003 18:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbTCTXEm>; Thu, 20 Mar 2003 18:04:42 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:52919 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263231AbTCTXCm>; Thu, 20 Mar 2003 18:02:42 -0500
Date: Thu, 20 Mar 2003 23:13:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs oops [2.5.65]
Message-ID: <20030320231335.GB4638@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, green@namesys.com,
	linux-kernel@vger.kernel.org
References: <20030319141048.GA19361@suse.de> <20030320112559.A12732@namesys.com> <20030320132409.GA19042@suse.de> <20030320165941.0d19d09d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320165941.0d19d09d.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 04:59:41PM -0800, Andrew Morton wrote:
 > > 
 > > Slab corruption: start=c70c7044, expend=c70c7213 problemat=c70c7044
 > > Last user: [<c0280dcb>](reiserfs_alloc_inode+0x1b/0x30)
 > > Data: (lots of hex)
 > 
 > Alas, the "(lots of hex)" is important - it lets us determine which member of
 > struct reiserfs_inode was actually altered.

You're in luck, as noted in the follow up, I captured it all..
http://www.codemonkey.org.uk/cruft/oops.txt
 
 > It would be nice if we had a more robust way of capturing all this info,
 > especially the oops-while-running-X lossage.  Dump-to-floppy or something.

The tricky thing about capturing this one was that something in the VFS
was wedged hard, so I'm lucky the logs made it to disk.
Using sysrq, I synced and the disks made really nasty chugging noises.
umount read only made it write a bunch of stuff out, more chugging
noises for 15 minutes, kill all tasks then popped up a getty for me to
log in on. It took about 3 minutes to get a shell (disk IO was seriously
slow). I took a peek at vmstat 1 (no logs of this sorry), and nothing
out of the ordinary. Not much in swap, plenty of swap free.
short: the machine was horked. I synced, and rebooted, and thankfully
the logs were still there after fsck.ext2 recovered /var

		Dave

