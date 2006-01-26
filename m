Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWAZONQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWAZONQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWAZONQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:13:16 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6079 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932325AbWAZONP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:13:15 -0500
Date: Thu, 26 Jan 2006 15:11:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [BUG] debugfs: hard link count wrong
Message-ID: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a bug in debugfs: it seems it doesn't get the hard link
count right. See the output below. This happened on s390x with git tree
of today. Any ideas?

# mount

/dev/dasda1 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /sys/kernel/debug type debugfs (rw)

# cd /sys/kernel/debug/
# ls -al
total 0
drwxr-xr-x   2 root root 0 Jan 26 14:59 .
drwxr-xr-x   3 root root 0 Jan 26 14:59 ..
drwxr-xr-x  22 root root 0 Jan 26 14:59 s390dbf

# find .
.
find: WARNING: Hard link count is wrong for .: this may be a bug in your
filesystem driver.  Automatically turning on find's -noleaf option.
Earlier results may have failed to include directories that should have
been searched.

# stat .

  File: `.'
  Size: 0               Blocks: 0          IO Block: 4096   directory
Device: 5h/5d   Inode: 22          Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2006-01-26 15:00:26.000000000 +0100
Modify: 2006-01-26 14:59:57.000000000 +0100
Change: 2006-01-26 14:59:57.000000000 +0100

Thanks,
Heiko
