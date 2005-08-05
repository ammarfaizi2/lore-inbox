Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVHEJmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVHEJmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVHEJmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:42:02 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:22452 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S262937AbVHEJj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:39:56 -0400
Subject: preempt with selinux NULL pointer dereference
From: antoine <antoine@nagafix.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Nagafix Ltd
Date: Fri, 05 Aug 2005 10:39:44 +0100
Message-Id: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After using it for a good few hours, I launched a shell script in a terminal and got the traces below.
I hope this helps (if not, please let me know how to make it helpful or I'll just stop testing -rc kernels and save myself some time)


[ 4788.218951] Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
[ 4788.218959] <ffffffff80247381>{inode_has_perm+81}
[ 4788.218971] PGD 2485f067 PUD 0
[ 4788.218975] Oops: 0000 [1] PREEMPT
[ 4788.218977] CPU 0
[ 4788.218979] Modules linked in: parport_pc lp parport eeprom i2c_sensor i2c_viapro i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod hotkey container tsdev usbhid yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp via_ircc irda crc_ccitt
[ 4788.218995] Pid: 19002, comm: ssh Tainted: G   M  2.6.13-rc5
[ 4788.218998] RIP: 0010:[<ffffffff80247381>] <ffffffff80247381>{inode_has_perm+81}
[ 4788.219005] RSP: 0018:ffff81004f987df8  EFLAGS: 00010286
[ 4788.219009] RAX: ffff81004f987e88 RBX: ffff810041e915a0 RCX: ffff81004f987e88
[ 4788.219013] RDX: 0000000000000002 RSI: ffff81004d0e1520 RDI: ffff8100329b0330
[ 4788.219017] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff81004f987e88
[ 4788.219020] R10: 0000000000000000 R11: 0000000000000246 R12: ffff81004d0e1520
[ 4788.219024] R13: ffff810032cec600 R14: 0000000000000002 R15: ffff81004f987e88
[ 4788.219029] FS:  00002aaaabb67f60(0000) GS:ffffffff80625800(0000) knlGS:00000000afb6abb0
[ 4788.219032] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 4788.219035] CR2: 0000000000000028 CR3: 0000000026b34000 CR4: 00000000000006e0
[ 4788.219039] Process ssh (pid: 19002, threadinfo ffff81004f986000, task ffff8100329b0330)
[ 4788.219042] Stack: ffff81004f987f08 0000000000000000 7fffffffffffffff ffff810039af4620
[ 4788.219048]        ffff810039af4628 ffff810039af4630 ffff810039af4608 ffff810039af4610
[ 4788.219054]        ffff810039af4618 0000000000000018
[ 4788.219058] Call Trace:<ffffffff8024ca78>{selinux_file_permission+344} <ffffffff8015f062>{audit_syscall_entry+338}
[ 4788.219076]        <ffffffff80185155>{vfs_read+181} <ffffffff80185943>{sys_read+83}
[ 4788.219088]        <ffffffff8010ed52>{tracesys+209}
[ 4788.219098]
[ 4788.219099] Code: 0f b7 55 28 8b 75 24 49 89 c8 41 8b 7d 14 44 89 f1 e8 29 fd
[ 4788.219108] RIP <ffffffff80247381>{inode_has_perm+81} RSP <ffff81004f987df8>
[ 4788.219114] CR2: 0000000000000028
[ 4788.219116]  <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
[ 4788.220081] <ffffffff80247381>{inode_has_perm+81}
[ 4788.220087] PGD 72aa067 PUD 3695b067 PMD 0
[ 4788.220090] Oops: 0000 [2] PREEMPT
[ 4788.220093] CPU 0
[ 4788.220094] Modules linked in: parport_pc lp parport eeprom i2c_sensor i2c_viapro i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod hotkey container tsdev usbhid yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp via_ircc irda crc_ccitt
[ 4788.220109] Pid: 18983, comm: bash Tainted: G   M  2.6.13-rc5
[ 4788.220112] RIP: 0010:[<ffffffff80247381>] <ffffffff80247381>{inode_has_perm+81}
[ 4788.220118] RSP: 0018:ffff81001af21e18  EFLAGS: 00010286
[ 4788.220123] RAX: ffff81001af21eb8 RBX: ffff810041e915a0 RCX: ffff81001af21eb8
[ 4788.220127] RDX: 0000000000000001 RSI: ffff81004d0e1520 RDI: ffff8100329b10d0
[ 4788.220130] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff81001af21eb8
[ 4788.220133] R10: 0000000000000008 R11: 0000000000000246 R12: ffff81004d0e1520
[ 4788.220137] R13: ffff81002f8ac180 R14: 0000000000000001 R15: ffff8100329b10d0
[ 4788.220142] FS:  00002aaaaaad2ee0(0000) GS:ffffffff80625800(0000) knlGS:00000000afb6abb0
[ 4788.220145] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 4788.220148] CR2: 0000000000000028 CR3: 0000000035847000 CR4: 00000000000006e0
[ 4788.220152] Process bash (pid: 18983, threadinfo ffff81001af20000, task ffff8100329b10d0)
[ 4788.220155] Stack: 0000000000000004 ffff8100329b0330 ffff81004feede40 ffffffffffffffef
[ 4788.220160]        ffffffff8016a483 0000000000000010 0000000000000292 ffff81001af21e68
[ 4788.220166]        0000000000000018 0000000000000292
[ 4788.220168] Call Trace:<ffffffff8016a483>{kmem_cache_free+99} <ffffffff8024cdc2>{selinux_file_ioctl+770}
[ 4788.220180]        <ffffffff80199ca5>{sys_ioctl+85} <ffffffff8010ed52>{tracesys+209}
[ 4788.220192]
[ 4788.220197]
[ 4788.220198] Code: 0f b7 55 28 8b 75 24 49 89 c8 41 8b 7d 14 44 89 f1 e8 29 fd
[ 4788.220207] RIP <ffffffff80247381>{inode_has_perm+81} RSP <ffff81001af21e18>
[ 4788.220213] CR2: 0000000000000028
[ 4788.220215]  <1>Unable to handle kernel NULL pointer dereference at 00000000000001f0 RIP:
[ 4788.220489] <ffffffff801b04c1>{inotify_dentry_parent_queue_event+65}
[ 4788.220495] PGD 0
[ 4788.220497] Oops: 0000 [3] PREEMPT
[ 4788.220499] CPU 0
[ 4788.220501] Modules linked in: parport_pc lp parport eeprom i2c_sensor i2c_viapro i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod hotkey container tsdev usbhid yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp via_ircc irda crc_ccitt
[ 4788.220515] Pid: 18983, comm: bash Tainted: G   M  2.6.13-rc5
[ 4788.220518] RIP: 0010:[<ffffffff801b04c1>] <ffffffff801b04c1>{inotify_dentry_parent_queue_event+65}
[ 4788.220524] RSP: 0018:ffff81001af21b48  EFLAGS: 00010213
[ 4788.220528] RAX: 00000000000001f0 RBX: ffff81004f8f0000 RCX: ffff810041e91654
[ 4788.220531] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000001
[ 4788.220535] RBP: 0000000000000000 R08: ffff81004f474d60 R09: ffff81001af21ba8
[ 4788.220538] R10: 0000000000000006 R11: 000000000000000a R12: ffff810041e91654
[ 4788.220541] R13: 0000000000000000 R14: 0000000000000008 R15: ffff810000ea8a40
[ 4788.220546] FS:  00002aaaaaad2ee0(0000) GS:ffffffff80625800(0000) knlGS:00000000afb6abb0
[ 4788.220549] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 4788.220552] CR2: 00000000000001f0 CR3: 0000000035847000 CR4: 00000000000006e0
[ 4788.220556] Process bash (pid: 18983, threadinfo ffff81001af20000, task ffff8100329b10d0)
[ 4788.220559] Stack: 0000000000000008 ffff810018ad7880 ffff81004f881d80 ffff81004d0e1520
[ 4788.220564]        ffff810041e915a0 ffffffff80186036 ffff810018ad7880 0000000000000000
[ 4788.220570]        ffff81003dfcf880 0000000000000000
[ 4788.220573] Call Trace:<ffffffff80186036>{__fput+102} <ffffffff80183028>{filp_close+104}
[ 4788.220583]        <ffffffff80138644>{put_files_struct+116} <ffffffff8013985a>{do_exit+554}
[ 4788.220593]        <ffffffff802b2a3e>{do_unblank_screen+110} <ffffffff801239ef>{do_page_fault+1823}
[ 4788.220604]        <ffffffff80167292>{__alloc_pages+242} <ffffffff8010f4e1>{error_exit+0}
[ 4788.220619]        <ffffffff80247381>{inode_has_perm+81} <ffffffff8016a483>{kmem_cache_free+99}
[ 4788.220632]        <ffffffff8024cdc2>{selinux_file_ioctl+770} <ffffffff80199ca5>{sys_ioctl+85}
[ 4788.220645]        <ffffffff8010ed52>{tracesys+209}
[ 4788.220654]
[ 4788.220654] Code: 48 3b 85 f0 01 00 00 74 76 8b 03 85 c0 75 10 0f 0b a3 93 48
[ 4788.220663] RIP <ffffffff801b04c1>{inotify_dentry_parent_queue_event+65} RSP <ffff81001af21b48>
[ 4788.220669] CR2: 00000000000001f0
[ 4788.220671]  <1>Fixing recursive fault but reboot is needed!
[ 4788.220674] scheduling while atomic: bash/0x00000001/18983
[ 4788.220676]
[ 4788.220677] Call Trace:<ffffffff803e438a>{schedule+122} <ffffffff803e5953>{__down_read+51}
[ 4788.220686]        <ffffffff80139746>{do_exit+278} <ffffffff802b2a3e>{do_unblank_screen+110}
[ 4788.220696]        <ffffffff801239ef>{do_page_fault+1823} <ffffffff80260b51>{sprintf+81}
[ 4788.220707]        <ffffffff80260b51>{sprintf+81} <ffffffff801669bc>{free_pages_bulk+748}
[ 4788.220714]        <ffffffff801669bc>{free_pages_bulk+748} <ffffffff8010f4e1>{error_exit+0}
[ 4788.220724]        <ffffffff801b04c1>{inotify_dentry_parent_queue_event+65}
[ 4788.220732]        <ffffffff801b04b2>{inotify_dentry_parent_queue_event+50}
[ 4788.220737]        <ffffffff80186036>{__fput+102} <ffffffff80183028>{filp_close+104}
[ 4788.220746]        <ffffffff80138644>{put_files_struct+116} <ffffffff8013985a>{do_exit+554}
[ 4788.220755]        <ffffffff802b2a3e>{do_unblank_screen+110} <ffffffff801239ef>{do_page_fault+1823}
[ 4788.220764]        <ffffffff80167292>{__alloc_pages+242} <ffffffff8010f4e1>{error_exit+0}
[ 4788.220778]        <ffffffff80247381>{inode_has_perm+81} <ffffffff8016a483>{kmem_cache_free+99}
[ 4788.220791]        <ffffffff8024cdc2>{selinux_file_ioctl+770} <ffffffff80199ca5>{sys_ioctl+85}
[ 4788.220804]        <ffffffff8010ed52>{tracesys+209}
[ 5241.139821] VM: killing process knotify
[ 5241.140773] swap_free: Unused swap offset entry 0000ca00
[ 5241.140776] swap_free: Unused swap offset entry 00007f00
[ 5657.448114] swap_free: Unused swap offset entry 00000500
[ 7515.852463] swap_free: Unused swap offset entry 00000500
[ 7529.259013] swap_free: Unused swap offset entry 00000500
[ 7548.939960] swap_free: Unused swap offset entry 00000500
[ 7566.221556] swap_free: Unused swap offset entry 00000500
[ 7581.346474] swap_free: Unused swap offset entry 00000500
[ 7795.683011] swap_free: Unused swap offset entry 00000500
[ 7966.361957] swap_free: Unused swap offset entry 00000500
[ 7998.327198] swap_free: Unused swap offset entry 00000500
[ 8024.551757] swap_free: Unused swap offset entry 00000500
[ 8056.434943] swap_free: Unused swap offset entry 00000500
[ 8198.760027] swap_free: Unused swap offset entry 00000500
[16512.532399] warning: many lost ticks.
[16512.532402] Your time source seems to be instable or some driver is hogging interupts
[16512.532412] rip handle_IRQ_event+0x1a/0x60
[58514.912605] swap_free: Unused swap offset entry 00000500
[58524.926814] device lo left promiscuous mode


