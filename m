Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVHDTtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVHDTtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVHDTtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:49:52 -0400
Received: from mx.winch-hebergement.net ([82.196.5.104]:63177 "EHLO
	mx.ifrance.com") by vger.kernel.org with ESMTP id S261392AbVHDTtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:49:49 -0400
Message-ID: <42F27161.2020702@winch-hebergement.net>
Date: Thu, 04 Aug 2005 21:49:53 +0200
From: Guillaume Pelat <gp@winch-hebergement.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs 3.6 + quota enabled, crash on delete (or maybe truncate)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 >> I'm having a crash with reiserfs 3.6 + user quota enabled, on
 >> 2.6.11.10 kernel (no smp), apparently when deleting files (or maybe
 >>  during a runcate operation). The problem seems to happen under high
 >>  load.
 >> When the error occurs, all the processes accessing the reiserfs
 >> partition seems to hang. This problem happened several times on
 >> different servers (having the same hardware configuration) during
 >> last weeks.

 > The attached patch should help to get rid of clm-2100 and to avoid
 > crash.
 > Also, I think you should reiserfsck sda3.

Thanks for your answer. I tried the patch attached to your mail, but it 
seems that it doesnt solve my problem :)
The error also occured after i did a reiserfsck on sda3, I also tested 
2.6.13-rc4 with your patch applied, without success (the error also 
occured on serveral servers having the same hardware configuration).

Here are the error logs:

------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c019ae2f>]    Not tainted VLI
EFLAGS: 00010296   (2.6.13-rc4-endy)
EIP is at reiserfs_panic+0x4f/0x80
eax: 00000053   ebx: c02b8fde   ecx: 00000000   edx: c02dfdac
esi: 00000000   edi: 00000140   ebp: e75b383c   esp: e75b3824
ds: 007b   es: 007b   ss: 0068
Process pure-ftpd (pid: 12771, threadinfo=e75b2000 task=f091d530)
Stack: c02bd610 c02b8fde c03acdc0 00000fa0 c0971154 00000002 e75b3864 
c01ac75f
        00000000 c02bf89c 00000fa0 00000002 00020000 00000000 c097101c 
00000000
        e75b38b8 c01939d3 c097101c 00000fd0 00000000 00000000 00000000 
00000000
Call Trace:
  [<c0102e5f>] show_stack+0x7f/0xa0
  [<c0103002>] show_registers+0x152/0x1c0
  [<c01031f8>] die+0xc8/0x140
  [<c0103325>] do_trap+0xb5/0xc0
  [<c010366c>] do_invalid_op+0xbc/0xd0
  [<c0102aa3>] error_code+0x4f/0x54
  [<c01ac75f>] direntry_check_left+0x8f/0x90
  [<c01939d3>] get_num_ver+0x303/0x350
  [<c01949ac>] ip_check_balance+0x3dc/0xbc0
  [<c0195948>] check_balance+0x58/0x70
  [<c019623b>] fix_nodes+0x15b/0x420
  [<c01a2daf>] reiserfs_cut_from_item+0x10f/0x570
  [<c01a359b>] reiserfs_do_truncate+0x2db/0x5e0
  [<c01a282f>] reiserfs_delete_object+0x3f/0x80
  [<c0189baf>] reiserfs_delete_inode+0xaf/0x150
  [<c0161835>] generic_delete_inode+0x95/0x130
  [<c0161a18>] generic_drop_inode+0x18/0x30
  [<c0161a86>] iput+0x56/0x80
  [<c018d07d>] reiserfs_new_inode+0x16d/0x7e0
  [<c0187d31>] reiserfs_create+0xc1/0x1f0
  [<c0156a4f>] vfs_create+0x9f/0x120
  [<c015732c>] open_namei+0x5cc/0x620
  [<c0146eac>] filp_open+0x3c/0x60
  [<c01471c5>] sys_open+0x55/0x90
  [<c0102889>] syscall_call+0x7/0xb
Code: 01 00 00 89 04 24 e8 31 fd ff ff c7 04 24 10 d6 2b c0 85 f6 89 d8 
0f 45 c7
ba c0 cd 3a c0 89
54 24 08 89 44 24 04 e8 21 80 f7 ff <0f> 0b 6a 01 2f 95 2b c0 c7 04 24 
34 d6 2b
c0 85 f6 be c0 cd 3
a
  Badness in do_exit at kernel/exit.c:787
  [<c0102e9e>] dump_stack+0x1e/0x30
  [<c0114fdc>] do_exit+0x2ec/0x300
  [<c010326f>] die+0x13f/0x140
  [<c0103325>] do_trap+0xb5/0xc0
  [<c010366c>] do_invalid_op+0xbc/0xd0
  [<c0102aa3>] error_code+0x4f/0x54
  [<c01ac75f>] direntry_check_left+0x8f/0x90
  [<c01939d3>] get_num_ver+0x303/0x350
  [<c01949ac>] ip_check_balance+0x3dc/0xbc0
  [<c0195948>] check_balance+0x58/0x70
  [<c019623b>] fix_nodes+0x15b/0x420
  [<c01a2daf>] reiserfs_cut_from_item+0x10f/0x570
  [<c01a359b>] reiserfs_do_truncate+0x2db/0x5e0
  [<c01a282f>] reiserfs_delete_object+0x3f/0x80
  [<c0189baf>] reiserfs_delete_inode+0xaf/0x150
  [<c0161835>] generic_delete_inode+0x95/0x130
  [<c0161a18>] generic_drop_inode+0x18/0x30
  [<c0161a86>] iput+0x56/0x80
  [<c018d07d>] reiserfs_new_inode+0x16d/0x7e0
  [<c0187d31>] reiserfs_create+0xc1/0x1f0
  [<c0156a4f>] vfs_create+0x9f/0x120
  [<c015732c>] open_namei+0x5cc/0x620
  [<c0146eac>] filp_open+0x3c/0x60
  [<c01471c5>] sys_open+0x55/0x90
  [<c0102889>] syscall_call+0x7/0xb

Best Regards,

Guillaume Pelat
