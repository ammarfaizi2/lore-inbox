Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUL0LXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUL0LXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 06:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUL0LXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 06:23:54 -0500
Received: from gw.c9x.org ([213.41.131.17]:41766 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S261489AbUL0LXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 06:23:51 -0500
Date: Mon, 27 Dec 2004 12:23:27 +0100
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel BUG at fs/namei.c:2333 (reiserfs related?)
Message-ID: <20041227112349.GA29389@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I just got that one with kernel 2.6.10-rc3-mm1:
  
kernel BUG at fs/namei.c:2333!
invalid operand: 0000 [#1]
SMP
Modules linked in: ipv6 sg raid5 xor raid1 raid0 linear dm_mirror dm_snapshot dm_mod qla2300 qla2xxx scsi_transport_fc sata_promise libata tg3
CPU:    2
EIP:    0060:[<c015b17d>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc3-mm1)
EIP is at page_put_link+0x8a/0x94
eax: 00000000   ebx: 00000000   ecx: f6c70ce4   edx: 00000000
esi: c55e1000   edi: 00000000   ebp: ff80e013   esp: c55e1e68
ds: 007b   es: 007b   ss: 0068
Process apache2 (pid: 5355, threadinfo=c55e1000 task=f73e0a60)
Stack: f6c70ce4 c0158145 c2e60aa0 c013128e ff803000 c018972a 00000001 c55e1f1c
       c3006900 f6c70ce4 fbc916a5 00000009 ff80e009 c55e1000 c0517c58 c55e1000
       00000000 ce922013 c0158061 00000000 00000000 ff80e000 48a1a66e 00000001
Call Trace:
 [<c0158145>] link_path_walk+0x30a/0xd69
 [<c013128e>] read_cache_page+0x7b/0x218
 [<c018972a>] reiserfs_readpage+0x0/0xc
 [<c0158061>] link_path_walk+0x226/0xd69
 [<c0158e8c>] path_lookup+0x90/0x14c
 [<c0159094>] __user_walk+0x2f/0x52
 [<c015435b>] vfs_stat+0x1d/0x4e
 [<c0287727>] sock_poll+0x12/0x14
 [<c01294fd>] autoremove_wake_function+0x0/0x43
 [<c0154983>] sys_stat64+0x12/0x2b
 [<c0174974>] dnotify_parent+0x35/0x95
 [<c014be58>] vfs_read+0xab/0x11d
 [<c015d431>] sys_poll+0x1b4/0x1e3
 [<c01f59a8>] copy_to_user+0x32/0x45
 [<c011abf8>] sys_gettimeofday+0x2c/0x65
 [<c0102439>] sysenter_past_esp+0x52/0x75
Code: 84 c0 75 02 5b c3 89 d8 5b e9 a3 d9 fd ff 0f 0b 5f 01 72 7a 2f c0 eb e0 89 d8 e8 92 d9 fd ff eb c8 0f 0b 5f 01 72 7a 2f c0 eb b2 <0f> 0b 1d 09 a5 a7 2f c0 eb 92 55 57 56 89 d6 31 d2 53 83 ec 18
  
