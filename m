Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291707AbSBALgD>; Fri, 1 Feb 2002 06:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291714AbSBALfx>; Fri, 1 Feb 2002 06:35:53 -0500
Received: (root@vger.kernel.org) by vger.kernel.org id <S291707AbSBALfk>;
	Fri, 1 Feb 2002 06:35:40 -0500
Received: from Expansa.sns.it ([192.167.206.189]:64268 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291674AbSBAKgj>;
	Fri, 1 Feb 2002 05:36:39 -0500
Date: Fri, 1 Feb 2002 11:36:33 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: reiser@namesys.com, <linux-kernel@vger.kernel.org>
Subject: ReiserFS oops with 2.5.3
Message-ID: <Pine.LNX.4.44.0202011126480.26379-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
I was trying kernel 2.5.3 on pentiumIII, and immediatelly after boot, I
get this oops:

PAP-5580: reiserfs_cut_from_item: item to convert does not exist ([1811
1812 0x1 IND])invalid operand: 0000
(addresses may change depending on which process oopsed)

here is ksymoops output:

CPU:    0
EIP:    0010:[<c015fdd9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000059   ebx: c01e79c0   ecx: 00000001   edx: cf22c000
esi: c154b800   edi: 00000000   ebp: cef0fe4c   esp: cef0fc50
ds: 0018   es: 0018   ss: 0018
Process rwhod (pid: 98, stackpage=cef0f000)
Stack: c01e653a c0253380 c01e79c0 cef0fc74 cef0fcac 00000000 c0166e3c c154b800
       c01e79c0 cef0fe8c cec754a0 00000003 00000011 00000013 00001000 00000000
       00000001 cef0fcb0 00000fa8 00000001 00000fa8 c154b800 630000a2 00000000
Call Trace: [<c0166e3c>] [<c0167439>] [<c015903e>] [<c0159dbb>] [<c012f6b4>]
   [<c012e77c>] [<c012e7c7>] [<c0108597>]
Code: 0f 0b 68 80 33 25 c0 b8 40 65 1e c0 8d 96 cc 00 00 00 85 f6

>>EIP; c015fdd8 <reiserfs_panic+28/4c>   <=====
Trace; c0166e3c <reiserfs_cut_from_item+1b4/454>
Trace; c0167438 <reiserfs_do_truncate+314/444>
Trace; c015903e <reiserfs_truncate_file+c6/158>
Trace; c0159dba <reiserfs_file_release+31a/340>
Trace; c012f6b4 <fput+4c/d0>
Trace; c012e77c <filp_close+60/68>
Trace; c012e7c6 <sys_close+42/54>
Trace; c0108596 <syscall_traced+6/a>
Code;  c015fdd8 <reiserfs_panic+28/4c>
00000000 <_EIP>:
Code;  c015fdd8 <reiserfs_panic+28/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015fdda <reiserfs_panic+2a/4c>
   2:   68 80 33 25 c0            push   $0xc0253380
Code;  c015fdde <reiserfs_panic+2e/4c>
   7:   b8 40 65 1e c0            mov    $0xc01e6540,%eax
Code;  c015fde4 <reiserfs_panic+34/4c>
   c:   8d 96 cc 00 00 00         lea    0xcc(%esi),%edx
Code;  c015fdea <reiserfs_panic+3a/4c>
  12:   85 f6                     test   %esi,%esi

This test system is:
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 930.255
cache size      : 256 KB
Memory		: 256 MB
with: Intel i810 MB, (Intel Corporation 82801AA)
The system has one (E)IDE disk ATA66 with 2MB cache.

The strange thing is that yesterday this kernel was running fine with
reiserFS on my Athlon 1300 Mhz (Via chipset), with scsi disks and Adaptec
2940UW.

I hope this helps, and I am willing to test patches.

Luigi Genoni


