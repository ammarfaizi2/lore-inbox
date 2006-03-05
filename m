Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWCEUmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWCEUmf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWCEUmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 15:42:35 -0500
Received: from cantor.suse.de ([195.135.220.2]:44203 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750733AbWCEUme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 15:42:34 -0500
Date: Sun, 5 Mar 2006 21:42:31 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060305204231.GA22002@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060305140932.GA17132@suse.de> <20060305185923.GA21519@suse.de> <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603051147590.13139@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

 On Sun, Mar 05, Linus Torvalds wrote:

> "git bisect" really is very powerful and easy to use.

Indeed. The one "between" gi5 and git6
(93b47684f60cf25e8cefe19a21d94aa0257fdf36) is fails also. There are no
mutex changes left, so I suspect some ppc bug.

With this changeset, my first attempt ran into this deadlock, the second
attempt lead to the reiserfs corruption.
See attached 93b47684f60cf25e8cefe19a21d94aa0257fdf36.log 

I'm now at 03929c76f3e5af919fb762e9882a9c286d361e7d, which fails as
well. dmesg shows this:

Adding 295332k swap on /dev/hda10.  Priority:-1 extents:1 across:295332k
ReiserFS: warning: is_leaf: wrong item type for item *3.5*[-1 -1 0xffffffff DIRECT], item_len 65535, item_location 65535, free_space(entry_count) 65535
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 4652 0x0 SD]
ReiserFS: warning: is_leaf: wrong item type for item *3.5*[-1 -1 0xffffffff DIRECT], item_len 65535, item_location 65535, free_space(entry_count) 65535
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 4652 0x0 SD]
ReiserFS: warning: is_leaf: wrong item type for item *3.5*[-1 -1 0xffffffff DIRECT], item_len 65535, item_location 65535, free_space(entry_count) 65535
ReiserFS: hda11: warning: vs-5150: search_by_key: invalid format found in block 0. Fsck?
ReiserFS: hda11: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 4652 0x0 SD]


There are only powerpc related changes left.
Its a bit time comsuming until I get to the point of where it fails,
lets see how far I get this evening.

--zYM0uCDKw75PZbzx
Content-Type: text/x-log; charset=utf-8
Content-Disposition: attachment; filename="93b47684f60cf25e8cefe19a21d94aa0257fdf36.log"

inst-sys:~ # dmesg
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid5: measuring checksumming speed
   8regs     :   351.000 MB/sec
   8regs_prefetch:   296.000 MB/sec
   32regs    :   325.000 MB/sec
   32regs_prefetch:   285.000 MB/sec
