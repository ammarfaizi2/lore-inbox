Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVDHROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVDHROp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVDHROp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:14:45 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:58516 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262879AbVDHRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:12:37 -0400
Date: Fri, 08 Apr 2005 13:08:27 -0400 (EDT)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: IDE_CS problems with Compact Flash
To: linux-kernel@vger.kernel.org
Message-id: <20050408170827.8424525DDB@X31.networkingunlimited.com>
Organization: Networking Unlimited, Inc.
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing strange results when using compact flash in a ThinkPad X31. Seems
to work OK, but when the card is inserted or the system is booted with
the card already inserted, I get a few hundred lines of complaint in the
syslog. Prior to 2.6.12-rc2-mm2, I also had problems shutting down.
Result would be that in order to read off the card, I would need to shut
down the system, remove the card, reboot, and then insert the card
again. During reboot, I'd get a message from PCMCIA about cleaning up
old devices. 

Note that the failure mode was the Compact Flash card would mount,
and I could read the root directory, but I could not read a file
in the root directory. The process doing the read would lock up in
"D" state and never (waited hours) return.

Any ideas about what is going on here? In particular is this a known
problem, a bad configuration on my part, or just plain bad luck?

Vince

Apr  8 12:33:27 localhost kernel: Kernel logging (proc) stopped.
Apr  8 12:33:27 localhost kernel: Kernel log daemon terminating.
Apr  8 12:33:28 localhost exiting on signal 15
Apr  8 12:35:29 localhost syslogd 1.4.1: restart (remote reception).
Apr  8 12:35:29 localhost cardmgr[3434]: executing: './ide start hde 2>&1'
Apr  8 12:35:29 localhost cardmgr[3434]: + dosfsck 2.10, 22 Sep 2003, FAT32, LFN
Apr  8 12:35:29 localhost cardmgr[3434]: + /dev/hde1: 35 files, 32099/63422 clusters
Apr  8 12:35:30 localhost cardmgr[3434]: + /dev/hde1 on /media/flash type vfat (rw)
Apr  8 12:35:34 localhost kernel: klogd 1.4.1, log source = /proc/kmsg started.
Apr  8 12:35:34 localhost kernel: 4> [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel: iounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0b2a307>] readable+0x67/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel:  0xc9a00000-0xca1fffffiounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<c0151ffd>] remove_vm_area+0x5d/0xa0
Apr  8 12:35:34 localhost kernel:  [<f0d68a30>] pcmcia_read_cis_mem+0x130/0x1b0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d68dca>] read_cis_cache+0x19a/0x1a0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d692c9>] follow_link+0x99/0x220 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69695>] pccard_get_next_tuple+0x245/0x2e0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69170>] pccard_get_first_tuple+0xa0/0x160 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d6ad27>] pccard_validate_cis+0x97/0x260 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0b2a2fa>] readable+0x5a/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel: iounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0b2a307>] readable+0x67/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel:  0xcaa00000-0xcb1fffffiounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<c0151ffd>] remove_vm_area+0x5d/0xa0
Apr  8 12:35:34 localhost kernel:  [<f0d68a30>] pcmcia_read_cis_mem+0x130/0x1b0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d68dca>] read_cis_cache+0x19a/0x1a0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d692c9>] follow_link+0x99/0x220 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69695>] pccard_get_next_tuple+0x245/0x2e0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69170>] pccard_get_first_tuple+0xa0/0x160 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d6ad27>] pccard_validate_cis+0x97/0x260 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0b2a2fa>] readable+0x5a/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel: iounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0b2a307>] readable+0x67/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel:  0xcba00000-0xcc1fffffiounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<c0151ffd>] remove_vm_area+0x5d/0xa0
Apr  8 12:35:34 localhost kernel:  [<f0d68a30>] pcmcia_read_cis_mem+0x130/0x1b0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d68dca>] read_cis_cache+0x19a/0x1a0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d692c9>] follow_link+0x99/0x220 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69695>] pccard_get_next_tuple+0x245/0x2e0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69170>] pccard_get_first_tuple+0xa0/0x160 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d6ad27>] pccard_validate_cis+0x97/0x260 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0b2a2fa>] readable+0x5a/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel: iounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0b2a307>] readable+0x67/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel:  0xcca00000-0xcd1fffffiounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<c0151ffd>] remove_vm_area+0x5d/0xa0
Apr  8 12:35:34 localhost kernel:  [<f0d68a30>] pcmcia_read_cis_mem+0x130/0x1b0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d68dca>] read_cis_cache+0x19a/0x1a0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d692c9>] follow_link+0x99/0x220 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69695>] pccard_get_next_tuple+0x245/0x2e0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69170>] pccard_get_first_tuple+0xa0/0x160 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d6ad27>] pccard_validate_cis+0x97/0x260 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0b2a2fa>] readable+0x5a/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel: iounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0b2a307>] readable+0x67/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel:  0xcda00000-0xce1fffffiounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<c0151ffd>] remove_vm_area+0x5d/0xa0
Apr  8 12:35:34 localhost kernel:  [<f0d68a30>] pcmcia_read_cis_mem+0x130/0x1b0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d688e8>] set_cis_map+0xe8/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d68dca>] read_cis_cache+0x19a/0x1a0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d692c9>] follow_link+0x99/0x220 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69695>] pccard_get_next_tuple+0x245/0x2e0 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d69170>] pccard_get_first_tuple+0xa0/0x160 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d6ad27>] pccard_validate_cis+0x97/0x260 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0b2a2fa>] readable+0x5a/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel: iounmap: bad address f0f5a000
Apr  8 12:35:34 localhost kernel:  [<f0b2a307>] readable+0x67/0xa0 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a4e5>] cis_readable+0xa5/0x100 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a73b>] do_mem_probe+0x11b/0x200 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0b2a864>] validate_mem+0x44/0x60 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<c0200000>] md5_transform+0x90/0x6f0
Apr  8 12:35:34 localhost kernel:  [<f0b2a8f8>] pcmcia_nonstatic_validate_mem+0x78/0x80 [rsrc_nonstatic]
Apr  8 12:35:34 localhost kernel:  [<f0d6b04a>] pcmcia_validate_mem+0x1a/0x30 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f6f96d>] pcmcia_card_add+0x2d/0xe0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0178524>] new_inode+0x24/0xb0
Apr  8 12:35:34 localhost kernel:  [<c039711d>] schedule+0x31d/0x630
Apr  8 12:35:34 localhost kernel:  [<c02040d7>] kobject_get+0x17/0x20
Apr  8 12:35:34 localhost kernel:  [<c026c9a8>] class_device_get+0x18/0x20
Apr  8 12:35:34 localhost kernel:  [<f0f703c2>] ds_event+0xf2/0x100 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<f0d67878>] send_event+0x88/0x100 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0d682c8>] pccard_register_pcmcia+0x88/0x90 [pcmcia_core]
Apr  8 12:35:34 localhost kernel:  [<f0f709c0>] pcmcia_bus_add_socket+0xa0/0xf0 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c026ca4d>] class_interface_register+0x8d/0xc0
Apr  8 12:35:34 localhost kernel:  [<f0f5801b>] init_pcmcia_bus+0x1b/0x30 [pcmcia]
Apr  8 12:35:34 localhost kernel:  [<c0134652>] sys_init_module+0x132/0x1f0
Apr  8 12:35:34 localhost kernel:  [<c0102c73>] sysenter_past_esp+0x5c/0x7d
Apr  8 12:35:34 localhost kernel:  0xcea00000-0xcf1fffff 0xcfa00000-0xd01fffff
Apr  8 12:35:34 localhost kernel: cs: memory probe 0xe8000000-0xefffffff: excluding 0xe8000000-0xefffffff
Apr  8 12:35:34 localhost kernel: Probing IDE interface ide2...
Apr  8 12:35:34 localhost kernel: hde: KCF001G-KT3, CFA DISK drive
Apr  8 12:35:34 localhost kernel: ide2 at 0x4100-0x4107,0x410e on irq 11
Apr  8 12:35:34 localhost kernel: hde: max request size: 128KiB
Apr  8 12:35:34 localhost kernel: hde: 2031120 sectors (1039 MB) w/0KiB Cache, CHS=2015/16/63
Apr  8 12:35:34 localhost kernel: hde: cache flushes not supported
Apr  8 12:35:34 localhost kernel:  hde: hde1
Apr  8 12:35:34 localhost kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Apr  8 12:35:34 localhost kernel:  hde: hde1
Apr  8 12:35:34 localhost kernel:  hde: hde1
Apr  8 12:35:34 localhost kernel: NET: Registered protocol family 10
Apr  8 12:35:34 localhost kernel: Disabled Privacy Extensions on device c040b060(lo)
Apr  8 12:35:34 localhost kernel: IPv6 over IPv4 tunneling driver
Apr  8 12:35:34 localhost kernel:  hde: hde1
Apr  8 12:35:36 localhost hcid[4016]: Bluetooth HCI daemon
Apr  8 12:35:36 localhost kernel: Bluetooth: L2CAP ver 2.7
Apr  8 12:35:36 localhost kernel: Bluetooth: L2CAP socket layer initialized
Apr  8 12:35:36 localhost sdpd[4018]: Bluetooth SDP daemon 
Apr  8 12:35:36 localhost hcid[4016]: HCI dev 0 up
Apr  8 12:35:36 localhost hcid[4016]: Starting security manager 0
Apr  8 12:35:36 localhost kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Apr  8 12:35:36 localhost hidd[4043]: Bluetooth HID daemon
Apr  8 12:35:36 localhost smartd[4073]: smartd version 5.32 Copyright (C) 2002-4 Bruce Allen 
Apr  8 12:35:36 localhost smartd[4073]: Home page is http://smartmontools.sourceforge.net/  
Apr  8 12:35:36 localhost smartd[4073]: Opened configuration file /etc/smartd.conf 
Apr  8 12:35:36 localhost smartd[4073]: Drive: DEVICESCAN, implied '-a' Directive on line 23 of file /etc/smartd.conf 
Apr  8 12:35:36 localhost smartd[4073]: Configuration file /etc/smartd.conf was parsed, found DEVICESCAN, scanning devices 
Apr  8 12:35:36 localhost smartd[4073]: Device: /dev/hda, opened 
Apr  8 12:35:36 localhost smartd[4073]: Device: /dev/hda, not found in smartd database. 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdb, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdb at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost kernel: /dev/vmmon[4087]: VMMON CPUID: Unrecognized CPU
Apr  8 12:35:37 localhost kernel: /dev/vmmon[4087]: Module vmmon: registered with major=10 minor=165
Apr  8 12:35:37 localhost kernel: /dev/vmmon[4087]: Module vmmon: initialized
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdc, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdc at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdd, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdd at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hde, opened 
Apr  8 12:35:37 localhost kernel: hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Apr  8 12:35:37 localhost kernel: hde: drive_cmd: error=0x04 { DriveStatusError }
Apr  8 12:35:37 localhost kernel: ide: failed opcode was: 0xa1
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hde, packet devices [this device Write-once (optical disk)] not SMART capable 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hde at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdf, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdf at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdg, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdg at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdh, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdh at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdi, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdi at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdj, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdj at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdk, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdk at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdl, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdl at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdm, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdm at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdn, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdn at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdo, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdo at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdp, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdp at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdq, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdq at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdr, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdr at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hds, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hds at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/hdt, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register ATA device /dev/hdt at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdc, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdc at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdd, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdd at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sde, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sde at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdf, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdf at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdg, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdg at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdh, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdh at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdi, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdi at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdj, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdj at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost kernel: /dev/vmnet: open called by PID 4138 (vmnet-bridge)
Apr  8 12:35:37 localhost kernel: /dev/vmnet: hub 0 does not exist, allocating memory.
Apr  8 12:35:37 localhost kernel: /dev/vmnet: port on hub 0 successfully opened
Apr  8 12:35:37 localhost kernel: bridge-eth0: peer interface eth0 not found, will wait for it to come up
Apr  8 12:35:37 localhost kernel: bridge-eth0: attached
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdk, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdk at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdl, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdl at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdm, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdm at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdn, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdn at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdo, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdo at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdp, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdp at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdq, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdq at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdr, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdr at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sds, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sds at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdt, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdt at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdu, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdu at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdv, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdv at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdw, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdw at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdx, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdx at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdy, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdy at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Device: /dev/sdz, No such device or address, open() failed 
Apr  8 12:35:37 localhost smartd[4073]: Unable to register SCSI device /dev/sdz at line 23 of file /etc/smartd.conf 
Apr  8 12:35:37 localhost smartd[4073]: Monitoring 1 ATA and 0 SCSI devices 
Apr  8 12:35:37 localhost smartd[4315]: smartd has fork()ed into background mode. New PID=4315. 
Apr  8 12:35:37 localhost kernel: /dev/vmnet: open called by PID 4253 (vmnet-natd)
Apr  8 12:35:37 localhost kernel: /dev/vmnet: hub 8 does not exist, allocating memory.
Apr  8 12:35:37 localhost kernel: /dev/vmnet: port on hub 8 successfully opened
Apr  8 12:35:39 localhost /etc/dev.d/block/50-hwscan.dev[4334]: new block device /block/hde
Apr  8 12:35:39 localhost /etc/dev.d/block/50-hwscan.dev[4344]: new block device /block/hde/hde1
Apr  8 12:35:39 localhost /etc/dev.d/block/50-hwscan.dev[4389]: new block device /block/hde/hde1
Apr  8 12:35:39 localhost /etc/dev.d/block/50-hwscan.dev[4428]: new block device /block/hde/hde1
Apr  8 12:35:40 localhost /etc/dev.d/block/50-hwscan.dev[4467]: new block device /block/hde/hde1
Apr  8 12:35:40 localhost kernel: Disabled Privacy Extensions on device edf18000(sit0)
Apr  8 12:35:40 localhost kernel: ath0: no IPv6 routers present
Apr  8 12:35:45 localhost ifup: No configuration found for sit0

                       # # #
