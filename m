Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262063AbREYXsz>; Fri, 25 May 2001 19:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbREYXsp>; Fri, 25 May 2001 19:48:45 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:43258 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262063AbREYXsd>; Fri, 25 May 2001 19:48:33 -0400
Message-Id: <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 26 May 2001 00:49:07 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: ANN: NTFS new release available (1.1.15)
Cc: Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-ntfs-announce@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing a new NTFS patch (1.1.15). It is generated against kernel 
2.4.4-ac16 but also applies cleanly to -ac17. Quite probably it will apply 
fine to any 2.4.4 kernel (at least 2.4.4-pre5 I think).

How to get the patch
====================

- Wait for one of the next -ac series kernel patches (patch is submitted to 
Alan Cox).
- For the impatient: patch is available (for a while only, for some value 
of while) for download as bzip2 or gzip compressed file from:
         http://www-stu.christs.cam.ac.uk/~aia21/ntfs/
(To apply patch, uncompress it, cd into your kernel directory and type:
         patch -p1 < 
/path/to/patch/ntfs-kernel-2.4.4-ac16-to-ntfs-1.1.15.diff.gz
Then you will need to recompile your kernel and reboot into it.)

NTFS 1.1.15 - ChangeLog
=======================

- New mount option show_sys_files=<bool> to show all system files as normal 
files.
- Support for files and in general any attributes up to the full 2TiB size 
supported by the NTFS filesystem. Note we only support up to 32-bits worth 
of inodes/clusters at this point.
- Support for more than 128kiB sized runlists (using vmalloc_32() instead 
of kmalloc()).
- Fixed races in allocation of clusters and mft records.
- Fixed major bugs in attribute handling / searching / collation.
- Fixed major bugs in compressing a run list into a mapping pairs array.
- Fixed major bugs in inode allocation. Especially file create and mkdir.
- Fixed memory leaks.
- Fixed major bug in inode layout assignment of sequence numbers.
- Lots of other bug fixes I can't think of right now...
- Fixed NULL bug found by the Stanford checker in ntfs_dupuni2map().
- Convert large stack variable to dynamically allocated one in 
ntfs_get_free_cluster_count() (found by Stanford checker).
- New versioning scheme as I was too confused by the date based one... 
(versions prior to this are internal only, never been released to public, 
so you haven't missed the numbers before 1.1.15).

Known bugs and (mis-)features
=============================

- Do not use the driver for writing as it corrupts the file system. If you 
do use it, get the Linux-NTFS tools and use the ntfsfix utility after 
dismounting a partition you wrote to.

- Use "ls -l" instead of just "ls", otherwise the last entry in the 
directory is not displayed for some directories. (?!?)

- Use the show_sys_files mount option which should make things work 
generally better. (It results in both the short and long file names being 
shown as well as the sytem files.)

- Special characters are not treated correctly. For example if the file 
name contains an apostrophe you will not be able to open it.

- Writing of extension records is not supported properly.

Please send bug reports/comments/feed back/abuse to the Linux-NTFS 
development list at sourceforge: linux-ntfs-dev@lists.sourceforge.net

For daring people, write support now works ok for simple files and 
directories. For example it is relatively safe to create a directory inside 
a not too big directory, and create a few relatively small files in it. 
umount, run ntfsfix, reboot in Windows, chkdsk will run and (hopefully) not 
detect any problems at all!

Thank you for your attention.

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