raid5: using function: 8regs (351.000 MB/sec)
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid6: int32x1     58 MB/s
raid6: int32x2     88 MB/s
raid6: int32x4    110 MB/s
raid6: int32x8    105 MB/s
raid6: using algorithm int32x4 (110 MB/s)
md: raid6 personality registered for level 6
md: multipath personality registered for level -4
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
cdrom: open failed.
ReiserFS: hda11: found reiserfs format "3.6" with standard journal
ReiserFS: hda11: using ordered data mode
ReiserFS: hda11: journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda11: checking transaction log (hda11)
ReiserFS: hda11: Using r5 hash to sort names
ReiserFS: hda11: warning: Created .reiserfs_priv on hda11 - reserved for xattr storage.
Adding 295332k swap on /dev/hda10.  Priority:-1 extents:1 across:295332k
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 0FEC24B4     0     1      0     2               (NOTLB)
Call Trace:
[C2D29D90] [C2D29E40] 0xc2d29e40 (unreliable)
[C2D29E50] [C000C318] __switch_to+0x5c/0x74
[C2D29E70] [C02D3B28] schedule+0x680/0x734
[C2D29EB0] [C00332D0] do_wait+0xc88/0xe94
[C2D29F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfec24b4
    LR = 0xfe5ed00
ksoftirqd/0   S 00000000     0     2      1             3       (L-TLB)
Call Trace:
[C2D2BE90] [EA6713EA] 0xea6713ea (unreliable)
[C2D2BF50] [C000C318] __switch_to+0x5c/0x74
[C2D2BF70] [C02D3B28] schedule+0x680/0x734
[C2D2BFB0] [C0035D74] ksoftirqd+0x4c/0xa8
[C2D2BFC0] [C0048900] kthread+0xd4/0x110
[C2D2BFF0] [C00117C4] kernel_thread+0x44/0x60
watchdog/0    S 00000000     0     3      1             4     2 (L-TLB)
Call Trace:
[C2D2DE30] [7C00F54F] 0x7c00f54f (unreliable)
[C2D2DEF0] [C000C318] __switch_to+0x5c/0x74
[C2D2DF10] [C02D3B28] schedule+0x680/0x734
[C2D2DF50] [C02D4618] schedule_timeout+0x98/0xc8
[C2D2DF90] [C003B374] msleep_interruptible+0x38/0x6c
[C2D2DFA0] [C0058068] watchdog+0x44/0x84
[C2D2DFC0] [C0048900] kthread+0xd4/0x110
[C2D2DFF0] [C00117C4] kernel_thread+0x44/0x60
events/0      S 00000000     0     4      1             5     3 (L-TLB)
Call Trace:
[C2787E20] [00000001] 0x1 (unreliable)
[C2787EE0] [C000C318] __switch_to+0x5c/0x74
[C2787F00] [C02D3B28] schedule+0x680/0x734
[C2787F40] [C0043A1C] worker_thread+0xdc/0x224
[C2787FC0] [C0048900] kthread+0xd4/0x110
[C2787FF0] [C00117C4] kernel_thread+0x44/0x60
khelper       S 00000000     0     5      1             6     4 (L-TLB)
Call Trace:
[C2CE1E20] [C0043940] worker_thread+0x0/0x224 (unreliable)
[C2CE1EE0] [C000C318] __switch_to+0x5c/0x74
[C2CE1F00] [C02D3B28] schedule+0x680/0x734
[C2CE1F40] [C0043A1C] worker_thread+0xdc/0x224
[C2CE1FC0] [C0048900] kthread+0xd4/0x110
[C2CE1FF0] [C00117C4] kernel_thread+0x44/0x60
kthread       S 00000000     0     6      1    24      73     5 (L-TLB)
Call Trace:
[C2789E20] [0000000A] 0xa (unreliable)
[C2789EE0] [C000C318] __switch_to+0x5c/0x74
[C2789F00] [C02D3B28] schedule+0x680/0x734
[C2789F40] [C0043A1C] worker_thread+0xdc/0x224
[C2789FC0] [C0048900] kthread+0xd4/0x110
[C2789FF0] [C00117C4] kernel_thread+0x44/0x60
kblockd/0     S 00000000     0    24      6            28       (L-TLB)
Call Trace:
[C9B41E20] [C04798C0] ide_hwifs+0x0/0x41c0 (unreliable)
[C9B41EE0] [C000C318] __switch_to+0x5c/0x74
[C9B41F00] [C02D3B28] schedule+0x680/0x734
[C9B41F40] [C0043A1C] worker_thread+0xdc/0x224
[C9B41FC0] [C0048900] kthread+0xd4/0x110
[C9B41FF0] [C00117C4] kernel_thread+0x44/0x60
khubd         S 00000000     0    28      6            71    24 (L-TLB)
Call Trace:
[C9B4FE10] [C0224D98] urb_destroy+0x10/0x20 (unreliable)
[C9B4FED0] [C000C318] __switch_to+0x5c/0x74
[C9B4FEF0] [C02D3B28] schedule+0x680/0x734
[C9B4FF30] [C022223C] hub_thread+0xb78/0xc08
[C9B4FFC0] [C0048900] kthread+0xd4/0x110
[C9B4FFF0] [C00117C4] kernel_thread+0x44/0x60
pdflush       S 00000000     0    71      6            72    28 (L-TLB)
Call Trace:
[C9B6BE60] [C003ABD8] process_timeout+0x0/0x20 (unreliable)
[C9B6BF20] [C000C318] __switch_to+0x5c/0x74
[C9B6BF40] [C02D3B28] schedule+0x680/0x734
[C9B6BF80] [C0060E58] pdflush+0xc0/0x218
[C9B6BFC0] [C0048900] kthread+0xd4/0x110
[C9B6BFF0] [C00117C4] kernel_thread+0x44/0x60
pdflush       D 00000000     0    72      6            74    71 (L-TLB)
Call Trace:
[C9B65BF0] [000003FA] 0x3fa (unreliable)
[C9B65CB0] [C000C318] __switch_to+0x5c/0x74
[C9B65CD0] [C02D3B28] schedule+0x680/0x734
[C9B65D10] [C02D326C] __down+0x64/0xd0
[C9B65D70] [C00F896C] flush_commit_list+0x17c/0x7c4
[C9B65DB0] [C00F8900] flush_commit_list+0x110/0x7c4
[C9B65DF0] [C00FC9C4] do_journal_end+0xe74/0xec0
[C9B65E50] [C00FCA98] journal_end_sync+0x88/0x9c
[C9B65E70] [C00E5FBC] reiserfs_sync_fs+0x4c/0x88
[C9B65EB0] [C00E600C] reiserfs_write_super+0x14/0x24
[C9B65EC0] [C0089394] sync_supers+0x104/0x1c4
[C9B65EE0] [C00602D8] wb_kupdate+0x54/0x16c
[C9B65F80] [C0060EBC] pdflush+0x124/0x218
[C9B65FC0] [C0048900] kthread+0xd4/0x110
[C9B65FF0] [C00117C4] kernel_thread+0x44/0x60
aio/0         S 00000000     0    74      6           283    72 (L-TLB)
Call Trace:
[C9B49E20] [C060C000] 0xc060c000 (unreliable)
[C9B49EE0] [C000C318] __switch_to+0x5c/0x74
[C9B49F00] [C02D3B28] schedule+0x680/0x734
[C9B49F40] [C0043A1C] worker_thread+0xdc/0x224
[C9B49FC0] [C0048900] kthread+0xd4/0x110
[C9B49FF0] [C00117C4] kernel_thread+0x44/0x60
kswapd0       S 00000000     0    73      1           383     6 (L-TLB)
Call Trace:
[C9B67E60] [C02D507C] _spin_unlock_irqrestore+0x18/0x30 (unreliable)
[C9B67F20] [C000C318] __switch_to+0x5c/0x74
[C9B67F40] [C02D3B28] schedule+0x680/0x734
[C9B67F80] [C0064604] kswapd+0xc8/0xec
[C9B67FF0] [C00117C4] kernel_thread+0x44/0x60
cqueue/0      S 00000000     0   283      6           284    74 (L-TLB)
Call Trace:
[C9BEDE20] [C060C000] 0xc060c000 (unreliable)
[C9BEDEE0] [C000C318] __switch_to+0x5c/0x74
[C9BEDF00] [C02D3B28] schedule+0x680/0x734
[C9BEDF40] [C0043A1C] worker_thread+0xdc/0x224
[C9BEDFC0] [C0048900] kthread+0xd4/0x110
[C9BEDFF0] [C00117C4] kernel_thread+0x44/0x60
kseriod       S 00000000     0   284      6          1064   283 (L-TLB)
Call Trace:
[C9BF7E40] [C00CB664] sysfs_new_dirent+0x2c/0x94 (unreliable)
[C9BF7F00] [C000C318] __switch_to+0x5c/0x74
[C9BF7F20] [C02D3B28] schedule+0x680/0x734
[C9BF7F60] [C01E791C] serio_thread+0x2e8/0x33c
[C9BF7FC0] [C0048900] kthread+0xd4/0x110
[C9BF7FF0] [C00117C4] kernel_thread+0x44/0x60
udevd         S 0FF626D4     0   383      1           947    73 (NOTLB)
Call Trace:
[C2D69CE0] [0000000A] 0xa (unreliable)
[C2D69DA0] [C000C318] __switch_to+0x5c/0x74
[C2D69DC0] [C02D3B28] schedule+0x680/0x734
[C2D69E00] [C02D45AC] schedule_timeout+0x2c/0xc8
[C2D69E40] [C0097E68] do_select+0x328/0x384
[C2D69EC0] [C00981C0] sys_select+0x2fc/0x4dc
[C2D69F10] [C0004D98] ppc_select+0xfc/0x118
[C2D69F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff626d4
    LR = 0x1000317c
bash          S 0FE372A8     0   947      1          1061   383 (NOTLB)
Call Trace:
[C9E1FCD0] [08D4B305] 0x8d4b305 (unreliable)
[C9E1FD90] [C000C318] __switch_to+0x5c/0x74
[C9E1FDB0] [C02D3B28] schedule+0x680/0x734
[C9E1FDF0] [C02D45AC] schedule_timeout+0x2c/0xc8
[C9E1FE30] [C01D63E0] read_chan+0x368/0x814
[C9E1FEC0] [C01D2674] tty_read+0x8c/0xdc
[C9E1FEF0] [C008002C] vfs_read+0xec/0x1c4
[C9E1FF10] [C00804CC] sys_read+0x4c/0x94
[C9E1FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe372a8
    LR = 0xffc96e4
dhcpcd        S 07F33CF0     0  1061      1          1063   947 (NOTLB)
Call Trace:
[C258FDB0] [C00A236C] mntput_no_expire+0x2c/0xc4 (unreliable)
[C258FE70] [C000C318] __switch_to+0x5c/0x74
[C258FE90] [C02D3B28] schedule+0x680/0x734
[C258FED0] [C02D4618] schedule_timeout+0x98/0xc8
[C258FF10] [C003B5DC] sys_nanosleep+0x128/0x260
[C258FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x7f33cf0
    LR = 0x7f33aa4
portmap       S 07F111E0     0  1063      1          1065  1061 (NOTLB)
Call Trace:
[C2595D90] [C025C698] move_addr_to_kernel+0x90/0xc4 (unreliable)
[C2595E50] [C000C318] __switch_to+0x5c/0x74
[C2595E70] [C02D3B28] schedule+0x680/0x734
[C2595EB0] [C02D45AC] schedule_timeout+0x2c/0xc8
[C2595EF0] [C0098614] sys_poll+0x274/0x360
[C2595F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x7f111e0
    LR = 0x7f1119c
rpciod/0      S 00000000     0  1064      6          3348   284 (L-TLB)
Call Trace:
[C258BE20] [C02D507C] _spin_unlock_irqrestore+0x18/0x30 (unreliable)
[C258BEE0] [C000C318] __switch_to+0x5c/0x74
[C258BF00] [C02D3B28] schedule+0x680/0x734
[C258BF40] [C0043A1C] worker_thread+0xdc/0x224
[C258BFC0] [C0048900] kthread+0xd4/0x110
[C258BFF0] [C00117C4] kernel_thread+0x44/0x60
lockd         S 00000000     0  1065      1          1066  1063 (L-TLB)
Call Trace:
[C2591E00] [C007AA64] cache_free_debugcheck+0x214/0x22c (unreliable)
[C2591EC0] [C000C318] __switch_to+0x5c/0x74
[C2591EE0] [C02D3B28] schedule+0x680/0x734
[C2591F20] [C02D45AC] schedule_timeout+0x2c/0xc8
[C2591F60] [CB18F0D4] svc_recv+0x300/0x530 [sunrpc]
[C2591FD0] [CB152924] lockd+0x168/0x280 [lockd]
[C2591FF0] [C00117C4] kernel_thread+0x44/0x60
loop0         S 00000000     0  1066      1          1084  1065 (L-TLB)
Call Trace:
[C2DADE10] [C2DADE60] 0xc2dade60 (unreliable)
[C2DADED0] [C000C318] __switch_to+0x5c/0x74
[C2DADEF0] [C02D3B28] schedule+0x680/0x734
[C2DADF30] [C02D3370] __down_interruptible+0x98/0x10c
[C2DADF90] [CB104630] loop_thread+0xac/0x468 [loop]
[C2DADFF0] [C00117C4] kernel_thread+0x44/0x60
bash          R running     0  1084      1          1087  1066 (NOTLB)
bash          S 0FE372A8     0  1087      1          1090  1084 (NOTLB)
Call Trace:
[C887BCD0] [08BA8785] 0x8ba8785 (unreliable)
[C887BD90] [C000C318] __switch_to+0x5c/0x74
[C887BDB0] [C02D3B28] schedule+0x680/0x734
[C887BDF0] [C02D45AC] schedule_timeout+0x2c/0xc8
[C887BE30] [C01D63E0] read_chan+0x368/0x814
[C887BEC0] [C01D2674] tty_read+0x8c/0xdc
[C887BEF0] [C008002C] vfs_read+0xec/0x1c4
[C887BF10] [C00804CC] sys_read+0x4c/0x94
[C887BF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe372a8
    LR = 0xffc96e4
bash          S 0FE372A8     0  1090      1          1093  1087 (NOTLB)
Call Trace:
[C88D1CD0] [08B8F785] 0x8b8f785 (unreliable)
[C88D1D90] [C000C318] __switch_to+0x5c/0x74
[C88D1DB0] [C02D3B28] schedule+0x680/0x734
[C88D1DF0] [C02D45AC] schedule_timeout+0x2c/0xc8
[C88D1E30] [C01D63E0] read_chan+0x368/0x814
[C88D1EC0] [C01D2674] tty_read+0x8c/0xdc
[C88D1EF0] [C008002C] vfs_read+0xec/0x1c4
[C88D1F10] [C00804CC] sys_read+0x4c/0x94
[C88D1F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe372a8
    LR = 0xffc96e4
inst_setup    S 0FE114B4     0  1093      1  1209    1096  1090 (NOTLB)
Call Trace:
[C8921D90] [C006A390] __handle_mm_fault+0x1214/0x12cc (unreliable)
[C8921E50] [C000C318] __switch_to+0x5c/0x74
[C8921E70] [C02D3B28] schedule+0x680/0x734
[C8921EB0] [C00332D0] do_wait+0xc88/0xe94
[C8921F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe114b4
    LR = 0x100324e8
showconsole   X 0FEFE178     0  1096      1          1107  1093 (L-TLB)
Call Trace:
[C8B73DD0] [C005EED8] __free_pages+0x74/0x194 (unreliable)
[C8B73E90] [C000C318] __switch_to+0x5c/0x74
[C8B73EB0] [C02D3B28] schedule+0x680/0x734
[C8B73EF0] [C0034010] do_exit+0xa8c/0xb18
[C8B73F20] [C0034138] sys_exit_group+0x0/0x8
[C8B73F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfefe178
    LR = 0xfefe148
dbus-daemon   S 0FC711E0     0  1107      1          1109  1096 (NOTLB)
Call Trace:
[C80E7D90] [C025ACD8] sock_writev+0x90/0xc0 (unreliable)
[C80E7E50] [C000C318] __switch_to+0x5c/0x74
[C80E7E70] [C02D3B28] schedule+0x680/0x734
[C80E7EB0] [C02D45AC] schedule_timeout+0x2c/0xc8
[C80E7EF0] [C0098614] sys_poll+0x274/0x360
[C80E7F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfc711e0
    LR = 0xfc7119c
hald          S 0FC611E0     0  1109      1  1125    1162  1107 (NOTLB)
Call Trace:
[C83FBD90] [C015FE70] _atomic_dec_and_lock+0x44/0x60 (unreliable)
[C83FBE50] [C000C318] __switch_to+0x5c/0x74
[C83FBE70] [C02D3B28] schedule+0x680/0x734
[C83FBEB0] [C02D4618] schedule_timeout+0x98/0xc8
[C83FBEF0] [C0098614] sys_poll+0x274/0x360
[C83FBF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfc611e0
    LR = 0xfc6119c
hald-addon-st S 0FE76CF0     0  1125   1109                     (NOTLB)
Call Trace:
[C7EFBDB0] [C035D7B8] xtime_lock+0x4/0x14 (unreliable)
[C7EFBE70] [C000C318] __switch_to+0x5c/0x74
[C7EFBE90] [C02D3B28] schedule+0x680/0x734
[C7EFBED0] [C02D4618] schedule_timeout+0x98/0xc8
[C7EFBF10] [C003B5DC] sys_nanosleep+0x128/0x260
[C7EFBF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe76cf0
    LR = 0xfe76aa4
syslogd.bin   S 07F626D4     0  1162      1          1167  1109 (NOTLB)
Call Trace:
[C63CFCE0] [C02CD768] unix_dgram_recvmsg+0x218/0x264 (unreliable)
[C63CFDA0] [C000C318] __switch_to+0x5c/0x74
[C63CFDC0] [C02D3B28] schedule+0x680/0x734
[C63CFE00] [C02D45AC] schedule_timeout+0x2c/0xc8
[C63CFE40] [C0097E68] do_select+0x328/0x384
[C63CFEC0] [C00981C0] sys_select+0x2fc/0x4dc
[C63CFF10] [C0004D98] ppc_select+0xfc/0x118
[C63CFF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x7f626d4
    LR = 0x8007490
klogd         R running     0  1167      1          1199  1162 (NOTLB)
sshd          S 07A9C6D4     0  1199      1  1893    2167  1167 (NOTLB)
Call Trace:
[C5DBDCE0] [C002B43C] __wake_up_common+0x40/0x94 (unreliable)
[C5DBDDA0] [C000C318] __switch_to+0x5c/0x74
[C5DBDDC0] [C02D3B28] schedule+0x680/0x734
[C5DBDE00] [C02D45AC] schedule_timeout+0x2c/0xc8
[C5DBDE40] [C0097E68] do_select+0x328/0x384
[C5DBDEC0] [C00981C0] sys_select+0x2fc/0x4dc
[C5DBDF10] [C0004D98] ppc_select+0xfc/0x118
[C5DBDF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x7a9c6d4
    LR = 0x800ff28
yast          S 0FE114B4     0  1209   1093  2279               (NOTLB)
Call Trace:
[C5B11D90] [C006A390] __handle_mm_fault+0x1214/0x12cc (unreliable)
[C5B11E50] [C000C318] __switch_to+0x5c/0x74
[C5B11E70] [C02D3B28] schedule+0x680/0x734
[C5B11EB0] [C00332D0] do_wait+0xc88/0xe94
[C5B11F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe114b4
    LR = 0x100324e8
sshd          S 07A9C6D4     0  1893   1199  2055               (NOTLB)
Call Trace:
[C5E93CE0] [C0010C5C] ret_from_except+0x0/0x1c (unreliable)
--- Exception: c5e93da0 at __switch_to+0x5c/0x74
    LR = 0xc5e93da0
[C5E93DA0] [C000C318] __switch_to+0x5c/0x74 (unreliable)
[C5E93DC0] [C02D3B28] schedule+0x680/0x734
[C5E93E00] [C02D45AC] schedule_timeout+0x2c/0xc8
[C5E93E40] [C0097E68] do_select+0x328/0x384
[C5E93EC0] [C00981C0] sys_select+0x2fc/0x4dc
[C5E93F10] [C0004D98] ppc_select+0xfc/0x118
[C5E93F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x7a9c6d4
    LR = 0x801675c
bash          S 0FE114B4     0  2055   1893  2113               (NOTLB)
Call Trace:
[C5F2FD90] [C002BCC4] __wake_up+0x4c/0x60 (unreliable)
[C5F2FE50] [C000C318] __switch_to+0x5c/0x74
[C5F2FE70] [C02D3B28] schedule+0x680/0x734
[C5F2FEB0] [C00332D0] do_wait+0xc88/0xe94
[C5F2FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe114b4
    LR = 0x100324e8
tail          S 0FF33CF0     0  2113   2055                     (NOTLB)
Call Trace:
[C5535DB0] [C00A236C] mntput_no_expire+0x2c/0xc4 (unreliable)
[C5535E70] [C000C318] __switch_to+0x5c/0x74
[C5535E90] [C02D3B28] schedule+0x680/0x734
[C5535ED0] [C02D4618] schedule_timeout+0x98/0xc8
[C5535F10] [C003B5DC] sys_nanosleep+0x128/0x260
[C5535F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff33cf0
    LR = 0x10005e4c
gzip          X 0FF34178     0  2167      1          2865  1199 (L-TLB)
Call Trace:
[C5593DD0] [00000001] 0x1 (unreliable)
[C5593E90] [C000C318] __switch_to+0x5c/0x74
[C5593EB0] [C02D3B28] schedule+0x680/0x734
[C5593EF0] [C0034010] do_exit+0xa8c/0xb18
[C5593F20] [C0034138] sys_exit_group+0x0/0x8
[C5593F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff34178
    LR = 0xff34148
YaST2.call    S 0FE114B4     0  2279   1209  2844               (NOTLB)
Call Trace:
[C5507D90] [C006A390] __handle_mm_fault+0x1214/0x12cc (unreliable)
[C5507E50] [C000C318] __switch_to+0x5c/0x74
[C5507E70] [C02D3B28] schedule+0x680/0x734
[C5507EB0] [C00332D0] do_wait+0xc88/0xe94
[C5507F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfe114b4
    LR = 0x100324e8
y2base        S 0F3242E4     0  2844   2279  3387    2845       (NOTLB)
Call Trace:
[C4A81D00] [00009032] 0x9032 (unreliable)
[C4A81DC0] [C000C318] __switch_to+0x5c/0x74
[C4A81DE0] [C02D3B28] schedule+0x680/0x734
[C4A81E20] [C008F9B4] pipe_wait+0x88/0xdc
[C4A81E80] [C0090294] pipe_readv+0x2b8/0x360
[C4A81ED0] [C009035C] pipe_read+0x20/0x30
[C4A81EF0] [C008002C] vfs_read+0xec/0x1c4
[C4A81F10] [C00804CC] sys_read+0x4c/0x94
[C4A81F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xf3242e4
    LR = 0xf3242cc
y2base        S 0F32D720     0  2845   2279                2844 (NOTLB)
Call Trace:
[C7F7FCE0] [5A2CF071] 0x5a2cf071 (unreliable)
[C7F7FDA0] [C000C318] __switch_to+0x5c/0x74
[C7F7FDC0] [C02D3B28] schedule+0x680/0x734
[C7F7FE00] [C02D4618] schedule_timeout+0x98/0xc8
[C7F7FE40] [C0097E68] do_select+0x328/0x384
[C7F7FEC0] [C00981C0] sys_select+0x2fc/0x4dc
[C7F7FF10] [C0004D98] ppc_select+0xfc/0x118
[C7F7FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xf32d720
    LR = 0xf32d700
gzip          X 0FF34178     0  2865      1          2893  2167 (L-TLB)
Call Trace:
[C76DFDD0] [00000001] 0x1 (unreliable)
[C76DFE90] [C000C318] __switch_to+0x5c/0x74
[C76DFEB0] [C02D3B28] schedule+0x680/0x734
[C76DFEF0] [C0034010] do_exit+0xa8c/0xb18
[C76DFF20] [C0034138] sys_exit_group+0x0/0x8
[C76DFF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff34178
    LR = 0xff34148
gzip          X 0FF34178     0  2893      1          2913  2865 (L-TLB)
Call Trace:
[C726FDD0] [00000001] 0x1 (unreliable)
[C726FE90] [C000C318] __switch_to+0x5c/0x74
[C726FEB0] [C02D3B28] schedule+0x680/0x734
[C726FEF0] [C0034010] do_exit+0xa8c/0xb18
[C726FF20] [C0034138] sys_exit_group+0x0/0x8
[C726FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff34178
    LR = 0xff34148
gzip          X 0FF34178     0  2913      1          3120  2893 (L-TLB)
Call Trace:
[C7327DD0] [C7327E80] 0xc7327e80 (unreliable)
[C7327E90] [C000C318] __switch_to+0x5c/0x74
[C7327EB0] [C02D3B28] schedule+0x680/0x734
[C7327EF0] [C0034010] do_exit+0xa8c/0xb18
[C7327F20] [C0034138] sys_exit_group+0x0/0x8
[C7327F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff34178
    LR = 0xff34148
gzip          X 0FF34178     0  3120      1          3241  2913 (L-TLB)
Call Trace:
[C443FDD0] [C005EED8] __free_pages+0x74/0x194 (unreliable)
[C443FE90] [C000C318] __switch_to+0x5c/0x74
[C443FEB0] [C02D3B28] schedule+0x680/0x734
[C443FEF0] [C0034010] do_exit+0xa8c/0xb18
[C443FF20] [C0034138] sys_exit_group+0x0/0x8
[C443FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff34178
    LR = 0xff34148
gzip          X 0FF34178     0  3241      1                3120 (L-TLB)
Call Trace:
[C870FDD0] [C005EED8] __free_pages+0x74/0x194 (unreliable)
[C870FE90] [C000C318] __switch_to+0x5c/0x74
[C870FEB0] [C02D3B28] schedule+0x680/0x734
[C870FEF0] [C0034010] do_exit+0xa8c/0xb18
[C870FF20] [C0034138] sys_exit_group+0x0/0x8
[C870FF40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xff34178
    LR = 0xff34148
reiserfs/0    D 00000000     0  3348      6                1064 (L-TLB)
Call Trace:
[C71A3D20] [C01525D8] submit_bio+0xe0/0xf4 (unreliable)
[C71A3DE0] [C000C318] __switch_to+0x5c/0x74
[C71A3E00] [C02D3B28] schedule+0x680/0x734
[C71A3E40] [C02D326C] __down+0x64/0xd0
[C71A3EA0] [C00F896C] flush_commit_list+0x17c/0x7c4
[C71A3EE0] [C00F8900] flush_commit_list+0x110/0x7c4
[C71A3F20] [C00FD8A8] flush_async_commits+0x3c/0xa0
[C71A3F40] [C0043AD8] worker_thread+0x198/0x224
[C71A3FC0] [C0048900] kthread+0xd4/0x110
[C71A3FF0] [C00117C4] kernel_thread+0x44/0x60
rpm           D 0FAA793C     0  3387   2844                     (NOTLB)
Call Trace:
[C5BC1B40] [C280C7DC] 0xc280c7dc (unreliable)
[C5BC1C00] [C000C318] __switch_to+0x5c/0x74
[C5BC1C20] [C02D3B28] schedule+0x680/0x734
[C5BC1C60] [C02D3CF8] io_schedule+0x30/0x60
[C5BC1C80] [C0082CBC] sync_buffer+0x50/0x64
[C5BC1C90] [C02D4958] __wait_on_bit+0x60/0xb0
[C5BC1CB0] [C02D4A24] out_of_line_wait_on_bit+0x7c/0x90
[C5BC1D20] [C0082B84] __wait_on_buffer+0x2c/0x3c
[C5BC1D30] [C00F86A0] write_ordered_buffers+0x248/0x2a4
[C5BC1DE0] [C00F8A20] flush_commit_list+0x230/0x7c4
[C5BC1E20] [C00FC9C4] do_journal_end+0xe74/0xec0
[C5BC1E80] [C00FCA98] journal_end_sync+0x88/0x9c
[C5BC1EA0] [C00FD54C] reiserfs_commit_for_inode+0x140/0x1c8
[C5BC1F00] [C00DD2B8] reiserfs_sync_file+0x44/0x90
[C5BC1F20] [C008269C] do_fsync+0xb0/0x128
[C5BC1F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfaa793c
    LR = 0xfee6110
inst-sys:~ # dmesg |o
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid5: measuring checksumming speed
   8regs     :   351.000 MB/sec
   8regs_prefetch:   296.000 MB/sec
   32regs    :   325.000 MB/sec
   32regs_prefetch:   285.000 MB/sec
raid5: using function: 8regs (351.000 MB/sec)
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid6: int32x1     58 MB/s
raid6: int32x2     88 MB/s
raid6: int32x4    110 MB/s
raid6: int32x8    105 MB/s
raid6: using algorithm int32x4 (110 MB/s)
md: raid6 personality registered for level 6
md: multipath personality registered for level -4
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
cdrom: open failed.
ReiserFS: hda11: found reiserfs format "3.6" with standard journal
ReiserFS: hda11: using ordered data mode
ReiserFS: hda11: journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda11: checking transaction log (hda11)
ReiserFS: hda11: Using r5 hash to sort names
ReiserFS: hda11: warning: Created .reiserfs_priv on hda11 - reserved for xattr storage.
Adding 295332k swap on /dev/hda10.  Priority:-1 extents:1 across:295332k
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 0FEC24B4     0     1      0     2               (NOTLB)
Call Trace:
[C2D29D90] [C2D29E40] 0xc2d29e40 (unreliable)
[C2D29E50] [C000C318] __switch_to+0x5c/0x74
[C2D29E70] [C02D3B28] schedule+0x680/0x734
[C2D29EB0] [C00332D0] do_wait+0xc88/0xe94
[C2D29F40] [C001052C] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfec24b4
    LR = 0xfe5ed00
ksoftirqd/0   S 00000000     0     2      1             3       (L-TLB)
Call Trace:
[C2D2BE90] [EA6713EA] 0xea6713ea (unreliable)
[C2D2BF50] [C000C318] __switch_to+0x5c/0x74
[C2D2BF70] [C02D3B28] schedule+0x680/0x734
[C2D2BFB0] [C0035D74] ksoftirqd+0x4c/0xa8
[C2D2BFC0] [C0048900] kthread+0xd4/0x110
[C2D2BFF0] [C00117C4] kernel_thread+0x44/0x60
watchdog/0    S 00000000     0     3      1             4     2 (L-TLB)
inst-sys:~ # ( ps faxwwwwwwww ; dmesg) > 93b47684f60cf25e8cefe19a21d94aa0257fdf36.log
inst-sys:~ # scp 93b47684f60cf25e8cefe19a21d94aa0257fdf36.log olaf@1.1.1.3:



--zYM0uCDKw75PZbzx--
