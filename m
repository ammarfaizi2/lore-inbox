Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbTINQah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 12:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbTINQah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 12:30:37 -0400
Received: from iafilius.xs4all.nl ([213.84.160.212]:37175 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id S261198AbTINQaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 12:30:35 -0400
Date: Sun, 14 Sep 2003 18:30:33 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: arjan@sjoerd.sjoerdnet
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Another ReiserFS (rpm database) issue (2.6.0-test5)
Message-ID: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Finally i "solved" my "rpm --rebuild" problems.

My rpm was on a reiserfs (scsi) partition, and for some while now i've got
problems. Mainly at some point i was unable to install (rpm) packages, and
"rpm --rebuild" failed or just looped forever.

In almost panic mode i tried to resque my system, and installed a similar
system (suse 8.2), copied the rpm database files to that system, and to my
surpise a "rpm --rebuilddb" went smoothly without any error or problem.

Then, copied the "fixed" rpm database files at the original place, and i
was able to install packages again, however a "rpm --rebuilddb"
looped/hanged forever.

In a more relaxed panic mode i searched for differences, and motivated by
the LargeFile ReiserFS problems, i decided i try a "rpm --rebuilddb" on a
fresh ext2 partition.
And with success!

No succes i got with the original rpmdb dir on ext2 and the rpmrebuild-dir
on reiserfs (another partition). (same problem, loops/hangs forever)

I think this problem may have started somewhere 2.5, but i can't easy test
this.

Any ideas? (except for banning reiserfs at all).

At this point i'm still able to reproduce the problems, by doing/debugging
(on a random reiserfs partition):
 strace -f rpm --rebuilddb --dbpath /images/rpmtest/rpm/
<snip>
lseek(9, 37879808, SEEK_SET)            = 37879808
write(9, "\4\0\352\377\3\0=@\342\377\324\377\342\377\0\0\0\0\0\0"..., 65536) = 65536
lseek(9, 34275328, SEEK_SET)            = 34275328
write(9, "\0\0\372\377\0\0\366\377\0\0\337\377\355\377\0\0\0\0\0"..., 65536) = 65536
lseek(9, 36110336, SEEK_SET)            = 36110336
read(9, "\4\0\354\377\3\0\n0\344\377\326\377\344\377\0\0\0\0\0\0"..., 65536) = 65536
lseek(9, 7995392, SEEK_SET)             = 7995392
read(9, "\2\0t@\0\0\366\377\0\0\341\377\357\377\0\0\0\0\0\0\0\0"..., 65536) = 65536
lseek(9, 37879808, SEEK_SET)            = 37879808
read(9, "\4\0\352\377\3\0=@\342\377\324\377\342\377\0\0\0\0\0\0"..., 65536) = 65536
lseek(9, 34275328, SEEK_SET)            = 34275328
read(9, "\0\0\372\377\0\0\366\377\0\0\337\377\355\377\0\0\0\0\0"..., 65536) = 65536
<and here it "hangs" forever>

sizes of my rpmdb files:
rpmtest # ll rpm
total 142233
drwxr-xr-x    2 root     root          320 Sep 14 18:16 .
drwxr-xr-x    5 root     root          152 Sep 14 18:20 ..
-rw-r--r--    1 root     root        16384 Sep 14 18:16 conflictsindex.rpm
-rw-r--r--    1 root     root     83431424 Sep 14 18:16 fileindex.rpm
-rw-r--r--    1 root     root        57344 Sep 14 18:16 groupindex.rpm
-rw-r--r--    1 root     root        94208 Sep 14 18:16 nameindex.rpm
-rw-r--r--    1 root     root     54840904 Sep 14 18:16 packages.rpm
-rw-r--r--    1 root     root       331776 Sep 14 18:16 providesindex.rpm
-rw-r--r--    1 root     root     42246144 Sep 14 18:16 requiredby.rpm
-rw-r--r--    1 root     root        16384 Sep 14 18:16 triggerindex.rpm

Using suse 8.2/kernel 2.6.0-test5/rpm-3.0.6-478

Please CC my when replying.

Greetings,
-- 
Arjan Filius
mailto:iafilius@xs4all.nl
