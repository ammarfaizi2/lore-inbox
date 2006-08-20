Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWHTNV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWHTNV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWHTNV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:21:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:21487 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750768AbWHTNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:21:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mH+PM/Jf49U0CK4/1GzhXsep+zJJMlMaOoInvetqZ7sQHd2M41D120LGiyq5yhmpmFLwM7WU1M/EkF3F62i1n4b9B+SRG2VwmfAu889xwP8ag3HZnDoGciSH8wHAzS4biYJEiHJeqRe8hELI5PcWVXe878mvRNcCyZ+PiJy80nA=
Message-ID: <44E8621B.3040705@gmail.com>
Date: Sun, 20 Aug 2006 15:22:35 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>,
       reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: 2.6.18-rc4-mm2
References: <20060819220008.843d2f64.akpm@osdl.org>
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> 

Reiser4 bug?

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.18-rc4-mm2 #106
-------------------------------------------------------
umount/2571 is trying to acquire lock:
 (&txnh->hlock){--..}, at: [<fe60590d>] commit_txnh+0x3a/0xad [reiser4]

but task is already holding lock:
 (&atom->alock){--..}, at: [<fe604467>] txnh_get_atom+0x1c/0x78 [reiser4]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&atom->alock){--..}:
       [<c013974c>] add_lock_to_list+0x22/0x39
       [<c0139ee2>] check_prev_add+0x103/0x1b4
       [<c0139fe0>] check_prevs_add+0x4d/0xaf
       [<c013ba22>] __lock_acquire+0x8a1/0x93c
       [<c013c128>] lock_acquire+0x6f/0x8f
       [<c0303e3d>] _spin_lock+0x23/0x2f
       [<fe604870>] atom_begin_and_assign_to_txnh+0xdd/0x17a [reiser4]
       [<fe6059f7>] try_capture_block+0x77/0x2f9 [reiser4]
       [<fe605d45>] reiser4_try_capture+0x9e/0xf8 [reiser4]
       [<fe5ffc91>] longterm_lock_znode+0x168/0x266 [reiser4]
       [<fe60ccb7>] get_uber_znode+0x17/0x1c [reiser4]
       [<fe60672d>] reiser4_capture_super_block+0x24/0x5e [reiser4]
       [<fe6336da>] release_format40+0x1c/0xdc [reiser4]
       [<fe60ff47>] reiser4_put_super+0x8f/0xc5 [reiser4]
       [<c017d8df>] generic_shutdown_super+0x67/0xdf
       [<c017e25a>] kill_block_super+0x20/0x32
       [<c017d7e9>] deactivate_super+0x5d/0x6f
       [<c0192532>] mntput_no_expire+0x52/0x85
       [<c018440f>] path_release_on_umount+0x15/0x18
       [<c0192b91>] sys_umount+0x69/0x71
       [<c0192ba6>] sys_oldumount+0xd/0xf
       [<c0103161>] sysenter_past_esp+0x56/0x8d
       [<b7f3c410>] 0xb7f3c410
       [<ffffffff>] 0xffffffff

-> #0 (&txnh->hlock){--..}:
       [<c01398a6>] print_circular_bug_tail+0x30/0x62
       [<c0139e0a>] check_prev_add+0x2b/0x1b4
       [<c0139fe0>] check_prevs_add+0x4d/0xaf
       [<c013ba22>] __lock_acquire+0x8a1/0x93c
       [<c013c128>] lock_acquire+0x6f/0x8f
       [<c0303e3d>] _spin_lock+0x23/0x2f
       [<fe60590d>] commit_txnh+0x3a/0xad [reiser4]
       [<fe60440a>] reiser4_txn_end+0x1a/0x28 [reiser4]
       [<fe604423>] reiser4_txn_restart+0xb/0x1a [reiser4]
       [<fe604449>] reiser4_txn_restart_current+0x17/0x19 [reiser4]
       [<fe604f5a>] txnmgr_force_commit_all+0x29/0x114 [reiser4]
       [<fe633724>] release_format40+0x66/0xdc [reiser4]
       [<fe60ff47>] reiser4_put_super+0x8f/0xc5 [reiser4]
       [<c017d8df>] generic_shutdown_super+0x67/0xdf
       [<c017e25a>] kill_block_super+0x20/0x32
       [<c017d7e9>] deactivate_super+0x5d/0x6f
       [<c0192532>] mntput_no_expire+0x52/0x85
       [<c018440f>] path_release_on_umount+0x15/0x18
       [<c0192b91>] sys_umount+0x69/0x71
       [<c0192ba6>] sys_oldumount+0xd/0xf
       [<c0103161>] sysenter_past_esp+0x56/0x8d
       [<b7f3c410>] 0xb7f3c410
       [<ffffffff>] 0xffffffff


other info that might help us debug this:

3 locks held by umount/2571:
 #0:  (&type->s_umount_key#20){--..}, at: [<c017d7e4>] deactivate_super+0x58/0x6f
 #1:  (&type->s_lock_key#12){--..}, at: [<c0302561>] mutex_lock+0x1c/0x1f
 #2:  (&atom->alock){--..}, at: [<fe604467>] txnh_get_atom+0x1c/0x78 [reiser4]

stack backtrace:
 [<c0103f69>] dump_trace+0x70/0x1ad
 [<c0104120>] show_trace_log_lvl+0x12/0x22
 [<c010413d>] show_trace+0xd/0xf
 [<c010420f>] dump_stack+0x17/0x19
 [<c01398cf>] print_circular_bug_tail+0x59/0x62
 [<c0139e0a>] check_prev_add+0x2b/0x1b4
 [<c0139fe0>] check_prevs_add+0x4d/0xaf
 [<c013ba22>] __lock_acquire+0x8a1/0x93c
 [<c013c128>] lock_acquire+0x6f/0x8f
 [<c0303e3d>] _spin_lock+0x23/0x2f
 [<fe60590d>] commit_txnh+0x3a/0xad [reiser4]
 [<fe60440a>] reiser4_txn_end+0x1a/0x28 [reiser4]
 [<fe604423>] reiser4_txn_restart+0xb/0x1a [reiser4]
 [<fe604449>] reiser4_txn_restart_current+0x17/0x19 [reiser4]
 [<fe604f5a>] txnmgr_force_commit_all+0x29/0x114 [reiser4]
 [<fe633724>] release_format40+0x66/0xdc [reiser4]
 [<fe60ff47>] reiser4_put_super+0x8f/0xc5 [reiser4]
 [<c017d8df>] generic_shutdown_super+0x67/0xdf
 [<c017e25a>] kill_block_super+0x20/0x32
 [<c017d7e9>] deactivate_super+0x5d/0x6f
 [<c0192532>] mntput_no_expire+0x52/0x85
 [<c018440f>] path_release_on_umount+0x15/0x18
 [<c0192b91>] sys_umount+0x69/0x71
 [<c0192ba6>] sys_oldumount+0xd/0xf
 [<c0103161>] sysenter_past_esp+0x56/0x8d
 [<b7f3c410>] 0xb7f3c410
 =======================

config & dmesg -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm2/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
