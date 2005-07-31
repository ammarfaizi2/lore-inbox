Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263235AbVGaOHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbVGaOHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 10:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbVGaOHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 10:07:20 -0400
Received: from p5486E77F.dip.t-dialin.net ([84.134.231.127]:21433 "EHLO
	fujitsu.ti") by vger.kernel.org with ESMTP id S263235AbVGaOHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 10:07:13 -0400
Message-ID: <20050731160704.eopkg4w04ggcg8kc@www.fujitsu.ti>
X-Priority: 3 (Normal)
Date: Sun, 31 Jul 2005 16:07:04 +0200
From: Tobias <kernelmail@icht.homelinux.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11.3 2.6.11.6 2.6.12  2.6.13rc3 Badness in blk_remove_plug at
	drivers/block/ll_rw_blk.c:1424
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Originating-IP: 192.168.0.1
X-Remote-Browser: Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.7.10)
	Gecko/20050720 Firefox/1.0.6
X-Hordeserver: www.fujitsu.ti
X-Hordehttps: on
X-horde-session: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I tried
2.6.11.3
2.6.11.6
2.6.12
2.6.13rc3

In all these Kernels syslog reports me every few minutes log-entries like this

Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
 [<c0249559>] blk_remove_plug+0x69/0x70
 [<c024957a>] __generic_unplug_device+0x1a/0x30
 [<c024ac88>] __make_request+0x248/0x5a0
 [<c0140583>] mempool_alloc+0x33/0x110
 [<c0131240>] autoremove_wake_function+0x0/0x60
 [<c024b3ed>] generic_make_request+0x11d/0x210
 [<c0131240>] autoremove_wake_function+0x0/0x60
 [<c013cfaf>] find_lock_page+0xaf/0xe0
 [<c0131240>] autoremove_wake_function+0x0/0x60
 [<c0140583>] mempool_alloc+0x33/0x110
 [<d8f315b2>] _pagebuf_lookup_pages+0x1a2/0x2f0 [xfs]
 [<c024b536>] submit_bio+0x56/0xf0
 [<c0163ca0>] bio_alloc_bioset+0x130/0x1f0
 [<c0164244>] bio_add_page+0x34/0x40
 [<d8f325ef>] _pagebuf_ioapply+0x19f/0x2d0 [xfs]
 [<c0116cc0>] default_wake_function+0x0/0x20
 [<c0116cc0>] default_wake_function+0x0/0x20
 [<d8f32768>] pagebuf_iorequest+0x48/0x1b0 [xfs]
 [<c0116cc0>] default_wake_function+0x0/0x20
 [<c0116cc0>] default_wake_function+0x0/0x20
 [<d8f39268>] xfs_bdstrat_cb+0x38/0x50 [xfs]
 [<d8f322b6>] pagebuf_iostart+0x46/0xa0 [xfs]
 [<d8f39230>] xfs_bdstrat_cb+0x0/0x50 [xfs]
 [<d8f0bbe8>] xfs_iflush+0x2b8/0x4e0 [xfs]
 [<d8f2c867>] xfs_inode_flush+0x157/0x220 [xfs]
 [<d8f399f0>] linvfs_write_inode+0x40/0x80 [xfs]
 [<c0185fa2>] __sync_single_inode+0x132/0x270
 [<c018611f>] __writeback_single_inode+0x3f/0x180
 [<c0108b78>] enable_8259A_irq+0x48/0x90
 [<c013b591>] __do_IRQ+0x111/0x160
 [<c0186405>] sync_sb_inodes+0x1a5/0x300
 [<c018664d>] writeback_inodes+0xed/0x130
 [<c0143806>] wb_kupdate+0xb6/0x140
 [<c0144400>] pdflush+0x0/0x30
 [<c01442d8>] __pdflush+0xd8/0x200
 [<c0144426>] pdflush+0x26/0x30
 [<c0143750>] wb_kupdate+0x0/0x140
 [<c0144400>] pdflush+0x0/0x30
 [<c0130ca9>] kthread+0xa9/0xf0
 [<c0130c00>] kthread+0x0/0xf0
 [<c0101395>] kernel_thread_helper+0x5/0x10


In bugzilla I found it here to:

http://bugzilla.kernel.org/show_bug.cgi?id=4837


First I reportet it here :

http://bugzilla.kernel.org/show_bug.cgi?id=4438


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
( http://www.horde.org )

