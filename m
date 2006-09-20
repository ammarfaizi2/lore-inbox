Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWITMLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWITMLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 08:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWITMLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 08:11:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:53914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751165AbWITMLs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 08:11:48 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc7-mm1
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060919133606.f0c92e66.akpm@osdl.org>
References: <20060919012848.4482666d.akpm@osdl.org>
	 <200609192225.21801.rjw@sisk.pl>  <20060919133606.f0c92e66.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 20 Sep 2006 14:23:41 +0000
Message-Id: <1158762221.6512.10.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7BIT
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 13:36 -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 22:25:21 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > - It took maybe ten hours solid work to get this dogpile vaguely
> > >   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> > >   I guess it's worth briefly testing if you're keen.
> > 
> > It's not that bad, but unfortunately the networking doesn't work on my system
> > (HPC nx6325 + SUSE 10.1 w/ updates, 64-bit).  Apparently, the interfaces don't
> > get configured (both tg3 and bcm43xx are affected).
> 
> Is there anything interesting in the dmesg output?
> 
> Perhaps an `strace -f ifup' or whatever would tell us what's failing.

FYI, it`s SuSE`s /sbin/getcfg binary that doesn't like the changes.  It
sees /sys/class/net/eth0 as a symlink, and reels off into sys/block (?)
looking for a directory.

lstat64("/sys/class/net/eth0", {st_dev=makedev(0, 0), st_ino=5968, st_mode=S_IFLNK|0777, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:13, st_mtime=2006/09/20-13:58:57, st_ctime=2006/09/20-13:58:57}) = 0
lstat64("/sys/block/eth0", 0xbf9e432c)  = -1 ENOENT (No such file or directory)
open("/proc/mounts", O_RDONLY)          = 3
fstat64(3, {st_dev=makedev(0, 3), st_ino=22711, st_mode=S_IFREG|0444, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-14:00:35, st_mtime=2006/09/20-14:00:35, st_ctime=2006/09/20-14:00:35}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f59000
read(3, "rootfs / rootfs rw 0 0\nudev /dev"..., 4096) = 601
close(3)                                = 0
munmap(0xb7f59000, 4096)                = 0
lstat64("/sys/block", {st_dev=makedev(0, 0), st_ino=256, st_mode=S_IFDIR|0755, st_nlink=18, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-14:00:17, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block", {st_dev=makedev(0, 0), st_ino=256, st_mode=S_IFDIR|0755, st_nlink=18, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-14:00:17, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
open("/sys/block", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_dev=makedev(0, 0), st_ino=256, st_mode=S_IFDIR|0755, st_nlink=18, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-14:00:17, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, {{d_ino=256, d_off=1, d_type=DT_DIR, d_reclen=24, d_name="."} {d_ino=1, d_off=2, d_type=DT_DIR, d_reclen=24, d_name=".."} {d_ino=11521, d_off=3, d_type=DT_DIR, d_reclen=24, d_name="sde"} {d_ino=11455, d_off=4, d_type=DT_DIR, d_reclen=24, d_name="sdd"} {d_ino=11416, d_off=5, d_type=DT_DIR, d_reclen=24, d_name="sdc"} {d_ino=11358, d_off=6, d_type=DT_DIR, d_reclen=24, d_name="sdb"} {d_ino=11311, d_off=7, d_type=DT_DIR, d_reclen=24, d_name="sda"} {d_ino=1784, d_off=8, d_type=DT_DIR, d_reclen=24, d_name="hdd"} {d_ino=1770, d_off=9, d_type=DT_DIR, d_reclen=24, d_name="hdc"} {d_ino=1757, d_off=10, d_type=DT_DIR, d_reclen=24, d_name="hda"} {d_ino=1725, d_off=11, d_type=DT_DIR, d_reclen=32, d_name="loop7"} {d_ino=1722, d_off=12, d_type=DT_DIR, d_reclen=32, d_name="loop6"} {d_ino=1719, d_off=13, d_type=DT_DIR, d_reclen=32, d_name="loop5"} {d_ino=1716, d_off=14, d_type=DT_DIR, d_reclen=32, d_name="loop4"} {d_ino=1713, d_off=15, d_type=DT_DIR, d_reclen=32, d_name="loop3"} {d_ino=1710, d_off=16, d_type=DT_DIR, d_reclen=32, d_name="loop2"} {d_ino=1707, d_off=17, d_type=DT_DIR, d_reclen=32, d_name="loop1"} {d_ino=1704, d_off=18, d_type=DT_DIR, d_reclen=32, d_name="loop0"}}, 4096) = 496
lstat64("/sys/block/sde", {st_dev=makedev(0, 0), st_ino=11521, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block/sde", {st_dev=makedev(0, 0), st_ino=11521, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block/sdd", {st_dev=makedev(0, 0), st_ino=11455, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block/sdd", {st_dev=makedev(0, 0), st_ino=11455, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block/sdc", {st_dev=makedev(0, 0), st_ino=11416, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block/sdc", {st_dev=makedev(0, 0), st_ino=11416, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
lstat64("/sys/block/sdb", {st_dev=makedev(0, 0), st_ino=11358, st_mode=S_IFDIR|0755, st_nlink=5, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2006/09/20-13:59:14, st_mtime=2006/09/20-13:58:59, st_ctime=2006/09/20-13:58:59}) = 0
... fruitless search


