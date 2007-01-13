Return-Path: <linux-kernel-owner+w=401wt.eu-S1422756AbXAMTOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbXAMTOj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 14:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbXAMTOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 14:14:39 -0500
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:35420 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422756AbXAMTOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 14:14:38 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jan 2007 14:14:37 EST
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [-mm] reiserfs4 still hangs
Date: Sat, 13 Jan 2007 19:54:53 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701131954.58339.marc.dietrich@ap.physik.uni-giessen.de>
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-MailScanner-From: marc.dietrich@ap.physik.uni-giessen.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

using 2.6.20-rc3-mm1 and 2.6.20-rc4-mm1, I get reiserfs4 related processes in 
down state (not only using googleearth...). Any hints?

sysrq-t shows:

Jan 13 19:32:57 fb07-iapwap2 kernel: googleearth-b D 00000001     0  6089   
6072          6109       (NOTLB)
Jan 13 19:32:57 fb07-iapwap2 kernel:        c45f3a94 00000086 c4d7a050 
00000001 c02bb6b5 c013a38b c02bb6b5 00000000
Jan 13 19:32:57 fb07-iapwap2 kernel:        c4d7a050 00000004 c4d7a050 
e9eb4e3d 00000044 0001cd83 c4d7a15c c7bae8d4
Jan 13 19:32:57 fb07-iapwap2 kernel:        00000282 c7bae8d4 c7bae884 
c7bae8d4 00000000 c987ad20 dcdd223a 00000000
Jan 13 19:32:57 fb07-iapwap2 kernel: Call Trace:
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c02bb6b5>] 
_spin_unlock_irqrestore+0x45/0x60
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c013a38b>] mark_held_locks+0x6b/0x90
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c02bb6b5>] 
_spin_unlock_irqrestore+0x45/0x60
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdd223a>] 
reiser4_go_to_sleep+0x5a/0x90 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c0130bc0>] 
autoremove_wake_function+0x0/0x50
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdd86c4>] 
capture_fuse_wait+0x164/0x190 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdd7ba0>] wait_for_fusion+0x0/0x30 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdd94f4>] 
reiser4_try_capture+0xa04/0xa30 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c02bb20a>] _spin_lock+0x2a/0x40
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdd2a9b>] 
longterm_lock_znode+0x2bb/0x470 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c02bb20a>] _spin_lock+0x2a/0x40
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcde1bea>] coord_by_handle+0x40a/0xcf0 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dd30334c>] 
nfs_lookup_revalidate+0x1c/0x4a0 [nfs]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcde2736>] 
reiser4_object_lookup+0xc6/0x110 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dce04499>] unit_key_cde+0x49/0x70 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcde30b0>] reiser4_seal_init+0x20/0x60 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcde264e>] coord_by_key+0x9e/0xc0 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdee8a1>] lookup_sd+0x61/0xa0 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcde79fb>] reiser4_iget+0x15b/0x330 
[reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<dcdec5da>] 
reiser4_lookup_common+0x6a/0x120 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c0178ea8>] do_lookup+0x148/0x190
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017af9c>] 
__link_path_walk+0x7cc/0xe20
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c01d27b1>] 
_atomic_dec_and_lock+0x31/0x60
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c0187ff3>] mntput_no_expire+0x13/0x70
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017b653>] link_path_walk+0x63/0xc0
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017b633>] link_path_walk+0x43/0xc0
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c0104114>] restore_nocheck+0x12/0x15
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c013a537>] 
trace_hardirqs_on+0xc7/0x170
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017b8a4>] do_path_lookup+0x84/0x210
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017a60a>] getname+0x9a/0xf0
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017c2fb>] __user_walk_fd+0x3b/0x60
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c01706b9>] sys_faccessat+0x99/0x160
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c0104114>] restore_nocheck+0x12/0x15
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c013a537>] 
trace_hardirqs_on+0xc7/0x170
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c017079f>] sys_access+0x1f/0x30
Jan 13 19:32:57 fb07-iapwap2 kernel:  [<c01040cc>] syscall_call+0x7/0xb
Jan 13 19:32:57 fb07-iapwap2 kernel:  =======================


locks:
Jan 13 19:32:57 fb07-iapwap2 kernel: Showing all locks held in the system:
Jan 13 19:32:57 fb07-iapwap2 kernel: 3 locks held by pdflush/117:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&type->s_umount_key#17){----}, at: 
[<c018f3ba>] writeback_inodes+0x9a/0xe0
Jan 13 19:32:57 fb07-iapwap2 kernel:  #1:  (&mgr->commit_mutex){--..}, at: 
[<dcdd9a2c>] reiser4_txn_end+0x3bc/0x510 [reiser4
]
Jan 13 19:32:57 fb07-iapwap2 kernel:  #2:  (&qp->mutex){--..}, at: 
[<c01354c3>] synchronize_qrcu+0x13/0xb0
Jan 13 19:32:57 fb07-iapwap2 kernel: 1 lock held by mingetty/5432:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&tty->atomic_read_lock){--..}, at: 
[<c0221f24>] read_chan+0x414/0x610
Jan 13 19:32:57 fb07-iapwap2 kernel: 1 lock held by mingetty/5433:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&tty->atomic_read_lock){--..}, at: 
[<c0221f24>] read_chan+0x414/0x610
Jan 13 19:32:57 fb07-iapwap2 kernel: 1 lock held by mingetty/5434:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&tty->atomic_read_lock){--..}, at: 
[<c0221f24>] read_chan+0x414/0x610
Jan 13 19:32:57 fb07-iapwap2 kernel: 1 lock held by mingetty/5435:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&tty->atomic_read_lock){--..}, at: 
[<c0221f24>] read_chan+0x414/0x610
Jan 13 19:32:57 fb07-iapwap2 kernel: 1 lock held by mingetty/5455:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&tty->atomic_read_lock){--..}, at: 
[<c0221f24>] read_chan+0x414/0x610
Jan 13 19:32:57 fb07-iapwap2 kernel: 1 lock held by bash/5487:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&tty->atomic_read_lock){--..}, at: 
[<c0221f24>] read_chan+0x414/0x610
Jan 13 19:32:57 fb07-iapwap2 kernel: 2 locks held by googleearth-bin/6089:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (&inode->i_mutex){--..}, at: 
[<c0178e13>] do_lookup+0xb3/0x190
Jan 13 19:32:57 fb07-iapwap2 kernel:  #1:  (&info->loading){--..}, at: 
[<dcde79bd>] reiser4_iget+0x11d/0x330 [reiser4]
Jan 13 19:32:57 fb07-iapwap2 kernel: 2 locks held by bash/6141:
Jan 13 19:32:57 fb07-iapwap2 kernel:  #0:  (sysrq_key_table_lock){....}, at: 
[<c022dcf7>] __handle_sysrq+0x17/0x130
Jan 13 19:32:57 fb07-iapwap2 kernel:  #1:  (tasklist_lock){..??}, at: 
[<c0139081>] debug_show_all_locks+0x21/0x150
Jan 13 19:32:57 fb07-iapwap2 kernel:
Jan 13 19:32:57 fb07-iapwap2 kernel: 
=============================================


Marc

-- 
	"The enemy commits atrocities knowingly; if we make unfortunate mistakes, it 
is involuntary."
		 Lord Arthur Ponsonby, "Falsehood in Wartime: Propaganda Lies of the First 
World War", 1928
