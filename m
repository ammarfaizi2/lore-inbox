Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTIUPrl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTIUPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 11:47:41 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:55426 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262444AbTIUPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 11:47:38 -0400
Message-ID: <3F6DC819.8060003@comcast.net>
Date: Sun, 21 Sep 2003 08:47:37 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: 2.6.0-test5-mm3 & XFS FS Corruption
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050407030401040203000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407030401040203000809
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

Just recently upgraded to 2.6.0-test5-mm3 and am experiencing some
corruption issues on an XFS filesystem. I've been tracking the mm series
through the 2.6.0-test kernels and this is the first I've seen.

I use rsync to backup a volume on a software raid device to another raid
set created from device mapper. The target is a 2 drive setup connected
to a PDC20276 which is defined as a raid0 in the Promise BIOS. There's
no ata-raid in 2.6 yet, so I use dm which works fine.

An rsync from the software raid to the Promise set results in FS
corruption on an XFS filesystem. The rsync will usually complete, but I
am unable to use the filesystem afterward. I have a backup fstab that
needs to be copied and it results in "Operation not permitted", strace'd
output attached.

If I umount the filesystem and run xfs_repair on it, it will proceed
till the end where it rebuilds directory inode 256 - this is the only
item needing repair. This happens every time. I can then mount it and
copy my file with no problem. This corruption is consistent and so far
has happened each time I use rsync to backup since going to -mm3. I've
tried patching in a CVS pull of the xfs filesystem from 9/20/2003 and
have the same results.

Any ideas? Let me know if you need more information or would like me to
try something. Thanks,

-Walt

--------------050407030401040203000809
Content-Type: text/plain;
 name="fstab-strace.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fstab-strace.txt"

execve("/bin/cp", ["cp", "fstab.backup", "fstab"], [/* 41 vars */]) = 0
uname({sysname="Linux", nodename="waltsathlon.localhost.net", release="2.6.0-test5-mm3", version="#2 SMP Fri Sep 19 19:34:53 PDT 2003", machine="i686"}) = 0
brk(0)                                  = 0x8056000
open("/etc/ld.so.preload", O_RDONLY)    = 3
fstat64(3, {st_dev=makedev(9, 4), st_ino=1711, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=131072, st_blocks=0, st_size=0, st_atime=2003/09/19-20:20:20, st_mtime=2003/09/02-20:05:15, st_ctime=2003/09/02-20:05:15}) = 0
close(3)                                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_dev=makedev(9, 4), st_ino=606953, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=131072, st_blocks=216, st_size=107854, st_atime=2003/09/20-21:38:16, st_mtime=2003/09/20-21:06:32, st_ctime=2003/09/20-21:06:32}) = 0
mmap2(NULL, 107854, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40000000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\0305A"..., 1024) = 1024
fstat64(3, {st_dev=makedev(9, 4), st_ino=686802, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=131072, st_blocks=2840, st_size=1452573, st_atime=2003/09/20-21:38:16, st_mtime=2003/08/08-20:07:48, st_ctime=2003/09/12-07:10:22}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001b000
mmap2(0x4133c000, 1215204, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4133c000
mprotect(0x4145f000, 23268, PROT_NONE)  = 0
mmap2(0x4145f000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x122) = 0x4145f000
mmap2(0x41463000, 6884, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41463000
close(3)                                = 0
munmap(0x40000000, 107854)              = 0
brk(0)                                  = 0x8056000
brk(0x8057000)                          = 0x8057000
brk(0)                                  = 0x8057000
geteuid32()                             = 0
umask(0)                                = 022
lstat64("fstab", {st_dev=makedev(254, 4), st_ino=12583479, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=838, st_atime=2003/09/20-21:33:54, st_mtime=2003/09/19-20:11:19, st_ctime=2003/09/20-21:33:54}) = 0
stat64("fstab", {st_dev=makedev(254, 4), st_ino=12583479, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=838, st_atime=2003/09/20-21:33:54, st_mtime=2003/09/19-20:11:19, st_ctime=2003/09/20-21:33:54}) = 0
stat64("fstab.backup", {st_dev=makedev(254, 4), st_ino=12583203, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=697, st_atime=2003/09/20-08:32:58, st_mtime=2003/07/14-16:29:28, st_ctime=2003/07/15-17:38:17}) = 0
stat64("fstab", {st_dev=makedev(254, 4), st_ino=12583479, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=838, st_atime=2003/09/20-21:33:54, st_mtime=2003/09/19-20:11:19, st_ctime=2003/09/20-21:33:54}) = 0
open("fstab.backup", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_dev=makedev(254, 4), st_ino=12583203, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=697, st_atime=2003/09/20-08:32:58, st_mtime=2003/07/14-16:29:28, st_ctime=2003/07/15-17:38:17}) = 0
open("fstab", O_WRONLY|O_TRUNC|O_LARGEFILE) = -1 EPERM (Operation not permitted)
write(2, "cp: ", 4cp: )                     = 4
write(2, "cannot create regular file `fsta"..., 34cannot create regular file `fstab') = 34
write(2, ": Operation not permitted", 25: Operation not permitted) = 25
write(2, "\n", 1
)                       = 1
close(3)                                = 0
_exit(1)                                = ?

--------------050407030401040203000809--

