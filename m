Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTIMEow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 00:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIMEow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 00:44:52 -0400
Received: from twix.hotpop.com ([204.57.55.70]:13202 "EHLO twix.hotpop.com")
	by vger.kernel.org with ESMTP id S261625AbTIMEou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 00:44:50 -0400
Subject: 2.6.0-test5-mm1 Oops using rm -rf  (SMP)
From: Dan <overridex@punkass.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063428062.24421.5.camel@nazgul.overridex.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Sep 2003 00:41:02 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, I'm using 2.6.0-test5-mm1 on my workstation and ran into this
problem:

bash-2.05b# rm -rf /usr/portage/packages/*
Segmentation fault

I ran the command again without thinking and it hung, with the process
being unkillable, dmesg reports:

Unable to handle kernel paging request at virtual address
2d7f9f0e
 printing eip:
c01d7e2f
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<c01d7e2f>]    Tainted: PF  VLI
EFLAGS: 00010206
EIP is at get_cnode+0x5f/0xa0
eax: 00000000   ebx: f760f800   ecx: 2d7f9ef6   edx: f9a7336c
esi: f77dcf10   edi: f76d9b00   ebp: 00000000   esp: ca715bdc
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 24061, threadinfo=ca714000 task=f596b940)
Stack: c0305d23 ca715e94 f760f800 c01dba25 f760f800 c1a14540
c1b14ba4                                             c03f62cc
       00000000 00000000 00000046 ca714000 00000000 d07e55b8
ca715c9c                                             00000000
       00000000 c01c8f46 ca715e94 f760f800 f77dcf10 00000000
c033d780                                             c033db00
Call Trace:
 [<c01dba25>] journal_mark_dirty+0x1d5/0x340
 [<c01c8f46>] fix_nodes+0x86/0x470
 [<c01d4e23>] reiserfs_cut_from_item+0x103/0x4e0
 [<c01db837>] journal_begin+0x27/0x30
 [<c01bb1a7>] reiserfs_unlink+0x247/0x3e0
 [<c014ed47>] do_no_page+0x1d7/0x3e0
 [<c016d07f>] permission+0x2f/0x50
 [<c016f7bd>] vfs_unlink+0xcd/0x1f0
 [<c016f9cd>] sys_unlink+0xed/0x140
 [<c02ea83b>] syscall_call+0x7/0xb

Code: 8b 83 78 01 00 00 8b 40 0c ff 88 84 00 00 00 8b bb 78 01
00 00 8                                            b 47 0c 8b
90 98 00 00 00 31 c0 85 d2 74 2a 8b 4a 14 85 c9 74 0d <c7>
41 18 00 00 00 00 8b bb 78 01 00 00 8b 47 0c 89 d7 89 88 98


I'm running gentoo on a dual athlon 1700+, 1G ram system with reiserfs
on lvm.  I'll be happy to provide any more info to anyone who wants it,
please cc me any replies. -Dan


