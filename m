Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUJDVAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUJDVAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUJDVAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:00:43 -0400
Received: from netsonic.fi ([194.29.192.20]:53130 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id S268487AbUJDVAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:00:10 -0400
Date: Tue, 5 Oct 2004 00:00:06 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: linux-kernel@vger.kernel.org
Subject: Possible bug with 2.6.7 and jdb
Message-ID: <Pine.LNX.4.44.0410042336510.4897-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am running a vanilla 2.6.7 kernel with 3ware raid module loaded and my 
kernel had following error.

The machine is dual athlon.

I have some 400M journal configured and the chattr was something like 
"chattr -R -S +A +R *" for mailboxes with cyrus imapd running..

I can provide more data if requested, error occured after doing massive 
chattr to mailboxes and changing userland metadata attributes them these 
briefly after.

Is there a bug in ext3?

Assertion failure in journal_revoke() at fs/jbd/revoke.c:378: "!buffer_revoked(bh)"
------------[ cut here ]------------
kernel BUG at fs/jbd/revoke.c:378!
invalid operand: 0000 [#1]
SMP 
Modules linked in: ipv6 autofs4 w83781d adm1021 i2c_sensor i2c_i801 
i2c_dev i2c_core iptable_filter ip_tables ide_cd cdrom e1000 sg parport_pc 
parport microcode dm_mod usbcore thermal processor fan button ext3 jbd 
3w_9xxx sd_mod scsi_mod
CPU:    0
EIP:    0060:[<f8870a50>]    Not tainted
EFLAGS: 00010286   (2.6.7) 
EIP is at journal_revoke+0xcd/0x14a [jbd]
eax: 00000057   ebx: db8961dc   ecx: f700f2e0   edx: c02d809c
esi: db8961dc   edi: f7e2ce00   ebp: e5cf1208   esp: e6c1fd94
ds: 007b   es: 007b   ss: 0068
Process imapd (pid: 14339, threadinfo=e6c1e000 task=c2342740)
Stack: f887429c f8873546 f8874abd 0000017a f8874ae3 005b6105 005b6105 d94b2b1c 
       db8961dc e5cf1208 f88a16c2 e5cf1208 005b6105 db8961dc 005b6105 00001000 
       005b6105 d94b2a80 e5cf1208 d94b2b1c f88a3b8c e5cf1208 00000000 d94b2b1c 
Call Trace:
 [<f88a16c2>] ext3_forget+0x6a/0xe4 [ext3]
 [<f88a3b8c>] ext3_clear_blocks+0x105/0x151 [ext3]
 [<f88a3cfb>] ext3_free_data+0x123/0x13f [ext3]
 [<f88a4535>] ext3_truncate+0x5bf/0x60d [ext3]
 [<f886b564>] journal_start+0xab/0xd2 [jbd]
 [<c014328b>] zap_pmd_range+0x57/0x73
 [<f88a178f>] start_transaction+0x23/0x58 [ext3]
 [<f88a190b>] ext3_delete_inode+0xc0/0xe6 [ext3]
 [<f88a184b>] ext3_delete_inode+0x0/0xe6 [ext3]
 [<c016aac9>] generic_delete_inode+0x85/0x12e
 [<c016ad12>] iput+0x62/0x7c
 [<c01680e6>] dput+0xe7/0x193
 [<c01534cf>] __fput+0x80/0xc4
 [<c0145891>] remove_vm_struct+0x57/0x88
 [<c0146d3c>] unmap_vma_list+0x1c/0x28
 [<c0147153>] do_munmap+0x13b/0x181
 [<c01471de>] sys_munmap+0x45/0x66
 [<c0105ea9>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 7a 01 bd 4a 87 f8 eb 84 8b 87 b0 00 00 00 89 14 24 89 
 
[root@host sampsa]# uname -a
Linux host.x.fi 2.6.7 #1 SMP Wed Jul 14 20:09:42 EEST 2004 i686 i686 i386 GNU/Linux

Yours,
 Sampsa Ranta
 NetSonic

