Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRB1JnD>; Wed, 28 Feb 2001 04:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129456AbRB1Jmx>; Wed, 28 Feb 2001 04:42:53 -0500
Received: from hermes.hrz.uni-giessen.de ([134.176.2.15]:24717 "EHLO
	hermes.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id <S129440AbRB1Jmf>; Wed, 28 Feb 2001 04:42:35 -0500
Date: Wed, 28 Feb 2001 10:42:14 +0100 (CET)
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
X-X-Sender: <g059@c2.hrz.uni-giessen.de>
To: <linux-kernel@vger.kernel.org>
Subject: raid, reiser problems
Message-Id: <Pine.A41.4.33.0102281021260.47888-100000@c2.hrz.uni-giessen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm using kernel 2.4.2 + raid/reiser patches (26. Feb) + zerocopy + loop6.
When trying to start my 4 SCSI-HD raid5/reiserfs array, I get the
following errors:

 kernel: (read) [dev 08:01]'s sb offset: 8956096 [events: 00000006]
 kernel: (read) [dev 08:11]'s sb offset: 8956096 [events: 00000006]
 kernel: (read) [dev 08:21]'s sb offset: 8956096 [events: 00000008]
 kernel: (read) [dev 08:31]'s sb offset: 8956096 [events: 00000008]
 kernel: autorun ...
 kernel: considering [dev 08:31] ...
 kernel:   adding [dev 08:31] ...
 kernel:   adding [dev 08:21] ...
 kernel:   adding [dev 08:11] ...
 kernel:   adding [dev 08:01] ...
 kernel: created md0
 kernel: bind<[dev 08:01],1>
 kernel: bind<[dev 08:11],2>
 kernel: bind<[dev 08:21],3>
 kernel: bind<[dev 08:31],4>
 kernel: running: <[dev 08:31]><[dev 08:21]><[dev 08:11]><[dev 08:01]>
 kernel: now!

 kernel: [dev 08:31]'s event counter: 00000008
 kernel: [dev 08:21]'s event counter: 00000008
 kernel: [dev 08:11]'s event counter: 00000006
 kernel: [dev 08:01]'s event counter: 00000006
 kernel: md: superblock update time inconsistency -- using the most recent one

 kernel: freshest: [dev 08:31]
 kernel: md: kicking non-fresh [dev 08:11] from array!
 kernel: unbind<[dev 08:11],3>
 kernel: export_rdev([dev 08:11])
 kernel: md: kicking non-fresh [dev 08:01] from array!
 kernel: unbind<[dev 08:01],2>
 kernel: export_rdev([dev 08:01])
 kernel: md0: former device [dev 08:01] is unavailable, removing from array!
 kernel: md0: former device [dev 08:11] is unavailable, removing from array!
 kernel: md: md0: raid array is not clean -- starting background reconstruction
 kernel: md0: max total readahead window set to 3072k
 kernel: md0: 3 data-disks, max readahead per data-disk: 1024k
 kernel: raid5: device [dev 08:31] operational as raid disk 3
 kernel: raid5: device [dev 08:21] operational as raid disk 2
 kernel: raid5: not enough operational devices for md0 (2/4 failed)
 kernel: RAID5 conf printout:
 kernel:  --- rd:4 wd:2 fd:2
 kernel:  disk 0, s:0, o:0, n:0 rd:0 us:1 dev:[dev 00:00]
 kernel:  disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:[dev 08:21]
 kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:[dev 08:31]
 kernel: raid5: failed to run raid set md0
 kernel: raid5: failed to run raid set md0
 kernel: pers->run() failed ...
 kernel: do_md_run() returned -22
 kernel: md0 stopped.
 kernel: unbind<[dev 08:31],1>
 kernel: export_rdev([dev 08:31])
 kernel: unbind<[dev 08:21],0>
 kernel: export_rdev([dev 08:21])
 kernel: ... autorun DONE.

It seems that the mountcounter are different, but I allways mount/unmount
them together. Older kernels (2.4.2 with older reiser/raid patches (24.
Feb?), without zerocopy) worked fine. Is there a way to mount it again or
is this a bug in raid code?

Thanks and greetings

Marc Dietrich



