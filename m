Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUBZBdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUBZBdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:33:23 -0500
Received: from unthought.net ([212.97.129.88]:47053 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262599AbUBZBdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:33:15 -0500
Date: Thu, 26 Feb 2004 02:33:14 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 - large inode_cache
Message-ID: <20040226013313.GN29776@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear list,

I have this dual athlon box with 1G memory and a 150G filesystem (four
IDE disks on promise controllers, SW RAID-0+1, ext3fs, user quotas,
HIGHMEM set, plain 2.4.25).

A fresh boot after an unclean shutdown, caused it to run quotacheck on
the filesystem, nothing odd about that.

However, after quotacheck completed, I got "3 order allocation failed"
messages. They kept coming, about one per second. This was happening as
the box entered single user mode - and the messages continued.

>From /proc/slabinfo, I got:
inode_cache       1208571 1208571    512 172653 172653    1 :  124   62
dentry_cache         736 268680    128   27 8956    1 :  252  126

To me it looks like this could be at least a part of the explanation for
the memory shortage - am I completely off track here?

After a clean boot with no quotacheck, it looks like:
inode_cache         3829   3829    512  547  547    1 :  124   62
dentry_cache        4710   4710    128  157  157    1 :  252  126

Besides, after a few days of running, the machine will use about 100MB
of memory for cache, 100MB for buffers, about 100MB for userspace, and
the remaining 600-700 MB of memory for inode_cache and dentry_cache.

It's a file server, and its performance is far from stellar. After
seeing that only about 200MB total was used for cache/buffers, I started
digging into slabinfo.

Is this a known problem?  (yes, I know that there's been quite a bit
back and forward on this list about the slabs, but I'm not sure what the
current status is - as far as I know, the only known long-standing
problems with the 2.4 series VM should have been fixed in 2.4.25).

If not, is there anything I can do to actually find out what the cause
of my poor cache sizes are?   I believe that a box which does almost
strictly NFS file serving and has 1G of memory, should use more than
100M for cache.  Or is that just me?    (no, there is no significant
amount of free memory, virtually all is used - but not by cache and not
by userspace).

If it is a known problem - any workarounds?

Would 2.6 solve it?

Thanks, for any input you may have,

 / jakob

