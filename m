Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTIJWoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTIJWnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:43:11 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:53474 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265911AbTIJWmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:42:21 -0400
Date: Wed, 10 Sep 2003 18:44:36 -0400
To: jfs-discussion@www-124.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: jfs 2.6.0-test4-mm6 Unable to handle kernel NULL pointer dereference
Message-ID: <20030910224436.GA17991@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test4-mm6 running dbench 64 on x86 IDE gave Oops.
2.6.0-test4-mm5 had no problem with the same workload.

jfsutils version 1.1.3, 05-Sep-2003

grep JFS /usr/src/linux/.config
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set


Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01bc829
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01bc829>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c5e5f5e4   ebx: 00000000   ecx: 00000000   edx: d8816b1e
esi: c6480b8c   edi: ce16fe20   ebp: c5e5f5e4   esp: ce16fdb0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000000 00000001 d8816b1e d8816b14 c696a528 c5e5f5ea c6480b80
       00000006 00000000 00000000 00000000 c5e5f5e4 c5e5f5e4 00000000 d27fad0c
       000001ae c5e5f540 c5e5f708 c5e5f5e4 00000002 c01b79e3 c5e5f5e4 00000002
 [<c01b79e3>] dtInsert+0xe3/0x200
 [<c01b7742>] dtSearch+0x2c2/0x480
 [<c01ba7f4>] dtInitRoot+0x54/0x100
 [<c01a664b>] jfs_mkdir+0x10b/0x220
 [<c0151bfb>] d_lookup+0x1b/0x40
 [<c01517db>] d_alloc+0x1b/0x1c0
 [<c01491ba>] cached_lookup+0x5a/0x80
 [<c0149f4a>] __lookup_hash+0x6a/0xa0
 [<c014aa63>] vfs_mkdir+0x43/0xa0
 [<c014ab4a>] sys_mkdir+0x8a/0xe0
 [<c0108d07>] syscall_call+0x7/0xb
Code: c6 41 08 ff e9 d4 fe ff ff ff 74 24 10 e8 05 4a 00 00 89 c7

>>EIP; c01bc829 <dtInsertEntry+3a9/440>   <=====
Code;  c01bc829 <dtInsertEntry+3a9/440>
00000000 <_EIP>:
Code;  c01bc829 <dtInsertEntry+3a9/440>   <=====
   0:   c6 41 08 ff               movb   $0xff,0x8(%ecx)   <=====
Code;  c01bc82d <dtInsertEntry+3ad/440>
   4:   e9 d4 fe ff ff            jmp    fffffedd <_EIP+0xfffffedd> c01bc706 <dtInsertEntry+286/440>
Code;  c01bc832 <dtInsertEntry+3b2/440>
   9:   ff 74 24 10               pushl  0x10(%esp,1)
Code;  c01bc836 <dtInsertEntry+3b6/440>
   d:   e8 05 4a 00 00            call   4a17 <_EIP+0x4a17> c01c1240 <txLinelock+0/40>
Code;  c01bc83b <dtInsertEntry+3bb/440>
  12:   89 c7                     mov    %eax,%edi



-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

