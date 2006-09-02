Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWIBILc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWIBILc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIBILc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:11:32 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:16716 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750829AbWIBILb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:11:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TqEjRpZK1ZNfpnZZvNiPAoYTJtqgsruCewWowfwBICAIRkeaWPGptof5LYoqDeMJ1lhpXO/98/oBw3gOxfsOnO1zWGC7TJSo2262/kgH3fXBTj5Moup5/9DAbPMcYHvlOEtTO5wAr+/yJI4vvnPP9gg++vpuQpgA/uIJnrzN3uk=
Message-ID: <a44ae5cd0609020111l33a560cpea3d450d4be556aa@mail.gmail.com>
Date: Sat, 2 Sep 2006 01:11:30 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc5-mm1 -- possible circular locking dependency detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.18-rc5-mm1 #6
-------------------------------------------------------
wpa_supplicant/4658 is trying to acquire lock:
 (crypto_alg_sem){----}, at: [__crypto_lookup_template+20/168]
__crypto_lookup_template+0x14/0xa8

but task is already holding lock:
 ((crypto_chain).rwsem){----}, at:
[blocking_notifier_call_chain+14/45]
blocking_notifier_call_chain+0xe/0x2d

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 ((crypto_chain).rwsem){----}:
       [add_lock_to_list+95/125] add_lock_to_list+0x5f/0x7d
       [__lock_acquire+2327/2552] __lock_acquire+0x917/0x9f8
       [lock_acquire+86/116] lock_acquire+0x56/0x74
       [down_read+39/57] down_read+0x27/0x39
       [blocking_notifier_call_chain+14/45]
