Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUBVPt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUBVPt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:49:56 -0500
Received: from foo.ardendo.se ([212.32.189.9]:34565 "EHLO foo.ardendo.se")
	by vger.kernel.org with ESMTP id S261595AbUBVPtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:49:43 -0500
Date: Sun, 22 Feb 2004 16:49:41 +0100
From: Mikael Wahlberg <Mikael.Wahlberg@ardendo.se>
To: linux-kernel@vger.kernel.org
Subject: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!)
Message-ID: <20040222164941.D6046@foo.ardendo.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:

On heavy FTP Load (About 1Gbit/s) running both reads and writes on two ServeRAID6m Raid5 controllers merged together to one filesystem with Raidtools we see the error below. The filesystem gets totally hanged up. Currently with XFS, but JFS gets the same problem (Actually even more often).

Anybody has got a good idea what can be wrong? 

Distribution:
RedHat 9.0

Hardware:
IBM x345
2x2.4GHz Xeon
2xServeRAID6m

Error:
(/var/log/messages)
Feb 22 15:00:51 mserv1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 000002a6
Feb 22 15:00:52 mserv1 kernel:  printing eip:
Feb 22 15:00:52 mserv1 kernel: c011e5b5
Feb 22 15:00:52 mserv1 kernel: *pde = 00000000
Feb 22 15:00:52 mserv1 kernel: Oops: 0002 [#1]
Feb 22 15:00:52 mserv1 kernel: CPU:    1
Feb 22 15:00:52 mserv1 kernel: EIP:    0060:[<c011e5b5>]    Not tainted
Feb 22 15:00:52 mserv1 kernel: EFLAGS: 00010003
Feb 22 15:00:52 mserv1 kernel: Process proftpd (pid: 7432, threadinfo=ee530000 task=ef59a6b0)
Feb 22 15:00:52 mserv1 kernel: Stack: c011e54a ee531a28 00000003 00000000 ddcdfeec ee530000 ddcdfee8 00000292
Feb 22 15:00:53 mserv1 kernel:        ee531a50 c011e5af ddcdfee8 00000003 00000001 00000000 ddcdfee0 ddcdfe50
Feb 22 15:00:53 mserv1 kernel:        00000000 f5e36000 c0259e62 c0259b00 000000c8 c023038e ddcdfee0 000b2f80
Feb 22 15:00:53 mserv1 kernel: Call Trace:
Feb 22 15:00:53 mserv1 kernel:  [<c011e54a>] __wake_up_common+0x3a/0x60
Feb 22 15:00:53 mserv1 kernel:  [<c011e5af>] __wake_up+0x3f/0x70
Feb 22 15:00:53 mserv1 kernel:  [<c0259e62>] mrunlock+0x82/0xb0
Feb 22 15:00:53 mserv1 kernel:  [<c0259b00>] mraccessf+0xc0/0xe0
Feb 22 15:00:53 mserv1 kernel:  [<c023038e>] xfs_iunlock+0x3e/0x80
Feb 22 15:00:53 mserv1 kernel:  [<c023727b>] xfs_iomap+0x3bb/0x540
Feb 22 15:00:53 mserv1 kernel:  [<c0163fc7>] bio_alloc+0xd7/0x1c0
Feb 22 15:00:53 mserv1 kernel:  [<c025a17a>] map_blocks+0x7a/0x170
Feb 22 15:00:53 mserv1 kernel:  [<c025b40b>] page_state_convert+0x52b/0x6d0
Feb 22 15:00:53 mserv1 kernel:  [<c0236cb9>] xfs_imap_to_bmap+0x39/0x240
Feb 22 15:00:53 mserv1 kernel:  [<c025be48>] linvfs_release_page+0xa8/0xb0
Feb 22 15:00:53 mserv1 kernel:  [<c025bce0>] linvfs_writepage+0x60/0x120
Feb 22 15:00:53 mserv1 kernel:  [<c014990c>] shrink_list+0x41c/0x710
Feb 22 15:00:53 mserv1 kernel:  [<c0149df8>] shrink_cache+0x1f8/0x3d0
Feb 22 15:00:53 mserv1 kernel:  [<c01b3a00>] journal_stop+0x220/0x330
Feb 22 15:00:53 mserv1 kernel:  [<c014a6dc>] shrink_zone+0xbc/0xc0
Feb 22 15:00:53 mserv1 kernel:  [<c014a7a5>] shrink_caches+0xc5/0xe0
Feb 22 15:00:54 mserv1 kernel:  [<c014a87c>] try_to_free_pages+0xbc/0x190
Feb 22 15:00:54 mserv1 kernel:  [<c0143043>] __alloc_pages+0x203/0x370
Feb 22 15:00:54 mserv1 kernel:  [<c01431d5>] __get_free_pages+0x25/0x40
Feb 22 15:00:54 mserv1 kernel:  [<c0173241>] __pollwait+0x41/0xd0
Feb 22 15:00:54 mserv1 kernel:  [<c0358f93>] tcp_poll+0x33/0x190
Feb 22 15:00:54 mserv1 kernel:  [<c032b0f9>] sock_poll+0x29/0x40
Feb 22 15:00:54 mserv1 kernel:  [<c01736b7>] do_select+0x2f7/0x320
Feb 22 15:00:54 mserv1 kernel:  [<c0173200>] __pollwait+0x0/0xd0
Feb 22 15:00:54 mserv1 kernel:  [<c0173a12>] sys_select+0x302/0x540
Feb 22 15:00:54 mserv1 kernel:  [<c010b08b>] syscall_call+0x7/0xb
Feb 22 15:00:54 mserv1 kernel:
Feb 22 15:00:54 mserv1 kernel: Code: ff 4b 14 8b 43 08 83 e0 08 75 0d 8b 5d f4 8b 75 f8 8b 7d fc
Feb 22 15:00:54 mserv1 kernel:  [<c0173a12>] sys_select+0x302/0x540
Feb 22 15:00:54 mserv1 kernel:  [<c010b08b>] syscall_call+0x7/0xb
Feb 22 15:00:54 mserv1 kernel:
Feb 22 15:00:54 mserv1 kernel: Code: ff 4b 14 8b 43 08 83 e0 08 75 0d 8b 5d f4 8b 75 f8 8b 7d fc
Feb 22 15:00:54 mserv1 kernel:  <6>note: proftpd[7432] exited with preempt_count 2
Feb 22 15:00:54 mserv1 kernel: bad: scheduling while atomic!
Feb 22 15:00:54 mserv1 kernel: Call Trace:
Feb 22 15:00:54 mserv1 kernel:  [<c011e48e>] schedule+0x6ee/0x700
Feb 22 15:00:54 mserv1 kernel:  [<c014cdeb>] zap_pmd_range+0x4b/0x70
Feb 22 15:00:54 mserv1 kernel:  [<c01591ba>] free_pages_and_swap_cache+0x6a/0xa0
Feb 22 15:00:54 mserv1 kernel:  [<c014d0cc>] unmap_vmas+0x23c/0x2f0
Feb 22 15:00:54 mserv1 kernel:  [<c0151774>] exit_mmap+0xf4/0x250
Feb 22 15:00:54 mserv1 kernel:  [<c0120d2d>] mmput+0x6d/0xa0
Feb 22 15:00:54 mserv1 kernel:  [<c0125a33>] do_exit+0x1a3/0x500
Feb 22 15:00:54 mserv1 kernel:  [<c010c1ac>] die+0xfc/0x100
Feb 22 15:00:54 mserv1 kernel:  [<c011b349>] do_page_fault+0x1f9/0x523
Feb 22 15:00:54 mserv1 kernel:  [<c0141bab>] mempool_alloc+0x8b/0x190
Feb 22 15:00:54 mserv1 kernel:  [<c011b150>] do_page_fault+0x0/0x523
Feb 22 15:00:54 mserv1 kernel:  [<c010baf5>] error_code+0x2d/0x38
Feb 22 15:00:54 mserv1 kernel:  [<c011e5b5>] __wake_up+0x45/0x70
Feb 22 15:00:54 mserv1 kernel:  [<c011e54a>] __wake_up_common+0x3a/0x60
Feb 22 15:00:55 mserv1 kernel:  [<c011e5af>] __wake_up+0x3f/0x70
Feb 22 15:00:55 mserv1 kernel:  [<c0259e62>] mrunlock+0x82/0xb0
Feb 22 15:00:55 mserv1 kernel:  [<c0259b00>] mraccessf+0xc0/0xe0
Feb 22 15:00:55 mserv1 kernel:  [<c023038e>] xfs_iunlock+0x3e/0x80
Feb 22 15:00:55 mserv1 kernel:  [<c023727b>] xfs_iomap+0x3bb/0x540
Feb 22 15:00:55 mserv1 kernel:  [<c0163fc7>] bio_alloc+0xd7/0x1c0
Feb 22 15:00:55 mserv1 kernel:  [<c025a17a>] map_blocks+0x7a/0x170
Feb 22 15:00:55 mserv1 kernel:  [<c025b40b>] page_state_convert+0x52b/0x6d0
Feb 22 15:00:55 mserv1 kernel:  [<c0236cb9>] xfs_imap_to_bmap+0x39/0x240
Feb 22 15:00:55 mserv1 kernel:  [<c025be48>] linvfs_release_page+0xa8/0xb0
Feb 22 15:00:55 mserv1 kernel:  [<c025bce0>] linvfs_writepage+0x60/0x120
Feb 22 15:00:55 mserv1 kernel:  [<c014990c>] shrink_list+0x41c/0x710
Feb 22 15:00:55 mserv1 kernel:  [<c0149df8>] shrink_cache+0x1f8/0x3d0
Feb 22 15:00:55 mserv1 kernel:  [<c01b3a00>] journal_stop+0x220/0x330
Feb 22 15:00:55 mserv1 kernel:  [<c014a6dc>] shrink_zone+0xbc/0xc0
Feb 22 15:00:55 mserv1 kernel:  [<c014a7a5>] shrink_caches+0xc5/0xe0
Feb 22 15:00:55 mserv1 kernel:  [<c014a87c>] try_to_free_pages+0xbc/0x190
Feb 22 15:00:55 mserv1 kernel:  [<c0143043>] __alloc_pages+0x203/0x370
Feb 22 15:00:55 mserv1 kernel:  [<c01431d5>] __get_free_pages+0x25/0x40
Feb 22 15:00:55 mserv1 kernel:  [<c0173241>] __pollwait+0x41/0xd0
Feb 22 15:00:55 mserv1 kernel:  [<c0358f93>] tcp_poll+0x33/0x190
Feb 22 15:00:55 mserv1 kernel:  [<c032b0f9>] sock_poll+0x29/0x40
Feb 22 15:00:55 mserv1 kernel:  [<c01736b7>] do_select+0x2f7/0x320
Feb 22 15:00:55 mserv1 kernel:  [<c0173200>] __pollwait+0x0/0xd0
Feb 22 15:00:55 mserv1 kernel:  [<c0173a12>] sys_select+0x302/0x540
Feb 22 15:00:55 mserv1 kernel:  [<c010b08b>] syscall_call+0x7/0xb
Feb 22 15:00:55 mserv1 kernel:
Feb 22 15:00:55 mserv1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 000002a6
Feb 22 15:00:55 mserv1 kernel:  printing eip:
Feb 22 15:00:55 mserv1 kernel: c011e5b5
Feb 22 15:00:55 mserv1 kernel: *pde = 00000000
Feb 22 15:00:55 mserv1 kernel: Oops: 0002 [#2]
Feb 22 15:00:55 mserv1 kernel: CPU:    1
Feb 22 15:00:55 mserv1 kernel: EIP:    0060:[<c011e5b5>]    Not tainted
Feb 22 15:00:55 mserv1 kernel: EFLAGS: 00010003
Feb 22 15:00:55 mserv1 kernel: EIP is at __wake_up+0x45/0x70
Feb 22 15:00:55 mserv1 kernel: eax: ee531a00   ebx: 00000292   ecx: 00000001   edx: 00000003
Feb 22 15:00:55 mserv1 kernel: esi: ddcdfee8   edi: 00000001   ebp: c2ae5d80   esp: c2ae5d60
Feb 22 15:00:55 mserv1 kernel: ds: 007b   es: 007b   ss: 0068
Feb 22 15:00:55 mserv1 kernel: Process pdflush (pid: 20, threadinfo=c2ae4000 task=c2aead20)
Feb 22 15:00:55 mserv1 kernel: Stack: c011e54a ee531a28 00000003 00000000 ddcdfeec c2ae4000 ddcdfee8 00000296
Feb 22 15:00:55 mserv1 kernel:        c2ae5da4 c011e5af ddcdfee8 00000003 00000001 00000000 ddcdfee0 ddcdfe50
Feb 22 15:00:56 mserv1 kernel:        e25319a0 f5e36000 c0259e62 00000008 00000008 c023038e ddcdfee0 ddcdfe50
Feb 22 15:00:56 mserv1 kernel: Call Trace:
Feb 22 15:00:56 mserv1 kernel:  [<c011e54a>] __wake_up_common+0x3a/0x60
Feb 22 15:00:56 mserv1 kernel:  [<c011e5af>] __wake_up+0x3f/0x70
Feb 22 15:00:56 mserv1 kernel:  [<c0259e62>] mrunlock+0x82/0xb0
Feb 22 15:00:56 mserv1 kernel:  [<c023038e>] xfs_iunlock+0x3e/0x80
Feb 22 15:00:56 mserv1 kernel:  [<c023554a>] xfs_iflush+0x36a/0x550
Feb 22 15:00:56 mserv1 kernel:  [<c02573b5>] xfs_inode_flush+0x255/0x2c0
Feb 22 15:00:56 mserv1 kernel:  [<c011e4f0>] default_wake_function+0x0/0x20
Feb 22 15:00:56 mserv1 kernel:  [<c025bc80>] linvfs_writepage+0x0/0x120
Feb 22 15:00:56 mserv1 kernel:  [<c02645b2>] linvfs_write_inode+0x32/0x40
Feb 22 15:00:56 mserv1 kernel:  [<c0182806>] write_inode+0x46/0x50
Feb 22 15:00:56 mserv1 kernel:  [<c0182a60>] __sync_single_inode+0x250/0x2a0
Feb 22 15:00:56 mserv1 kernel:  [<c0182d4c>] sync_sb_inodes+0x1ac/0x2a0
Feb 22 15:00:56 mserv1 kernel:  [<c0182ec9>] writeback_inodes+0x89/0x130
Feb 22 15:00:56 mserv1 kernel:  [<c01442c8>] background_writeout+0xb8/0x100
Feb 22 15:00:56 mserv1 kernel:  [<c0144afa>] __pdflush+0x10a/0x220
Feb 22 15:00:56 mserv1 kernel:  [<c0144c10>] pdflush+0x0/0x20
Feb 22 15:00:56 mserv1 kernel:  [<c0144c1f>] pdflush+0xf/0x20
Feb 22 15:00:56 mserv1 kernel:  [<c0144210>] background_writeout+0x0/0x100
Feb 22 15:00:56 mserv1 kernel:  [<c0108d14>] kernel_thread_helper+0x0/0xc
Feb 22 15:00:56 mserv1 kernel:  [<c0108d19>] kernel_thread_helper+0x5/0xc
Feb 22 15:00:56 mserv1 kernel:
Feb 22 15:00:56 mserv1 kernel: Code: ff 4b 14 8b 43 08 83 e0 08 75 0d 8b 5d f4 8b 75 f8 8b 7d fc
Feb 22 15:00:56 mserv1 kernel:  <6>note: pdflush[20] exited with preempt_count 3


/Mikael
-- 
-----------------------------------------------------------------------
 Mikael Wahlberg,  M.Sc.                  Ardendo
 Unit Manager Professional Services/      e-mail: mikael@ardendo.se
 Technical Project Manager                GSM:    +46 733 279 274
