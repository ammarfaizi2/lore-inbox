Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271696AbTHHQdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTHHQbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:31:37 -0400
Received: from smtp.wp.pl ([212.77.101.161]:16055 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S271694AbTHHQbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:31:08 -0400
From: "Karol 'grzywacz' Nowak" <novaki@poczta.wp.pl>
To: linux-kernel@vger.kernel.org
Subject: an oops in 2.6-test2 (oops)
Date: Fri, 8 Aug 2003 18:29:52 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308062301.08595.novaki@poczta.wp.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed a bug in Linux version 2.6-test2 and I'm able to reproduce it. It 
occures while using xmms' "Add directory to playlist". The only module that 
was loaded at that time was 'rtc' and the kernel has been compiled with gcc  
3.3.1 (20030626 (Debian prerelease)). I have an AMD Athlon XP 1500+, 512MB of 
RAM and MSI motherboard with VIA KT133A. I hope that the following ksymoops 
output will be helpfull:


ksymoops 2.4.9 on i686 2.6.0-test2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2/ (default)
     -m /usr/src/linux/System.map (default)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0162b8a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0162b8a>]    Not tainted
EFLAGS: 00210286
eax: c153f338   ebx: 0000ff86   ecx: c1671d90   edx: 00000000
esi: dfdd9200   edi: c153f338   ebp: dfdd9200   esp: dbc1be34
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 dbc1a000 da6cd480 0000ff86 c0163210 dfdd9200 c153f338 0000ff86
       c153f338 0000ff86 da6cd480 dfdd9200 da6cd480 c018563b dfdd9200 0000ff86
       df74a12c fffffff4 df74be78 df74be10 c0157568 df74be10 da6cd480 dbc1bf38
Call Trace:
 [<c0163210>] iget_locked+0x50/0xc0
 [<c018563b>] ext3_lookup+0x6b/0xd0
 [<c0157568>] real_lookup+0xc8/0xf0
 [<c0157806>] do_lookup+0x96/0xb0
 [<c0157cb0>] link_path_walk+0x490/0x890
 [<c0158589>] __user_walk+0x49/0x60
 [<c01537df>] vfs_stat+0x1f/0x60
 [<c0153e9b>] sys_stat64+0x1b/0x40
 [<c0109087>] syscall_call+0x7/0xb
Code: 0f 18 02 90 39 59 18 89 c8 74 0f 85 d2 89 d1 75 ed 31 c0 83


>>EIP; c0162b8a <find_inode_fast+1a/60>   <=====

>>eax; c153f338 <_end+114bd00/3fc0a9c8>
>>ecx; c1671d90 <_end+127e758/3fc0a9c8>
>>esi; dfdd9200 <_end+1f9e5bc8/3fc0a9c8>
>>edi; c153f338 <_end+114bd00/3fc0a9c8>
>>ebp; dfdd9200 <_end+1f9e5bc8/3fc0a9c8>
>>esp; dbc1be34 <_end+1b8287fc/3fc0a9c8>

Trace; c0163210 <iget_locked+50/c0>
Trace; c018563b <ext3_lookup+6b/d0>
Trace; c0157568 <real_lookup+c8/f0>
Trace; c0157806 <do_lookup+96/b0>
Trace; c0157cb0 <link_path_walk+490/890>
Trace; c0158589 <__user_walk+49/60>
Trace; c01537df <vfs_stat+1f/60>
Trace; c0153e9b <sys_stat64+1b/40>
Trace; c0109087 <syscall_call+7/b>

Code;  c0162b8a <find_inode_fast+1a/60>
00000000 <_EIP>:
Code;  c0162b8a <find_inode_fast+1a/60>   <=====
   0:   0f 18 02                  prefetchnta (%edx)   <=====
Code;  c0162b8d <find_inode_fast+1d/60>
   3:   90                        nop
Code;  c0162b8e <find_inode_fast+1e/60>
   4:   39 59 18                  cmp    %ebx,0x18(%ecx)
Code;  c0162b91 <find_inode_fast+21/60>
   7:   89 c8                     mov    %ecx,%eax
Code;  c0162b93 <find_inode_fast+23/60>
   9:   74 0f                     je     1a <_EIP+0x1a>
Code;  c0162b95 <find_inode_fast+25/60>
   b:   85 d2                     test   %edx,%edx
Code;  c0162b97 <find_inode_fast+27/60>
   d:   89 d1                     mov    %edx,%ecx
Code;  c0162b99 <find_inode_fast+29/60>
   f:   75 ed                     jne    fffffffe <_EIP+0xfffffffe>
Code;  c0162b9b <find_inode_fast+2b/60>
  11:   31 c0                     xor    %eax,%eax
Code;  c0162b9d <find_inode_fast+2d/60>
  13:   83 00 00                  addl   $0x0,(%eax)


1 warning and 1 error issued.  Results may not be reliable.


-- 
Karol Nowak


