Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290573AbSARA4y>; Thu, 17 Jan 2002 19:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290572AbSARA4q>; Thu, 17 Jan 2002 19:56:46 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:10379
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S290571AbSARA40>; Thu, 17 Jan 2002 19:56:26 -0500
Date: Thu, 17 Jan 2002 16:56:21 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: OOPs reading audio data from CD, ide-cd.
Message-ID: <Pine.LNX.4.33.0201171642330.1928-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After reading in a load of CDs with cdparanoia, I got the following
oopses. It got about half way through a CD.

I had a similar looking problem a week or so ago (on a different CD) -
after rebooting, I think I was able to read the CD.

My load average has gone up to about 13, although top is not showing
increased CPU usage for any process. Both top and ps, however, are showing
a load of the kernel processes as status W (which it says means swapped
out??)

    2 ?        SW     0:03 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        SW     0:29 [kswapd]
    5 ?        SW     0:00 [bdflush]
    6 ?        SW     0:02 [kupdated]
    8 ?        SW     0:00 [khubd]
   11 ?        SW     2:04 [kjournald]
  125 ?        SW     3:08 [kjournald]
  126 ?        SW     0:01 [kjournald]
  127 ?        SW     2:54 [kjournald]
  128 ?        SW     4:11 [kjournald]
  478 ?        SW     0:00 [houselan]
  560 ?        SW     0:00 [upstream]

(478,560 are the renamed names of eth0 and eth1)

cdparanoia died the first time the oops happened, with a segfault. I ran
it again, same happened, but the third time it is stuck running - kill -9
doesn't help.

I'm using ide-cd as a module. Its on hdc. There is nothing attached to
hdd.


The kernel seems to have ksymoopsed itself automatically, so I haven't run
this log through it again.

