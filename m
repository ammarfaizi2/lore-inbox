Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVAUQMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVAUQMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVAUQMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:12:42 -0500
Received: from relay.muni.cz ([147.251.4.35]:65001 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262408AbVAUQMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:12:37 -0500
Date: Fri, 21 Jan 2005 17:12:30 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1-bk9 crash in mdadm
Message-ID: <20050121161230.GN3922@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Just FWIW, I've got the following crash when trying to boot a 2.6.11-rc1-bk9
kernel on my dual opteron Fedora Core 3 box. I will try -bk8 now.

-Yenya

Starting up RAID devices: md5 Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff802e219d>{__make_request+61}
PGD f9f0f067 PUD fa01b067 PMD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in: floppy
Pid: 1632, comm: mdadm Not tainted 2.6.11-rc1-bk9
RIP: 0010:[<ffffffff802e219d>] <ffffffff802e219d>{__make_request+61}
RSP: 0018:ffff8100f9f2b7f8  EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff810002d779c0
RDX: 0000000000000000 RSI: ffff8100f9f2b808 RDI: ffff81007ff8b2a8
RBP: ffff81007ff8b2a8 R08: ffff8100fae9b540 R09: 0000000000000000
R10: 00000000012a5200 R11: 0000000000000000 R12: 0000000000000000
R13: ffff81007f4e4180 R14: 0000000000000008 R15: ffff8100f9f2bab8
FS:  00002aaaaaab6b00(0000) GS:ffffffff804e9240(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000007f599000 CR4: 00000000000006e0
Process mdadm (pid: 1632, threadinfo ffff8100f9f2a000, task ffff81007f4036e0)
Stack: 00000000012a523f ffffffff80151ca4 ffff81007f4e4180 ffff8100fae9b550
       ffff81007ff8b2a8 ffff8100f9f2b878 ffff81007f4e4180 ffff81007feb6300
       ffff8100f9f2bab8 ffffffff802e2a92
Call Trace:<ffffffff80151ca4>{mempool_alloc+164} <ffffffff802e2a92>{generic_make_request+546}
       <ffffffff80146050>{autoremove_wake_function+0} <ffffffff80146050>{autoremove_wake_function+0}
       <ffffffff803187e1>{make_request+529} <ffffffff80146059>{autoremove_wake_function+9}
       <ffffffff8012cd10>{__wake_up_common+64} <ffffffff802e2a92>{generic_make_request+546}
       <ffffffff80146050>{autoremove_wake_function+0} <ffffffff80320fc0>{md_open+112}
utoremove_wake_function+0} <ffffffff802e2bc8>{submit_bio+280}
       <ffffffff8031ea2b>{sync_page_io+203} <ffffffff8031e930>{bi_complete+0}
       <ffffffff8031f863>{read_disk_sb+83} <ffffffff8031fbf5>{super_90_load+85}
       <ffffffff8032060b>{md_import_device+459} <ffffffff80155bfa>{page_cache_readahead+490}
       <ffffffff8028cccb>{radix_tree_delete+347} <ffffffff803225d8>{md_ioctl+3608}
       <ffffffff80152ae5>{__pagevec_free+37} <ffffffff8014edfb>{find_get_pages+107}
       <ffffffff802e429a>{blkdev_ioctl+1834} <ffffffff80119434>{flat_send_IPI_allbutself+20}
       <ffffffff8011734e>{__smp_call_function+110} <ffffffff80173c90>{invalidate_bh_lru+0}
       <ffffffff80178fdc>{bdev_clear_inode+28} <ffffffff80146208>{wake_up_bit+24}
       <ffffffff801845d4>{do_ioctl+116} <ffffffff80184971>{sys_ioctl+881}
       <ffffffff8010d29e>{system_call+126}

Code: 44 8b 7c 10 08 41 83 e4 01 e8 e5 9d e7 ff 48 8b bd f0 01 00
RIP <ffffffff802e219d>{__make_request+61} RSP <ffff8100f9f2b7f8>
CR2: 0000000000000008
 /etc/rc.d/rc.sysinit: line 556:  1632 Killed                  /sbin/mdadm -Ac partitions $i -m dev
Pid: 1632, comm: mdadm Not tainted 2.6.11-rc1-bk9
RIP: 0010:[<ffffffff802e219d>] <ffffffff802e219d>{__make_request+61}
RSP: 0018:ffff8100f9f2b7f8  EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff810002d779c0
RDX: 0000000000000000 RSI: ffff8100f9f2b808 RDI: ffff81007ff8b2a8
RBP: ffff81007ff8b2a8 R08: ffff8100fae9b540 R09: 0000000000000000
R10: 00000000012a5200 R11: 0000000000000000 R12: 0000000000000000
R13: ffff81007f4e4180 R14: 0000000000000008 R15: ffff8100f9f2bab8
FS:  00002aaaaaab6b00(0000) GS:ffffffff804e9240(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000007f599000 CR4: 00000000000006e0
Process mdadm (pid: 1632, threadinfo ffff8100f9f2a000, task ffff81007f4036e0)
Stack: 00000000012a523f ffffffff80151ca4 ffff81007f4e4180 ffff8100fae9b550
       ffff81007ff8b2a8 ffff8100f9f2b878 ffff81007f4e4180 ffff81007feb6300
       ffff8100f9f2bab8 ffffffff802e2a92
Call Trace:<ffffffff80151ca4>{mempool_alloc+164} <ffffffff802e2a92>{generic_make_request+546}
       <ffffffff80146050>{autoremove_wake_function+0} <ffffffff80146050>{autoremove_wake_function+0}
       <ffffffff803187e1>{make_request+529} <ffffffff80146059>{autoremove_wake_function+9}
       <ffffffff8012cd10>{__wake_up_common+64} <ffffffff802e2a92>{generic_make_request+546}
       <ffffffff80146050>{autoremove_wake_function+0} <ffffffff80320fc0>{md_open+112}
       <ffffffff80146050>{autoremove_wake_function+0} <ffffffff802e2bc8>{submit_bio+280}
       <ffffffff8031ea2b>{sync_page_io+203} <ffffffff8031e930>{bi_complete+0}
       <ffffffff8031f863>{read_disk_sb+83} <ffffffff8031fbf5>{super_90_load+85}
       <ffffffff8032060b>{md_import_device+459} <ffffffff80155bfa>{page_cache_readahead+490}
       <ffffffff8028cccb>{radix_tree_delete+347} <ffffffff803225d8>{md_ioctl+3608}
       <ffffffff80152ae5>{__pagevec_free+37} <ffffffff8014edfb>{find_get_pages+107}
       <ffffffff802e429a>{blkdev_ioctl+1834} <ffffffff80119434>{flat_send_IPI_allbutself+20}
       <ffffffff8011734e>{__smp_call_function+110} <ffffffff80173c90>{invalidate_bh_lru+0}
       <ffffffff80178fdc>{bdev_clear_inode+28} <ffffffff80146208>{wake_up_bit+24}
       <ffffffff801845d4>{do_ioctl+116} <ffffffff80184971>{sys_ioctl+881}
       <ffffffff8010d29e>{system_call+126}

Code: 44 8b 7c 10 08 41 83 e4 01 e8 e5 9d e7 ff 48 8b bd f0 01 00
RIP <ffffffff802e219d>{__make_request+61} RSP <ffff8100f9f2b7f8>
CR2: 0000000000000008
 /etc/rc.d/rc.sysinit: line 556:  1632 Killed                  /sbin/mdadm -Ac partitions $i -m dev


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
