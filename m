Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUH0Ojo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUH0Ojo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUH0Ojn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:39:43 -0400
Received: from lucidpixels.com ([66.45.37.187]:7891 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265517AbUH0Ojl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:39:41 -0400
Date: Fri, 27 Aug 2004 10:39:35 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: A few filesystem benchmarks w/ReiserFS4 vs Other Filesystems
Message-ID: <Pine.LNX.4.61.0408271037080.15499@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are balanced b-trees better for removing many files over dancing onces?
See rm -rf benchmark.

# -------------------------------------------------------------------- #
Filesystems to test:
# -------------------------------------------------------------------- #
Each file system was created with fdisk to be +1024MB.
# -------------------------------------------------------------------- #
With default initilization commands: mkfs.fs /dev/hdb[1-7]
# -------------------------------------------------------------------- #
Filesystem            Size  Used Avail Use% Mounted on
/dev/hdb1             962M   20K  913M   1% /fs/ext2
/dev/hdb2             962M   17M  897M   2% /fs/ext3
/dev/hdb3             977M   33M  945M   4% /fs/reiser3
/dev/hdb5             929M  144K  929M   1% /fs/reiser4
/dev/hdb6             973M  256K  973M   1% /fs/jfs
/dev/hdb7             973M  144K  972M   1% /fs/xfs
# -------------------------------------------------------------------- #
Untar the Linux 2.6.8.1 tarball on each file system.
# -------------------------------------------------------------------- #
ext2 | 46.88 sec @ 10% cpu
ext3 | 44.44 sec @ 12% cpu
  jfs | 57.36 sec @ 15% cpu
  rs3 | 37.03 sec @ 23% cpu
  rs4 | 27.42 sec @ 42% cpu
  xfs | 49.74 sec @ 17% cpu
# -------------------------------------------------------------------- #
Execute rm -rf linux-2.6.8.1 on each file system.
# -------------------------------------------------------------------- #
ext2 | 10.26 sec @ 22% cpu
ext3 | 10.02 sec @ 25% cpu
  jfs | 26.67 sec @ 27% cpu
  rs3 | 03.22 sec @ 74% cpu
  rs4 | 25.58 sec @ 50% cpu <- What happened to reiserfs4 here?
  xfs | 12.51 sec @ 47% cpu
# -------------------------------------------------------------------- #
Create a 500MB file with dd to each filesystem with 1MB blocks.
# -------------------------------------------------------------------- #
ext2 | 15.72 sec @ 26% cpu
ext3 | 17.04 sec @ 31% cpu
  jfs | 29.57 sec @ 25% cpu
  rs3 | 15.21 sec @ 27% cpu
  rs4 | 23.96 sec @ 23% cpu <- What happened to reiserfs4 here?
  xfs | 19.07 sec @ 29% cpu


