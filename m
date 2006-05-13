Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWEMPAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWEMPAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWEMPAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:00:09 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:30124 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1751079AbWEMPAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:00:07 -0400
Date: Sat, 13 May 2006 17:00:03 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might be dm related)
Message-ID: <20060513150003.GA6096@uio.no>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org> <20060513134908.GA4480@uio.no> <20060513073344.4fcbc46b.akpm@osdl.org> <20060513144334.GA6013@uio.no> <20060513075147.423d18bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060513075147.423d18bd.akpm@osdl.org>
X-Operating-System: Linux 2.6.16.11 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
X-Spam-Score: -2.6 (--)
X-Spam-Report: Status=No hits=-2.6 required=5.0 tests=AWL,BAYES_00,NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 07:51:47AM -0700, Andrew Morton wrote:
> ho-hum.  Please see if there's anything else you can do to rule out a
> hardware failure, then copy dm-devel@redhat.com on the next oops report.

It's not swap related. It crashes even without swap enabled; still with lots of
dm stuff in the backtrace, though:

[ 3192.568880] general protection fault: 0000 [1] SMP 
[ 3192.573779] CPU 1 
[ 3192.575804] Modules linked in: w83627hf_wdt eeprom ide_generic ide_disk ide_cd cdrom ipv6 psmouse i2c_nforce2 serio_raw pcspkr i2c_core parport_pc parport rtc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod sd_mod sata_nv tg3 sata_sil libata scsi_mod forcedeth generic amd74xx ehci_hcd ide_core ohc i_hcd thermal processor fan unix
[ 3192.607472] Pid: 3432, comm: md1_raid5 Not tainted 2.6.17-rc4 #1
[ 3192.613471] RIP: 0010:[<ffffffff803a1ae8>] <ffffffff803a1ae8>{__lock_text_start+0}
[ 3192.620870] RSP: 0018:ffff81000245bd70  EFLAGS: 00210086
[ 3192.626374] RAX: 000000000000fa40 RBX: aaaa8b5ad269b80f RCX: ffff81000151ff50
[ 3192.633501] RDX: ffff81007febd600 RSI: ffff81000151fef0 RDI: aaaa8b5ad269b81f
[ 3192.640628] RBP: 000000000000fa40 R08: ffff81007db6d2c0 R09: ffff81007db6d2c0
[ 3192.647756] R10: 0000000000000007 R11: ffffffff8024c868 R12: ffff81007febf040
[ 3192.654882] R13: 0000000000200296 R14: ffff810004a97fb0 R15: 0000000000000000
[ 3192.662009] FS:  0000000000000000(0000) GS:ffff81007f827840(0000) knlGS:00000000f7ad9ae0
[ 3192.670101] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 3192.675843] CR2: 00000000080850e0 CR3: 000000007c11e000 CR4: 00000000000006e0
[ 3192.682970] Process md1_raid5 (pid: 3432, threadinfo ffff81007ddb6000, task ffff81007f997080)
[ 3192.691495] Stack: ffffffff802668b8 ffff81007f27c880 ffff810049bb23c0 ffff810049bb23c0 
[ 3192.699353]        0000000000000000 ffff81007d0788b8 ffff810049bb23c0 0000000000000000 
[ 3192.707404]        ffffffff880d3b67 ffff81007ed0cba8 
[ 3192.712476] Call Trace: <IRQ> <ffffffff802668b8>{kmem_cache_free+186}
[ 3192.718950]        <ffffffff880d3b67>{:dm_mod:clone_endio+135} <ffffffff802c9372>{__end_that_request_first+420}
[ 3192.729081]        <ffffffff802c7d1b>{blk_run_queue+62} <ffffffff8806f8a6>{:scsi_mod:scsi_end_request+40}
[ 3192.738700]        <ffffffff8806fb51>{:scsi_mod:scsi_io_completion+522}
[ 3192.745334]        <ffffffff880cc4a1>{:sd_mod:sd_rw_intr+623} <ffffffff880705d6>{:scsi_mod:scsi_device_unbusy+85}
[ 3192.755641]        <ffffffff802c86cb>{blk_done_softirq+113} <ffffffff8022c41b>{__do_softirq+86}
[ 3192.764377]        <ffffffff8020a742>{call_softirq+30} <ffffffff8020b902>{do_softirq+44}
[ 3192.772509]        <ffffffff8020b947>{do_IRQ+65} <ffffffff80209aa0>{ret_from_intr+0} <EOI>
[ 3192.780822]        <ffffffff881129a7>{:raid5:compute_parity+880} <ffffffff802d5e2f>{memcmp+11}
[ 3192.789476]        <ffffffff8811467a>{:raid5:handle_stripe+3022} <ffffffff80238a7c>{keventd_create_kthread+0}
[ 3192.799424]        <ffffffff80238a7c>{keventd_create_kthread+0} <ffffffff881153e9>{:raid5:raid5d+333}
[ 3192.808682]        <ffffffff880e464f>{:md_mod:md_thread+0} <ffffffff880e4751>{:md_mod:md_thread+258}
[ 3192.817864]        <ffffffff80238e78>{autoremove_wake_function+0} <ffffffff880e464f>{:md_mod:md_thread+0}
[ 3192.827471]        <ffffffff80238cc4>{kthread+203} <ffffffff8020a3f2>{child_rip+8}
[ 3192.835081]        <ffffffff80238a7c>{keventd_create_kthread+0} <ffffffff80238bf9>{kthread+0}
[ 3192.843646]        <ffffffff8020a3ea>{child_rip+0}
[ 3192.848646] 
[ 3192.848647] Code: f0 ff 0f 0f 88 c8 01 00 00 c3 f0 ff 0f 8b 07 ba 01 00 00 00 
[ 3192.857563] RIP <ffffffff803a1ae8>{__lock_text_start+0} RSP <ffff81000245bd70>
[ 3192.865039]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
[ 3192.872164]  <0>Rebooting in 60 seconds..

(Thank goodness for serial console; I couldn't possibly write all these oopses
by hand. :-) )

> The stack backtrace you have there is a little surprising.  Enabling
> CONFIG_FRAME_POINTER might help clear it up.  Also it'd be worth seeing if
> CONFIG_DEBUG_SLAB turns up anything.

I'm recompiling 2.6.17-rc4 now with those two added in. I'll let you know in a
few hours when it crashes again, I'd guess :-)

Would it be a good idea to revert your mm patch and test again, just in case?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
