Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUILSsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUILSsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUILSsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:48:12 -0400
Received: from smtp0.telegraaf.nl ([217.196.45.192]:26297 "EHLO
	smtp0.telegraaf.nl") by vger.kernel.org with ESMTP id S268779AbUILSsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:48:06 -0400
Date: Sun, 12 Sep 2004 20:48:04 +0200
From: Roel van der Made <roel@telegraafnet.nl>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040912184804.GC19067@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
X-telegraaf-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This morning one of our (MySQL-)database serves crashed with the
following kernel trace. Anyone has an idea what could've caused it?
The machine is an SMP Xeon 2.8Ghz with 4G internal Reg. ECC ram running
4 scsi disks in sw raid 5 on a Debian (almost sid-)distribution.

The trace:

------------[ cut here ]------------
kernel BUG at kernel/exit.c:852!
invalid operand: 0000 [#1]
SMP
Modules linked in: ip_vs_wlc af_packet ipt_MARK iptable_mangle ip_tables ip_vs tg3 e1000 e100 eepro100 mii
nfsd exportfs nfs lockd sunrpc unix
CPU:    0
EIP:    0060:[<c011df03>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-mm4-fw-xeon.1)
EIP is at next_thread+0xc/0x41
eax: 00000000   ebx: 00000001   ecx: 00000001   edx: e93c3aa0
esi: 00000000   edi: e93c3aa0   ebp: 00000000   esp: f3893dd8
ds: 007b   es: 007b   ss: 0068
Process snmpd (pid: 1182, threadinfo=f3892000 task=f3fa1550)
Stack: c0182368 f3893f14 e93c3aa0 c016cecb c30c8a00 c011542b c03bfbe0 c30c8a00
       c017fcf6 e18d6eb0 e93c3aa0 0000000d c017fdad e93c3aa0 4143bbb4 247966f0
       c016c653 c03bfbe0 e18d6eb0 c03a4bc5 c01802a0 f3e56c20 e18d6eb0 0000000d
Call Trace:
 [<c0182368>] do_task_stat+0x279/0x752
 [<c016cecb>] alloc_inode+0x1b/0x146

 [<c011542b>] do_page_fault+0x19d/0x5c7
 [<c017fcf6>] task_dumpable+0x39/0x4a
 [<c017fdad>] proc_pid_make_inode+0xa6/0xe5
 [<c016c653>] d_rehash+0x55/0x79
 [<c01802a0>] proc_pident_lookup+0x100/0x26c
 [<c0161586>] real_lookup+0xcd/0xf0
 [<c016b468>] dput+0x24/0x209
 [<c0162247>] link_path_walk+0xa3e/0xd89
 [<c0182883>] proc_tgid_stat+0x1f/0x23
 [<c017f3ed>] proc_info_read+0x6a/0x9f
 [<c015417f>] vfs_read+0xbc/0x127
 [<c015444d>] sys_read+0x51/0x80
 [<c0105cdf>] syscall_call+0x7/0xb
Code: 8b 44 24 0c 89 04 24 e8 1d fc ff ff 83 ec 04 0f b6 44 24 08 c1 e0 08 89 04 24 e8 0a fc ff ff 89 c2
8b 80 d0 04 00 00 85 c0 75 08 <0f> 0b 54 03 e5

Thanks,

-- 
Roel van der Made                             .--.
GNU/Linux Systems/Network Engineer           |o_o |
Telegraaf Media ICT - Internet Services      |:_/ |
Tel.: 020 585 2229                          //   \ \
GnuPG Key available at: http://roel.net/gpgkey.asc 
