Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbSJ2XdW>; Tue, 29 Oct 2002 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJ2XdW>; Tue, 29 Oct 2002 18:33:22 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:57357 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262479AbSJ2XdV>; Tue, 29 Oct 2002 18:33:21 -0500
Subject: Mounting reiserfs with nonstandard journal size fails
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Reiserfs List <reiserfs-list@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 15:36:20 -0800
Message-Id: <1035934581.1487.1409.camel@rivendell.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble mounting a reiserfs filesystem created with a
nonstandard (smaller) journal size.  But if I use the default journal
size, it works fine.

The filesystem is on a 64 MB compact flash attached to a USB reader. It
has a single partition, which appears as /dev/sda1.

I've done a little detective work with strace'ing mount (8). It calls
mount (2) which fails with EINVAL, which seems to indicate a bad
superblock in this case.  It appears that the in-kernel superblock
parsing for reiserfs does not understand non-standard journal sizes.

My kernel is an updated Red Hat 7.3 (2.4.18-10) and my reiserfsprogs are
3.6.3, downloaded from www.namesys.com and compiled locally.  My mount
program is version 2.11n, the standard Red Hat version.

Is this fixed in later kernels?

Another strange thing I noticed: if I strace a successful mount of the
normal reiserfs, I see two calls to mount (2) in the output.  The first
returns ENOSYS, which is not documented on the mount(2) manpage, but the
second identical call succeeds.  Weird.  Time to have a look at the
mount sourcecode I guess...

successful mount strace output:
...
mount("/dev/sda1", "/mnt/flash", "reiserfs", 0xc0ed0000, 0) = -1 ENOSYS
(Function not implemented)
mount("/dev/sda1", "/mnt/flash", "reiserfs", 0xc0ed0000, 0) = 0
...

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com





