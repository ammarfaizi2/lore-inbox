Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTAGVBj>; Tue, 7 Jan 2003 16:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTAGVBj>; Tue, 7 Jan 2003 16:01:39 -0500
Received: from unicorn.sch.bme.hu ([152.66.208.4]:450 "EHLO unicorn.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S267599AbTAGVBi>;
	Tue, 7 Jan 2003 16:01:38 -0500
Date: Tue, 7 Jan 2003 22:10:16 +0100 (CET)
From: Pozsar Balazs <pozsy@uhulinux.hu>
X-X-Sender: pozsy@unicorn.sch.bme.hu
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] floopy driver bug in 2.4.20
Message-ID: <Pine.LNX.4.44.0301072158490.620-100000@unicorn.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I found wierd bug in the floppy driver. When I have _no_ floppy inserted
in the drive, I get the expected ENXIO every _other_ (second) time, but I
get success (!) the other times:

root@brefatox:~# dd if=/dev/zero of=/dev/fd0u1440 bs=1440k count=1; echo
$?
dd: opening `/dev/fd0u1440': No such device or address
1
root@brefatox:~# dd if=/dev/zero of=/dev/fd0u1440 bs=1440k count=1; echo
$?
1+0 records in
1+0 records out
0
root@brefatox:~# dd if=/dev/zero of=/dev/fd0u1440 bs=1440k count=1; echo
$?
dd: opening `/dev/fd0u1440': No such device or address
1
root@brefatox:~# dd if=/dev/zero of=/dev/fd0u1440 bs=1440k count=1; echo
$?
1+0 records in
1+0 records out
0
root@brefatox:~# dd if=/dev/zero of=/dev/fd0u1440 bs=1440k count=1; echo
$?
dd: opening `/dev/fd0u1440': No such device or address
1
root@brefatox:~# dd if=/dev/zero of=/dev/fd0u1440 bs=1440k count=1; echo
$?
1+0 records in
1+0 records out
0
root@brefatox:~#

...and so on...

Why is this?


root@brefatox:~# dd --version
dd (coreutils) 4.5.4
...

-- 
pozsy

