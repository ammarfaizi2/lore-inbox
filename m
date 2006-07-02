Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWGBADl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWGBADl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGBADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:03:41 -0400
Received: from tornado.reub.net ([202.89.145.182]:58243 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932116AbWGBADk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:03:40 -0400
Message-ID: <44A70D5C.6020700@reub.net>
Date: Sun, 02 Jul 2006 12:03:40 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060701)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Weird RAID/SATA problem [ once was Re: 2.6.17-mm3 ]
References: <20060630105401.2dc1d3f3.akpm@osdl.org>	<44A5C1D5.20200@reub.net>	<17573.50871.307879.557218@cse.unsw.edu.au>	<44A5D079.6070505@reub.net>	<17573.55937.866300.638738@cse.unsw.edu.au>	<44A6390E.1030608@reub.net>	<17574.15295.828980.278323@cse.unsw.edu.au>	<44A64BD8.90906@reub.net>	<17574.21399.979888.127483@cse.unsw.edu.au>	<44A65EB7.5020201@reub.net>	<17574.25837.681984.389682@cse.unsw.edu.au>	<44A6696A.1010506@reub.net> <17574.30829.397932.205727@cse.unsw.edu.au>
In-Reply-To: <17574.30829.397932.205727@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/07/2006 1:28 a.m., Neil Brown wrote:
> On Sunday July 2, reuben-lkml@reub.net wrote:
>> BUG: warning at drivers/md/md.c:411/super_written_barrier()
>>
>> Call Trace:
>>   <IRQ> [<ffffffff80422231>] super_written_barrier+0x61/0x100
>>   [<ffffffff8023c000>] bio_endio+0x5a/0x6a
>>   [<ffffffff8022e24f>] __end_that_request_first+0x16f/0x4c9
>>   [<ffffffff8024afaa>] end_that_request_first+0xc/0xe
>>   [<ffffffff8034e825>] blk_ordered_complete_seq+0x7d/0x8c
>>   [<ffffffff8034e864>] post_flush_end_io+0x30/0x35
>>   [<ffffffff8034e748>] end_that_request_last+0xd8/0xf4
>>   [<ffffffff803d83a1>] scsi_end_request+0xb1/0xdd
>>   [<ffffffff803d87cd>] scsi_io_completion+0x3cd/0x3dc
> 
> I think the key decision to return an error is happening here in
> scsi_io_completion. 
> Pooring over a disassembly might help show here, but sticking in a
> bunch of printks is probably easier (for someone like me who has never
> seen this code before anyway :-)
> 
> What does this patch produce?
> 
> NeilBrown
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> 
> diff .prev/drivers/scsi/scsi_lib.c ./drivers/scsi/scsi_lib.c
> --- .prev/drivers/scsi/scsi_lib.c	2006-07-01 23:22:46.000000000 +1000
> +++ ./drivers/scsi/scsi_lib.c	2006-07-01 23:26:18.000000000 +1000
> @@ -952,6 +952,7 @@ void scsi_io_completion(struct scsi_cmnd

Loading ide-disk.ko module
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda10
md: sda10 has invalid sb, not importing!
md: invalid raid superblock magic on sdc10
md: sdc10 has invalid sb, not importing!
md: autorun ...
md: considering sdc11 ...
md:  adding sdc11 ...
md: sdc7 has different UUID to sdc11
md: sdc6 has different UUID to sdc11
md: sdc5 has different UUID to sdc11
md: sdc3 has different UUID to sdc11
md: sdc2 has different UUID to sdc11
md:  adding sda11 ...
md: sda7 has different UUID to sdc11
md: sda6 has different UUID to sdc11
md: sda5 has different UUID to sdc11
md: sda3 has different UUID to sdc11
md: sda2 has different UUID to sdc11
md: created md5
md: bind<sda11>
md: bind<sdc11>
md: running: <sdc11><sda11>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 10/10 pages, set 1 bits, status: 0
created bitmap (153 pages) for device md5
ouch. 0 0 0   78 98 128  0
ouch. 0 0 0   78 98 128  0
ouch. 0 0 0   207 248 1  0
raid1: Disk failure on sda11, disabling device.
         Operation continuing on 1 devices
ouch. 0 0 0   2 0 0  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
md: considering sdc7 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:1, o:0, dev:sda11
  disk 1, wo:0, o:1, dev:sdc11
md:  adding sdc7 ...
md: sdc6 has different UUID to sdc7
RAID1 conf printout:
  --- wd:1 rd:2
  disk 1, wo:0, o:1, dev:sdc11
md: sdc5 has different UUID to sdc7
md: sdc3 has different UUID to sdc7
md: sdc2 has different UUID to sdc7
md:  adding sda7 ...
md: sda6 has different UUID to sdc7
md: sda5 has different UUID to sdc7
md: sda3 has different UUID to sdc7
md: sda2 has different UUID to sdc7
md: created md4
md: bind<sda7>
md: bind<sdc7>
md: running: <sdc7><sda7>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 4/4 pages, set 2 bits, status: 0
created bitmap (61 pages) for device md4
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
raid1: Disk failure on sda7, disabling device.
         Operation continuing on 1 devices
ouch. 0 0 0   2 0 0  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
md: considering sdc6 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:1, o:0, dev:sda7
  disk 1, wo:0, o:1, dev:sdc7
md:  adding sdc6 ...
md: sdc5 has different UUID to sdc6
md: sdc3 has different UUID to sdc6
md: sdc2 has different UUID to sdc6
md:  adding sda6 ...
md: sda5 has different UUID to sdc6
md: sda3 has different UUID to sdc6
RAID1 conf printout:
  --- wd:1 rd:2
  disk 1, wo:0, o:1, dev:sdc7
md: sda2 has different UUID to sdc6
md: created md3
md: bind<sda6>
md: bind<sdc6>
md: running: <sdc6><sda6>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 1/1 pages, set 1 bits, status: 0
created bitmap (13 pages) for device md3
ouch. 0 0 0   78 98 128  0
ouch. 0 0 0   78 98 128  0
ouch. 0 0 0   143 248 1  0
raid1: Disk failure on sdc6, disabling device.
         Operation continuing on 1 devices
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
md: considering sdc5 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda6
  disk 1, wo:1, o:0, dev:sdc6
md:  adding sdc5 ...
md: sdc3 has different UUID to sdc5
md: sdc2 has different UUID to sdc5
md:  adding sda5 ...
md: sda3 has different UUID to sdc5
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda6
md: sda2 has different UUID to sdc5
md: created md2
md: bind<sda5>
md: bind<sdc5>
md: running: <sdc5><sda5>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 10/10 pages, set 16 bits, status: 0
created bitmap (150 pages) for device md2
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
raid1: Disk failure on sda5, disabling device.
         Operation continuing on 1 devices
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
md: considering sdc3 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:1, o:0, dev:sda5
  disk 1, wo:0, o:1, dev:sdc5
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
md:  adding sda3 ...
md: sda2 has different UUID to sdc3
md: created md1
md: bind<sda3>
md: bind<sdc3>
RAID1 conf printout:
  --- wd:1 rd:2
  disk 1, wo:0, o:1, dev:sdc5
md: running: <sdc3><sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 10/10 pages, set 2 bits, status: 0
created bitmap (150 pages) for device md1
ouch. 0 0 0   78 98 128  0
ouch. 0 0 0   78 98 128  0
ouch. 0 0 0   143 248 1  0
raid1: Disk failure on sdc3, disabling device.
         Operation continuing on 1 devices
ouch. 0 0 0   2 0 0  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
ouch. 0 0 0   207 248 1  0
md: considering sdc2 ...
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda3
  disk 1, wo:1, o:0, dev:sdc3
md:  adding sdc2 ...
md:  adding sda2 ...
md: created md0
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:0, o:1, dev:sda3
md: bind<sda2>
md: bind<sdc2>
md: running: <sdc2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 100 bits, status: 0
created bitmap (187 pages) for device md0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   207 248 1  0
raid1: Disk failure on sda2, disabling device.
         Operation continuing on 1 devices
ouch. 0 0 0   2 0 0  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
ouch. 0 0 0   143 248 1  0
md: ... autorun DONE.
RAID1 conf printout:
  --- wd:1 rd:2
  disk 0, wo:1, o:0, dev:sda2
  disk 1, wo:0, o:1, dev:sdc2
Creating root device.
RAID1 conf printout:
  --- wd:1 rd:2
  disk 1, wo:0, o:1, dev:sdc2
Mounting root filesystem.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Setting up other filesystems.
Setting up new root fs
no fstab.sys, mounting internal defaults
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /proc/bus/usb
ERROR unmounting old /proc/bus/usb: No such file or directory
forcing unmount of /proc/bus/usb
unmounting old /sys
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1151798137.896:2): selinux=0 auid=4294967295
INIT: version 2.86 booting
                 Welcome to Fedora Core
                 Press 'I' to enter interactive startup.
