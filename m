Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVCDBVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVCDBVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVCDBTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:19:19 -0500
Received: from hs-grafik.net ([80.237.205.72]:10636 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S261947AbVCDBQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:16:57 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5-mm1: reiser4 panic
Date: Fri, 4 Mar 2005 02:16:56 +0100
User-Agent: KMail/1.7.2
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040216.56889@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after my external USB hdd disconnected itself reiser4 paniced. I dont think a 
journalingfs should panic if its device fails..
Log:
scsi2 (0:0): rejecting I/O to dead device
reiser4[ktxnmgrd:dm-0:t(25324)]: reiser4_handle_error 
(fs/reiser4/vfs_ops.c:1315)[foobar-42]:
reiser4 panicked cowardly: Filesystem error occured

------------[ cut here ]------------
kernel BUG at fs/reiser4/debug.c:136!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: uhci_hcd ehci_hcd aes irtty_sir sir_dev
CPU:    0
EIP:    0060:[<c018a6f4>]    Tainted: G   M  VLI
EFLAGS: 00010246   (2.6.11-rc5-mm1)
EIP is at reiser4_do_panic+0x14/0x90
eax: 00000000   ebx: c3d92000   ecx: 00000000   edx: fffffd1b
esi: 00000000   edi: c3d92000   ebp: c3d93e90   esp: c3d93e58
ds: 007b   es: 007b   ss: 0068
Process ktxnmgrd:dm-0:t (pid: 25324, threadinfo=c3d92000 task=f48ad060)
Stack: c04793c0 c06d1a40 c04750d8 c01a7258 c0475383 c04750d8 00000523 f5111480
       c01a2155 eaef75c0 c3d93f6c c3d93ed0 c3d93ed8 c01a217e 00000051 c3d92000
       c0196d6e c0196e78 f781a040 f48ad060 f781a040 efac1800 c3d93ed0 c3d93f6c
Call Trace:
 [<c01a7258>] reiser4_handle_error+0xc8/0xd0
 [<c01a2155>] finish_all_fq+0x95/0xa0
 [<c01a217e>] current_atom_finish_all_fq+0x1e/0x60
 [<c0196d6e>] current_atom_complete_writes+0xe/0x30
 [<c0196e78>] commit_current_atom+0xe8/0x1e0
 [<c0197772>] try_commit_txnh+0x122/0x1a0
 [<c0197827>] commit_txnh+0x37/0xb0
 [<c019665e>] txn_end+0x2e/0x40
 [<c0196678>] txn_restart+0x8/0x20
 [<c01971d1>] commit_some_atoms+0xc1/0x140
 [<c01a2b4a>] scan_mgr+0x2a/0x50
 [<c024829f>] snprintf+0x1f/0x30
 [<c01a2a54>] ktxnmgrd+0x174/0x200
 [<c01a28e0>] ktxnmgrd+0x0/0x200
 [<c01012dd>] kernel_thread_helper+0x5/0x18
Code: 70 e8 9d 36 2c 00 eb 8d 8d 42 70 e8 93 36 2c 00 eb d0 90 90 90 90 90 83 
ec 0c a1 20 1a 6d c0 89 5c 24 08 8b 4c 24 10 85 c0 74 1d <0f> 0b 88 00 f5 49 
47 c0 c7 04 24 fb e5 48 c0 b8 40 1a 6d c0 89
 <6>note: ktxnmgrd:dm-0:t[25324] exited with preempt_count 1

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
