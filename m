Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbSI0ScT>; Fri, 27 Sep 2002 14:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbSI0ScT>; Fri, 27 Sep 2002 14:32:19 -0400
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:29454 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S262517AbSI0ScR>; Fri, 27 Sep 2002 14:32:17 -0400
Date: Fri, 27 Sep 2002 14:37:21 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.38] loop trying to go beyond end of device
Message-ID: <Pine.LNX.4.43.0209271435580.31962-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. With the 2.5.38 kernel (preempt enabled), I am getting these errors
when I try to fill up a loop-mounted ext3 or ext2 partition.

The want number starts at 100002, and keeps going up and up and up by 2.

loop(7,2): rw=1, want=100316, limit=100000
attempt to access beyond end of device
loop(7,2): rw=1, want=100318, limit=100000
attempt to access beyond end of device

I can reproduce this with this script:

touch /tmp/foo
mke2fs -j -F /tmp/foo 10000
mkdir /mnt/tmp
mount -o loop /tmp/foo /mnt/tmp
cd /mnt/tmp
dd if=/dev/urandom of=blah


As the partition fills up, I start getting the above message.


Linux version 2.5.38 (root@razor) (gcc version 2.95.4 20011002 (Debian
prerelease)) #5 Fri Sep 27 10:00:24 EST 2002

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461





