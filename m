Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311244AbSCQBoX>; Sat, 16 Mar 2002 20:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311246AbSCQBoN>; Sat, 16 Mar 2002 20:44:13 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:44295 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S311244AbSCQBoF>; Sat, 16 Mar 2002 20:44:05 -0500
Date: Sat, 16 Mar 2002 17:44:04 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: <linux-kernel@vger.kernel.org>
Subject: /dev/md0: Device or resource busy
Message-ID: <Pine.LNX.4.33.0203161709140.7016-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm using 2.4.19-pre3-ac1 (on debian woody) and i was playing with md. it
appears impossible to "raidstop /dev/md0" when i'm using the 0xfd
autodetect partition type.

i have 3 other md devices which i can stop no problem (even with 0xfd
autodetection), just not /dev/md0.

% raidstop /dev/md0
/dev/md0: Device or resource busy

i don't have any filesystem mounted on md0, and "lsof | grep md" doesn't
show anything.

% dmesg | grep md0
md: created md0
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: md0 still in use.

if i change the partition type to 0xda (is there something more
appropriate?), and let /etc/init.d/raid2 do the "raidstart /dev/md0" then
i can raidstop /dev/md0 no problem.

is there maybe a reference counting problem when 0xfd is in use?

note that my other md partitions are all 0xfd ... and i can raidstop them
just fine.  (although i have to do it in a particular order since /dev/md3
is a stripe of /dev/md{1,2}, which are mirrors. /dev/md1 happens to be
other partitions on the same disks as /dev/md0.)

-dean

