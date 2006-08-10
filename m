Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWHJNoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWHJNoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWHJNoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:44:13 -0400
Received: from tornado.reub.net ([202.89.145.182]:59555 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161256AbWHJNoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:44:12 -0400
Message-ID: <44DB3819.3050902@reub.net>
Date: Fri, 11 Aug 2006 01:43:53 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0a1 (Windows/20060809)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2   [oops: shrink_dcache_for_umount_subtree ?]
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/08/2006 10:08 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> - 2.6.18-rc3-mm1 gets mysterious udev timeouts during boot and crashes in
>   NFS.  This kernel reverts the patches which were causing that.

Just hit this one upon shutdown (no traces logged before then):

INIT: Sending processes the TERM signal
INITStopping clamd: [FAILED]
Starting killall:  Stopping clamd: [FAILED]
[  OK  ]
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Saving random seed:
Syncing hardware clock to system time
Turning off swap:
Unmounting file systems:  umount2: Device or resource busy
umount: /var/www/html: device is busy
umount2: Device or resource busy
umount: /var/www/html: device is busy
BUG: Dentry ffff81003d0f34f0{i=3,n=.reiserfs_priv} still in use (1) [unmount of 
reiserfs sdc8]
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/dcache.c:611
invalid opcode: 0000 [1] SMP
last sysfs file: 
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/bInterfaceProtocol
CPU 0
Modules linked in: ipv6 ip_gre binfmt_misc i2c_i801 iTCO_wdt serio_raw
Pid: 22715, comm: umount Not tainted 2.6.18-rc3-mm2 #1
RIP: 0010:[<ffffffff802ce943>]  [<ffffffff802ce943>] 
shrink_dcache_for_umount_subtree+0x1a3/0x2a7
RSP: 0018:ffff81002ec6fd98  EFLAGS: 00010292
RAX: 0000000000000062 RBX: ffff81003d0f34f0 RCX: 0000000000000003
RDX: 0000000000000008 RSI: ffff810035224740 RDI: ffff810035224040
RBP: ffff81002ec6fdb8 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff80216800 R11: 0000000000000000 R12: ffff81003d0f34f0
R13: ffff8100025b2ce8 R14: ffff81002f936d30 R15: 0000000000000000
FS:  00002b532ecdd4b0(0000) GS:ffffffff808b5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b532ecd0000 CR3: 000000003273e000 CR4: 00000000000006e0
Process umount (pid: 22715, threadinfo ffff81002ec6e000, task ffff810035224040)
Stack:  ffff81003d29c980 ffff81003d29c588 ffffffff80595640 ffff81002ec6fea8
  ffff81002ec6fdd8 ffffffff802ceea9 ffffffff805955e0 ffff81003d29c588
  ffff81002ec6fe08 ffffffff802c6944 ffff81002f936d30 ffff81003e99e2c0
Call Trace:
  [<ffffffff802ceea9>] shrink_dcache_for_umount+0x37/0x6e
  [<ffffffff802c6944>] generic_shutdown_super+0x24/0x151
  [<ffffffff802c6a97>] kill_block_super+0x26/0x3b
  [<ffffffff802c6b65>] deactivate_super+0x4c/0x67
  [<ffffffff8022d061>] mntput_no_expire+0x58/0x92
  [<ffffffff80232562>] path_release_on_umount+0x1d/0x2b
  [<ffffffff802d1182>] sys_umount+0x252/0x29b
  [<ffffffff8025f45e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:


Code: 0f 0b 68 c9 47 4c 80 c2 63 02 4c 8b 63 50 49 39 dc 75 05 45
RIP  [<ffffffff802ce943>] shrink_dcache_for_umount_subtree+0x1a3/0x2a7
  RSP <ffff81002ec6fd98>
  /etc/rc6.d/S01reboot: line 14: 22715 Segmentation fault      "$@"

/var/www/html:      c
/var:               mcm
Unmounting file systems (retry):<3>BUG: Dentry 
ffff81003ef61e80{i=3,n=.reiserfs_priv} still in use (1) [unmount of reiserfs sda8]
   umount2: Devic----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/dcache.c:611
invalid opcode: 0000 [2] SMP
last sysfs file: 
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/bInterfaceProtocol
CPU 1
Modules linked in: ipv6 ip_gre binfmt_misc i2c_i801 iTCO_wdt serio_raw
Pid: 22722, comm: umount Not tainted 2.6.18-rc3-mm2 #1
RIP: 0010:[<ffffffff802ce943>] e or resource bu [<ffffffff802ce943>] 
shrink_dcache_for_umount_subtree+0x1a3/0x2a7
RSP: 0018:ffff810027e1dd98  EFLAGS: 00010292
RAX: 0000000000000062 RBX: ffff81003ef61e80 RCX: 0000000000000000
sy
umount: /varRDX: ffff810015f99140 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff810027e1ddb8 R08: 0000000000000002 R09: 0000000000000001
R10: ffffffff80216800 R11: 0000000000000001 R12: ffff81003ef61e80
/www/html: devicR13: ffff8100131f3648 R14: ffff81002f936e18 R15: 0000000000000000
FS:  00002b52520af4b0(0000) GS:ffff81003f6eb430(0000) knlGS:0000000000000000
e is busy
umounCS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fff58a02ea0 CR3: 000000002ec49000 CR4: 00000000000006e0
t2: Device or reProcess umount (pid: 22722, threadinfo ffff810027e1c000, task 
ffff810015f99140)
Stack:  ffff81003d29d198 ffff81003d29cda0 ffffffff80595640 ffff810027e1dea8
  ffff810027e1ddd8 ffffffff802ceea9 ffffffff805955e0 ffff81003d29cda0
  ffff810027e1de08 ffffffff802c6944 ffff81002f936e18 ffff81003ebaa938
Call Trace:
source busy
umo [<ffffffff802ceea9>] shrink_dcache_for_umount+0x37/0x6e
unt: /var/www/ht [<ffffffff802c6944>] generic_shutdown_super+0x24/0x151
ml: device is bu [<ffffffff802c6a97>] kill_block_super+0x26/0x3b
sy
  [<ffffffff802c6b65>] deactivate_super+0x4c/0x67
  [<ffffffff8022d061>] mntput_no_expire+0x58/0x92
  [<ffffffff80232562>] path_release_on_umount+0x1d/0x2b
  [<ffffffff802d1182>] sys_umount+0x252/0x29b
  [<ffffffff8025f45e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:


Code: 0f 0b 68 c9 47 4c 80 c2 63 02 4c 8b 63 50 49 39 dc 75 05 45
RIP  [<ffffffff802ce943>] shrink_dcache_for_umount_subtree+0x1a3/0x2a7
  RSP <ffff810027e1dd98>
  /etc/rc6.d/S01reboot: line 14: 22722 Segmentation fault      "$@"

/var/www/html:      c
/var:               mcm

Yes, there are bits of the shutdown mixed in which doesn't really help readability.

The reason I shut the box down was due to yum hanging and becoming a 'D' process 
which was unkillable.

What is strange is that /var/www/html should not be busy as there are no mounts 
underneath it.  It's just a standard ext3 partition.

[root@tornado ~]# mount
/dev/md0 on / type ext3 (rw)
none on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)
/dev/sda1 on /boot type ext3 (rw)
/dev/md1 on /home type ext3 (rw)
/dev/md2 on /var type ext3 (rw)
/dev/md3 on /var/www/html type ext3 (rw)
/dev/md4 on /var/www/cgi-bin type ext3 (rw)
/dev/md5 on /store type ext3 (rw)
/dev/sda8 on /var/spool/squid-1 type reiserfs (rw,noatime,notail)
/dev/sdc8 on /var/spool/squid-2 type reiserfs (rw,noatime,notail)
/dev/sda9 on /tmp type ext3 (rw)
/dev/shm on /var/spool/amavisd/tmp type tmpfs (rw,size=25m,mode=700,uid=101,gid=511)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
[root@tornado ~]#

Looks identical to 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0606.3/2802.html which hasn't 
appeared since then.  I remember it was reproduceable at the time, but 
disappeared for a while and just came back before..

Reuben