Jan 17 14:59:26 barbarella kernel: hdc: irq timeout: status=0xd0 { Busy }
Jan 17 14:59:26 barbarella kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Jan 17 14:59:26 barbarella kernel:  printing eip:
Jan 17 14:59:26 barbarella kernel: d0ed44ce
Jan 17 14:59:26 barbarella kernel: *pde = 00000000
Jan 17 14:59:26 barbarella kernel: Oops: 0000
Jan 17 14:59:26 barbarella kernel: CPU:    0
Jan 17 14:59:26 barbarella kernel: EIP:    0010:[<d0ed44ce>]    Not tainted
Jan 17 14:59:26 barbarella kernel: EFLAGS: 00010282
Jan 17 14:59:26 barbarella kernel: eax: fffffffb   ebx: c2d9b8d8   ecx: 00000001   edx: 00000000
Jan 17 14:59:26 barbarella kernel: esi: 0000000a   edi: c2d9b808   ebp: c02c849c   esp: c2d9b808
Jan 17 14:59:26 barbarella kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 14:59:26 barbarella kernel: Process cdparanoia (pid: 13399, stackpage=c2d9b000)
Jan 17 14:59:26 barbarella kernel: Stack: c02c849c c02c849c 00002000 00000000 00000000 00000000 00000000 00000220
Jan 17 14:59:26 barbarella kernel:        ffffffff 00001600 00000001 00000000 00000000 00000000 00000000 00000000
Jan 17 14:59:26 barbarella kernel:        00000000 00000000 c2d9b8d8 00000000 c2d9b7d4 00000000 00000000 00000000
Jan 17 14:59:26 barbarella kernel: Call Trace: [<d095522b>] [handle_IRQ_event+58/112] [<d0ed53f2>] [do_page_fault+0/1232] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-336953/96]
Jan 17 14:59:26 barbarella kernel: Call Trace: [<d095522b>] [<c0109b6a>] [<d0ed53f2>] [<c0113710>] [<d08aabc7>]
Jan 17 14:59:26 barbarella kernel:    [<d0ed9720>] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-331608/96] [handle_IRQ_event+58/112] [<d0ed9720>] [ide_multwrite+204/240] [ide_set_handler+88/96]
Jan 17 14:59:26 barbarella kernel:    [<d0ed9720>] [<d08ac0a8>] [<c0109b6a>] [<d0ed9720>] [<c019cf0c>] [<c0194658>]
Jan 17 14:59:26 barbarella kernel:    [multwrite_intr+98/176] [multwrite_intr+0/176] [ide_intr+243/336] [handle_IRQ_event+58/112] [do_IRQ+104/176] [do_IRQ+140/176]
Jan 17 14:59:26 barbarella kernel:    [<c019cf92>] [<c019cf30>] [<c0195f13>] [<c0109b6a>] [<c0109ce8>] [<c0109d0c>]
Jan 17 14:59:26 barbarella kernel:    [<d0ed9720>] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-334684/96] [<d0ed9720>] [pci_pool_free+26/224] [<d0954d9f>] [<d095509e>]
Jan 17 14:59:26 barbarella kernel:    [<d0ed9720>] [<d08ab4a4>] [<d0ed9720>] [<c01a922a>] [<d0954d9f>] [<d095509e>]
Jan 17 14:59:26 barbarella kernel:    [handle_IRQ_event+58/112] [pci_pool_free+26/224] [do_get_write_access+1388/1424] [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848]
Jan 17 14:59:26 barbarella kernel:    [<c0109b6a>] [<c01a922a>] [<c015dc9c>] [<c015e317>] [<c015807a>] [<c01580d5>]
Jan 17 14:59:26 barbarella kernel:    [ext3_reserve_inode_write+49/176] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-16862/96] [ext3_mark_iloc_dirty+36/80] [ext3_mark_iloc_dirty+53/80] [__refile_buffer+83/96] [ext3_mark_inode_dirty+39/64]
Jan 17 14:59:26 barbarella kernel:    [<c01583d1>] [<d08f8e22>] [<c0158374>] [<c0158385>] [<c0136a03>] [<c0158477>]
Jan 17 14:59:26 barbarella kernel:    [do_get_write_access+1388/1424] [do_get_write_access+1388/1424] [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848] [ext3_reserve_inode_write+49/176]
Jan 17 14:59:26 barbarella kernel:    [<c015dc9c>] [<c015dc9c>] [<c015e317>] [<c015807a>] [<c01580d5>] [<c01583d1>]
Jan 17 14:59:26 barbarella kernel:    [__journal_file_buffer+161/464] [ext3_mark_iloc_dirty+36/80] [ext3_mark_iloc_dirty+53/80] [__wake_up+68/96] [n_tty_receive_buf+2777/2832] [do_get_write_access+1388/1424]
Jan 17 14:59:26 barbarella kernel:    [<c015ede1>] [<c0158374>] [<c0158385>] [<c01148b4>] [<c0174159>] [<c015dc9c>]
Jan 17 14:59:26 barbarella kernel:    [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848] [do_get_write_access+1388/1424] [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848]
Jan 17 14:59:26 barbarella kernel:    [<c015e317>] [<c015807a>] [<c01580d5>] [<c015dc9c>] [<c015e317>] [<c015807a>]
Jan 17 14:59:26 barbarella kernel:    [ext3_do_update_inode+805/848] [pty_write+285/304] [opost_block+384/400] [ide_ioctl+3348/3376] [write_chan+373/528] [blkdev_ioctl+38/64]
Jan 17 14:59:26 barbarella kernel:    [<c01580d5>] [<c01762cd>] [<c0173240>] [<c0198354>] [<c0174cd5>] [<c013ace6>]
Jan 17 14:59:26 barbarella kernel:    [sys_ioctl+375/400] [system_call+51/56]
Jan 17 14:59:26 barbarella kernel:    [<c0141277>] [<c010881b>]
Jan 17 14:59:26 barbarella kernel:
Jan 17 14:59:26 barbarella kernel: Code: 0f be 42 01 50 0f be 02 50 8d 85 24 01 00 00 50 68 40 91 ed
Jan 17 15:00:00 barbarella CROND[15448]: (root) CMD (   /sbin/rmmod -as)
Jan 17 15:00:00 barbarella CROND[15449]: (benc) CMD (fetchmail)
Jan 17 15:01:00 barbarella CROND[15604]: (root) CMD (run-parts /etc/cron.hourly)
[blah]
Jan 17 16:34:00 barbarella CROND[30216]: (benc) CMD (fetchmail)
Jan 17 16:34:29 barbarella kernel: hdc: irq timeout: status=0xd0 { Busy }
Jan 17 16:34:29 barbarella kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Jan 17 16:34:29 barbarella kernel:  printing eip:
Jan 17 16:34:29 barbarella kernel: d0ed44ce
Jan 17 16:34:29 barbarella kernel: *pde = 00000000
Jan 17 16:34:29 barbarella kernel: Oops: 0000
Jan 17 16:34:29 barbarella kernel: CPU:    0
Jan 17 16:34:29 barbarella kernel: EIP:    0010:[<d0ed44ce>]    Not tainted
Jan 17 16:34:29 barbarella kernel: EFLAGS: 00010282
Jan 17 16:34:29 barbarella kernel: eax: fffffffb   ebx: c071b8d8   ecx: 00000001   edx: 00000000
Jan 17 16:34:29 barbarella kernel: esi: 0000000a   edi: c071b808   ebp: c02c849c   esp: c071b808
Jan 17 16:34:29 barbarella kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 16:34:29 barbarella kernel: Process cdparanoia (pid: 29619, stackpage=c071b000)
Jan 17 16:34:29 barbarella kernel: Stack: c02c849c c02c849c 00002000 00000000 00000000 00000000 00000000 00000220
Jan 17 16:34:29 barbarella kernel:        ffffffff 00001600 00000001 00000000 00000000 00000000 00000000 00000000
Jan 17 16:34:29 barbarella kernel:        00000000 00000000 c071b8d8 00000000 c071b7d4 00000000 00000000 00000000
Jan 17 16:34:29 barbarella kernel: Call Trace: [add_blkdev_randomness+70/80] [__ide_end_request+185/224] [multwrite_intr+0/176] [multwrite_intr+134/176] [ide_intr+292/336]
Jan 17 16:34:29 barbarella kernel: Call Trace: [<c0176ef6>] [<c0198949>] [<c019cf30>] [<c019cfb6>] [<c0195f44>]
Jan 17 16:34:29 barbarella kernel:    [<d0ed53f2>] [do_page_fault+0/1232] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-336953/96] [<d0ed9720>] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-331608/96] [<d0ed9720>]
Jan 17 16:34:29 barbarella kernel:    [<d0ed53f2>] [<c0113710>] [<d08aabc7>] [<d0ed9720>] [<d08ac0a8>] [<d0ed9720>]
Jan 17 16:34:29 barbarella kernel:    [pci_pool_free+26/224] [uhci_result_isochronous+110/160] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-21068/96] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-16862/96] [handle_IRQ_event+58/112] [do_IRQ+140/176]
Jan 17 16:34:29 barbarella kernel:    [<c01a922a>] [<c01bbe2e>] [<d08f7db4>] [<d08f8e22>] [<c0109b6a>] [<c0109d0c>]
Jan 17 16:34:29 barbarella kernel:    [<d0ed9720>] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-334684/96] [<d0ed9720>] [kfree_skbmem+11/96] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-23283/96] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-16862/96]
Jan 17 16:34:29 barbarella kernel:    [<d0ed9720>] [<d08ab4a4>] [<d0ed9720>] [<c01c6c7b>] [<d08f750d>] [<d08f8e22>]
Jan 17 16:34:29 barbarella kernel:    [kfree+472/624] [kfree_skbmem+11/96] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-23283/96] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-16862/96] [qdisc_restart+20/208] [do_get_write_access+1388/1424]
Jan 17 16:34:29 barbarella kernel:    [<c012d038>] [<c01c6c7b>] [<d08f750d>] [<d08f8e22>] [<c01d07f4>] [<c015dc9c>]
Jan 17 16:34:29 barbarella kernel:    [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848] [ext3_reserve_inode_write+49/176] [ip_output+292/304] [ext3_mark_iloc_dirty+36/80]
Jan 17 16:34:29 barbarella kernel:    [<c015e317>] [<c015807a>] [<c01580d5>] [<c01583d1>] [<c01d7d24>] [<c0158374>]
Jan 17 16:34:29 barbarella kernel:    [ext3_mark_iloc_dirty+53/80] [__refile_buffer+83/96] [ext3_mark_inode_dirty+39/64] [do_get_write_access+1388/1424] [do_get_write_access+1388/1424] [journal_dirty_metadata+407/448]
Jan 17 16:34:29 barbarella kernel:    [<c0158385>] [<c0136a03>] [<c0158477>] [<c015dc9c>] [<c015dc9c>] [<c015e317>]
Jan 17 16:34:29 barbarella kernel:    [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848] [ext3_reserve_inode_write+49/176] [__journal_file_buffer+161/464] [ext3_mark_iloc_dirty+36/80] [ext3_mark_iloc_dirty+53/80]
Jan 17 16:34:29 barbarella kernel:    [<c015807a>] [<c01580d5>] [<c01583d1>] [<c015ede1>] [<c0158374>] [<c0158385>]
Jan 17 16:34:29 barbarella kernel:    [__wake_up+68/96] [n_tty_receive_buf+2777/2832] [do_get_write_access+1388/1424] [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848]
Jan 17 16:34:29 barbarella kernel:    [<c01148b4>] [<c0174159>] [<c015dc9c>] [<c015e317>] [<c015807a>] [<c01580d5>]
Jan 17 16:34:29 barbarella kernel:    [do_get_write_access+1388/1424] [journal_dirty_metadata+407/448] [ext3_do_update_inode+714/848] [ext3_do_update_inode+805/848] [__alloc_pages+65/368] [do_anonymous_page+130/160]
Jan 17 16:34:29 barbarella kernel:    [<c015dc9c>] [<c015e317>] [<c015807a>] [<c01580d5>] [<c012ecb1>] [<c0125212>]
Jan 17 16:34:29 barbarella kernel:    [do_no_page+52/288] [ide_ioctl+3348/3376] [do_page_fault+394/1232] [blkdev_ioctl+38/64] [sys_ioctl+375/400] [system_call+51/56]
Jan 17 16:34:29 barbarella kernel:    [<c0125264>] [<c0198354>] [<c011389a>] [<c013ace6>] [<c0141277>] [<c010881b>]
Jan 17 16:34:29 barbarella kernel:
Jan 17 16:34:29 barbarella kernel: Code: 0f be 42 01 50 0f be 02 50 8d 85 24 01 00 00 50 68 40 91 ed
Jan 17 16:34:47 barbarella kernel:  hdc: status timeout: status=0xd0 { Busy }
Jan 17 16:34:47 barbarella kernel: hdc: drive not ready for command
Jan 17 16:34:47 barbarella kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Jan 17 16:34:47 barbarella kernel:  printing eip:
Jan 17 16:34:47 barbarella kernel: d0ed44ce
Jan 17 16:34:47 barbarella kernel: *pde = 00000000
Jan 17 16:34:47 barbarella kernel: Oops: 0000
Jan 17 16:34:47 barbarella kernel: CPU:    0
Jan 17 16:34:47 barbarella kernel: EIP:    0010:[<d0ed44ce>]    Not tainted
Jan 17 16:34:47 barbarella kernel: EFLAGS: 00010282
Jan 17 16:34:47 barbarella kernel: eax: fffffffb   ebx: cddbde18   ecx: 00000001   edx: 00000000
Jan 17 16:34:47 barbarella kernel: esi: 0000000a   edi: cddbdd48   ebp: c02c849c   esp: cddbdd48
Jan 17 16:34:47 barbarella kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 16:34:47 barbarella kernel: Process cdparanoia (pid: 30335, stackpage=cddbd000)
Jan 17 16:34:47 barbarella kernel: Stack: c02c849c c02c849c 00002000 00000000 00000000 00000000 00000000 00000220
Jan 17 16:34:47 barbarella kernel:        ffffffff 00001600 00000001 00000000 00000000 00000000 00000000 00000000
Jan 17 16:34:47 barbarella kernel:        00000000 00000000 cddbde18 00000000 cddbdd14 00000000 00000000 00000000
Jan 17 16:34:47 barbarella kernel: Call Trace: [bd_acquire+31/144] [_devfs_get_vfs_inode+302/560] [<d0ed4b0c>] [<d0ed592a>] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-340855/96]
Jan 17 16:34:47 barbarella kernel: Call Trace: [<c013a6cf>] [<c016588e>] [<d0ed4b0c>] [<d0ed592a>] [<d08a9c89>]
Jan 17 16:34:47 barbarella kernel:    [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-340744/96] [ide_check_media_change+46/64] [check_disk_change+96/192] [af_packet:__insmod_af_packet_O/lib/modules/2.5.2/kernel/net/packet/af+-342904/96] [<d0ed666d>] [ide_open+210/256]
Jan 17 16:34:47 barbarella kernel:    [<d08a9cf8>] [<c019839e>] [<c013a990>] [<d08a9488>] [<d0ed666d>] [<c01963b2>]
Jan 17 16:34:47 barbarella kernel:    [do_open+104/288] [blkdev_open+37/48] [devfs_open+173/352] [dentry_open+230/400] [filp_open+77/96] [getname+94/160]
Jan 17 16:34:47 barbarella kernel:    [<c013aaa8>] [<c013abf5>] [<c0165bed>] [<c0134576>] [<c013447d>] [<c013d53e>]
Jan 17 16:34:47 barbarella kernel:    [sys_open+54/176] [system_call+51/56]
Jan 17 16:34:47 barbarella kernel:    [<c01347a6>] [<c010881b>]
Jan 17 16:34:47 barbarella kernel:
Jan 17 16:34:47 barbarella kernel: Code: 0f be 42 01 50 0f be 02 50 8d 85 24 01 00 00 50 68 40 91 ed
Jan 17 16:35:32 barbarella sendmail[30461]: g0I0ZWK30461: Authentication-Warning: barbarella.hawaga.org.uk: benc owned process doing -bs
Jan 17 16:35:32 barbarella sendmail[30461]: g0I0ZWK30461: from=<benc@hawaga.org.uk>, size=630, class=0, nrcpts=1, msgid=<Pine.LNX.4.33.0201171635100.1928-100000@barbarella.hawaga.org.uk>, proto=ESMTP, relay=benc@localhost
Jan 17 16:35:38 barbarella sendmail[30463]: g0I0ZWK30461: to=<smithma@ucla.edu>, delay=00:00:06, xdelay=00:00:06, mailer=esmtp, pri=30630, relay=smtp.ucla.edu. [169.232.10.52], dsn=2.0.0, stat=Sent (QAA20558 Message accepted for delivery)
Jan 17 16:37:28 barbarella su(pam_unix)[30906]: session opened for user root by benc(uid=500)
Jan 17 16:37:52 barbarella sendmail[1050]: rejecting connections on daemon MTA: load average: 12
Jan 17 16:38:37 barbarella last message repeated 3 times
Jan 17 16:38:52 barbarella sendmail[1050]: rejecting connections on daemon MTA: load average: 13
Jan 17 16:39:37 barbarella last message repeated 3 times
Jan 17 16:39:52 barbarella sendmail[1050]: rejecting connections on daemon MTA: load average: 13
Jan 17 16:40:00 barbarella CROND[31352]: (root) CMD (   /sbin/rmmod -as)
Jan 17 16:40:07 barbarella sendmail[1050]: rejecting connections on daemon MTA: load average: 13