Setting clock  (utc): Sun Jul  2 11:55:41 NZST 2006 [  OK  ]
Starting udev: [  OK  ]
Setting hostname tornado.reub.net:  [  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1
/dev/sda1: clean, 50/6024 files, 23798/24064 blocks (check in 3 mounts)
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local swap partitions:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
sh-3.1#
sh-3.1#
sh-3.1# cat /proc/mdstat
Personalities : [raid1]
md1 : active raid1 sdc3[2](F) sda3[0]
       4891712 blocks [2/1] [U_]
       bitmap: 1/150 pages [4KB], 16KB chunk

md2 : active raid1 sdc5[1] sda5[2](F)
       4891648 blocks [2/1] [_U]
       bitmap: 7/150 pages [28KB], 16KB chunk

md3 : active raid1 sdc6[2](F) sda6[0]
       104320 blocks [2/1] [U_]
       bitmap: 1/13 pages [4KB], 4KB chunk

md4 : active raid1 sdc7[1] sda7[2](F)
       497856 blocks [2/1] [_U]
       bitmap: 4/61 pages [16KB], 4KB chunk

md5 : active raid1 sdc11[1] sda11[2](F)
       20008832 blocks [2/1] [_U]
       bitmap: 1/153 pages [4KB], 64KB chunk

md0 : active raid1 sdc2[1] sda2[2](F)
       24410688 blocks [2/1] [_U]
       bitmap: 6/187 pages [24KB], 64KB chunk

unused devices: <none>
sh-3.1#
sh-3.1# mdadm --add /dev/md5 /dev/sda11
mdadm: Cannot open /dev/sda11: Device or resource busy
sh-3.1# mdadm --add /dev/md5 /dev/sdc11
mdadm: Cannot open /dev/sdc11: Device or resource busy
sh-3.1#
sh-3.1#
sh-3.1# mdadm --add /dev/md4 /dev/sda7
mdadm: Cannot open /dev/sda7: Device or resource busy
sh-3.1#
sh-3.1#
sh-3.1# mdadm --add /dev/md0 /dev/sda2
mdadm: Cannot open /dev/sda2: Device or resource busy
sh-3.1#

reuben
