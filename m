Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbSAAS6P>; Tue, 1 Jan 2002 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283016AbSAAS6G>; Tue, 1 Jan 2002 13:58:06 -0500
Received: from mail004.syd.optusnet.com.au ([203.2.75.228]:49040 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S283204AbSAAS5v>; Tue, 1 Jan 2002 13:57:51 -0500
Date: Wed, 2 Jan 2002 05:57:35 +1100
From: Andrew Clausen <clausen@gnu.org>
To: linux-kernel@vger.kernel.org
Cc: bug-parted@gnu.org, evms-devel@lists.sourceforge.net
Subject: userspace discovery of partitions
Message-ID: <20020102055735.C472@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As discussed a while ago (see thread starting at
http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.2/0659.html), I
wrote a frontend to libparted that does nothing but probe all
block devices for partition tables, and tells the kernel what
partitions it finds.  It optionally prints a short summary.

The hope is to be able to remove partition table parsing from the
kernel, and share partition table code with libparted.

It's called partprobe, and is distributed with Parted.  Get it from:

	ftp.gnu.org/gnu/parted/devel/parted-1.5.6-pre2.tar.gz

When partprobe/libparted are compiled with --enable-discover-only
--disable-nls etc (see README), it comes to about 73k (35k
compressed), not including libc or libuuid.  Unfortunately, this is
still quite large to be including in things like initramfs.  Is
it worth paying this price?

libparted currently supports 7 partition table formats (vs 11 in
linux 2.4).  It uses the blkpg interface in 2.4 to communicate
partition info.  (see libparted/linux.c, linux_disk_commit)

Andrew