blocking_notifier_call_chain+0xe/0x2d
       [crypto_register_template+79/99] crypto_register_template+0x4f/0x63
       [hmac_module_init+13/15] hmac_module_init+0xd/0xf
       [init+141/531] init+0x8d/0x213
       [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
       [save_stack_trace+25/51] save_stack_trace+0x19/0x33
       [save_trace+63/200] save_trace+0x3f/0xc8
       [add_lock_to_list+95/125] add_lock_to_list+0x5f/0x7d
       [__lock_acquire+2327/2552] __lock_acquire+0x917/0x9f8
       [lock_acquire+86/116] lock_acquire+0x56/0x74
       [down_read+39/57] down_read+0x27/0x39
       [blocking_notifier_call_chain+14/45]
blocking_notifier_call_chain+0xe/0x2d
       [crypto_register_template+79/99] crypto_register_template+0x4f/0x63
       [hmac_module_init+13/15] hmac_module_init+0xd/0xf
       [init+141/531] init+0x8d/0x213
       [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
       [<ffffffff>] 0xffffffff

-> #0 (crypto_alg_sem){----}:
       [print_circular_bug_tail+48/100] print_circular_bug_tail+0x30/0x64
       [__lock_acquire+2126/2552] __lock_acquire+0x84e/0x9f8
       [lock_acquire+86/116] lock_acquire+0x56/0x74
       [down_read+39/57] down_read+0x27/0x39
       [__crypto_lookup_template+20/168] __crypto_lookup_template+0x14/0xa8
       [crypto_lookup_template+14/37] crypto_lookup_template+0xe/0x25
       [pg0+927817926/1051247616] cryptomgr_notify+0xc6/0x1e0 [cryptomgr]
       [notifier_call_chain+24/50] notifier_call_chain+0x18/0x32
       [blocking_notifier_call_chain+28/45]
blocking_notifier_call_chain+0x1c/0x2d
       [crypto_alg_mod_lookup+347/481] crypto_alg_mod_lookup+0x15b/0x1e1
       [crypto_alloc_base+21/96] crypto_alloc_base+0x15/0x60
       [prism2_wep_init+50/107] prism2_wep_init+0x32/0x6b
       [ieee80211_wx_set_encodeext+733/1345]
ieee80211_wx_set_encodeext+0x2dd/0x541
       [pg0+928579102/1051247616] bcm43xx_wx_set_encodingext+0x1f/0x21 [bcm43xx]
       [ioctl_standard_call+365/563] ioctl_standard_call+0x16d/0x233
       [wireless_process_ioctl+87/799] wireless_process_ioctl+0x57/0x31f
       [dev_ioctl+1072/1137] dev_ioctl+0x430/0x471
       [sock_ioctl+437/458] sock_ioctl+0x1b5/0x1ca
       [do_ioctl+36/102] do_ioctl+0x24/0x66
       [vfs_ioctl+600/619] vfs_ioctl+0x258/0x26b
       [sys_ioctl+70/99] sys_ioctl+0x46/0x63
       [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
       [save_stack_trace+25/51] save_stack_trace+0x19/0x33
       [save_trace+63/200] save_trace+0x3f/0xc8
       [print_circular_bug_tail+48/100] print_circular_bug_tail+0x30/0x64
       [__lock_acquire+2126/2552] __lock_acquire+0x84e/0x9f8
       [lock_acquire+86/116] lock_acquire+0x56/0x74
       [down_read+39/57] down_read+0x27/0x39
       [__crypto_lookup_template+20/168] __crypto_lookup_template+0x14/0xa8
       [crypto_lookup_template+14/37] crypto_lookup_template+0xe/0x25
       [pg0+927817926/1051247616] cryptomgr_notify+0xc6/0x1e0 [cryptomgr]
       [notifier_call_chain+24/50] notifier_call_chain+0x18/0x32
       [blocking_notifier_call_chain+28/45]
blocking_notifier_call_chain+0x1c/0x2d
       [crypto_alg_mod_lookup+347/481] crypto_alg_mod_lookup+0x15b/0x1e1
       [crypto_alloc_base+21/96] crypto_alloc_base+0x15/0x60
       [prism2_wep_init+50/107] prism2_wep_init+0x32/0x6b
       [ieee80211_wx_set_encodeext+733/1345]
ieee80211_wx_set_encodeext+0x2dd/0x541
       [pg0+928579102/1051247616] bcm43xx_wx_set_encodingext+0x1f/0x21 [bcm43xx]
       [ioctl_standard_call+365/563] ioctl_standard_call+0x16d/0x233
       [wireless_process_ioctl+87/799] wireless_process_ioctl+0x57/0x31f
       [dev_ioctl+1072/1137] dev_ioctl+0x430/0x471
       [sock_ioctl+437/458] sock_ioctl+0x1b5/0x1ca
       [do_ioctl+36/102] do_ioctl+0x24/0x66
       [vfs_ioctl+600/619] vfs_ioctl+0x258/0x26b
       [sys_ioctl+70/99] sys_ioctl+0x46/0x63
       [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

2 locks held by wpa_supplicant/4658:
 #0:  (rtnl_mutex){--..}, at: [mutex_lock+25/32] mutex_lock+0x19/0x20
 #1:  ((crypto_chain).rwsem){----}, at:
[blocking_notifier_call_chain+14/45]
blocking_notifier_call_chain+0xe/0x2d

stack backtrace:
 [dump_trace+105/439] dump_trace+0x69/0x1b7
 [show_trace_log_lvl+21/40] show_trace_log_lvl+0x15/0x28
 [show_trace+22/25] show_trace+0x16/0x19
 [dump_stack+24/29] dump_stack+0x18/0x1d
 [print_circular_bug_tail+89/100] print_circular_bug_tail+0x59/0x64
 [__lock_acquire+2126/2552] __lock_acquire+0x84e/0x9f8
 [lock_acquire+86/116] lock_acquire+0x56/0x74
 [down_read+39/57] down_read+0x27/0x39
 [__crypto_lookup_template+20/168] __crypto_lookup_template+0x14/0xa8
 [crypto_lookup_template+14/37] crypto_lookup_template+0xe/0x25
 [pg0+927817926/1051247616] cryptomgr_notify+0xc6/0x1e0 [cryptomgr]
 [notifier_call_chain+24/50] notifier_call_chain+0x18/0x32
 [blocking_notifier_call_chain+28/45] blocking_notifier_call_chain+0x1c/0x2d
 [crypto_alg_mod_lookup+347/481] crypto_alg_mod_lookup+0x15b/0x1e1
 [crypto_alloc_base+21/96] crypto_alloc_base+0x15/0x60
 [prism2_wep_init+50/107] prism2_wep_init+0x32/0x6b
 [ieee80211_wx_set_encodeext+733/1345] ieee80211_wx_set_encodeext+0x2dd/0x541
 [pg0+928579102/1051247616] bcm43xx_wx_set_encodingext+0x1f/0x21 [bcm43xx]
 [ioctl_standard_call+365/563] ioctl_standard_call+0x16d/0x233
 [wireless_process_ioctl+87/799] wireless_process_ioctl+0x57/0x31f
 [dev_ioctl+1072/1137] dev_ioctl+0x430/0x471
 [sock_ioctl+437/458] sock_ioctl+0x1b5/0x1ca
 [do_ioctl+36/102] do_ioctl+0x24/0x66
 [vfs_ioctl+600/619] vfs_ioctl+0x258/0x26b
 [sys_ioctl+70/99] sys_ioctl+0x46/0x63
 [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d

Leftover inexact backtrace:

 [show_trace_log_lvl+21/40] show_trace_log_lvl+0x15/0x28
 [show_trace+22/25] show_trace+0x16/0x19
 [dump_stack+24/29] dump_stack+0x18/0x1d
 [print_circular_bug_tail+89/100] print_circular_bug_tail+0x59/0x64
 [__lock_acquire+2126/2552] __lock_acquire+0x84e/0x9f8
 [lock_acquire+86/116] lock_acquire+0x56/0x74
 [down_read+39/57] down_read+0x27/0x39
 [__crypto_lookup_template+20/168] __crypto_lookup_template+0x14/0xa8
 [crypto_lookup_template+14/37] crypto_lookup_template+0xe/0x25
 [pg0+927817926/1051247616] cryptomgr_notify+0xc6/0x1e0 [cryptomgr]
 [notifier_call_chain+24/50] notifier_call_chain+0x18/0x32
 [blocking_notifier_call_chain+28/45] blocking_notifier_call_chain+0x1c/0x2d
 [crypto_alg_mod_lookup+347/481] crypto_alg_mod_lookup+0x15b/0x1e1
 [crypto_alloc_base+21/96] crypto_alloc_base+0x15/0x60
 [prism2_wep_init+50/107] prism2_wep_init+0x32/0x6b
 [ieee80211_wx_set_encodeext+733/1345] ieee80211_wx_set_encodeext+0x2dd/0x541
 [pg0+928579102/1051247616] bcm43xx_wx_set_encodingext+0x1f/0x21 [bcm43xx]
 [ioctl_standard_call+365/563] ioctl_standard_call+0x16d/0x233
 [wireless_process_ioctl+87/799] wireless_process_ioctl+0x57/0x31f
 [dev_ioctl+1072/1137] dev_ioctl+0x430/0x471
 [sock_ioctl+437/458] sock_ioctl+0x1b5/0x1ca
 [do_ioctl+36/102] do_ioctl+0x24/0x66
 [vfs_ioctl+600/619] vfs_ioctl+0x258/0x26b
 [sys_ioctl+70/99] sys_ioctl+0x46/0x63
 [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
 =======================

-- 
VGER BF report: H 2.60902e-15
