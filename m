Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTHLMIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270256AbTHLMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:08:50 -0400
Received: from attila.bofh.it ([213.92.8.2]:22225 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S270230AbTHLMHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:07:49 -0400
Date: Tue, 12 Aug 2003 14:07:36 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: "Karol 'grzywacz' Nowak" <novaki@poczta.wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: an oops in 2.6-test2 (oops)
Message-ID: <20030812120736.GB782@wonderland.linux.it>
References: <200308062301.08595.novaki@poczta.wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308062301.08595.novaki@poczta.wp.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 08, Karol 'grzywacz' Nowak <novaki@poczta.wp.pl> wrote:

 >I've noticed a bug in Linux version 2.6-test2 and I'm able to reproduce it. It 
 >occures while using xmms' "Add directory to playlist". The only module that 

I have been getting a few of these too (now with -test3), usually
reproducibles:


ksymoops 2.4.8 on i686 2.6.0-test3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test3/ (default)
     -m /boot/System.map-2.6.0-test3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Aug 12 12:58:55 wonderland kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 12 12:58:55 wonderland kernel: c015c80a
Aug 12 12:58:55 wonderland kernel: *pde = 00000000
Aug 12 12:58:55 wonderland kernel: Oops: 0000 [#1]
Aug 12 12:58:55 wonderland kernel: CPU:    0
Aug 12 12:58:55 wonderland kernel: EIP:    0060:[<c015c80a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 12 12:58:55 wonderland kernel: EFLAGS: 00010282
Aug 12 12:58:55 wonderland kernel: eax: c1539a0c   ebx: 0005fdd5   ecx: d4bcb710   edx: 00000000
Aug 12 12:58:55 wonderland kernel: esi: df586a00   edi: c1539a0c   ebp: dc753e48   esp: dc753e38
Aug 12 12:58:55 wonderland kernel: ds: 007b   es: 007b   ss: 0068
Aug 12 12:58:55 wonderland kernel: Stack: d2a61600 0005fdd5 0005fdd5 df586a00 dc753e6c c015cd0b df586a00 c1539a0c 
Aug 12 12:58:55 wonderland kernel:        0005fdd5 c1539a0c 0005fdd5 d25ca600 df586a00 dc753e8c c017bc77 df586a00 
Aug 12 12:58:55 wonderland kernel:        0005fdd5 d25da030 fffffff4 d2d7d9f8 d2d7d990 dc753eb0 c0152740 d2d7d990 
Aug 12 12:58:55 wonderland kernel: Call Trace:
Aug 12 12:58:55 wonderland kernel:  [<c015cd0b>] iget_locked+0x4b/0xa0
Aug 12 12:58:55 wonderland kernel:  [<c017bc77>] ext3_lookup+0x67/0xc0
Aug 12 12:58:55 wonderland kernel:  [<c0152740>] real_lookup+0xc0/0xf0
Aug 12 12:58:55 wonderland kernel:  [<c0152984>] do_lookup+0x84/0x90
Aug 12 12:58:55 wonderland kernel:  [<c0152d84>] link_path_walk+0x3f4/0x760
Aug 12 12:58:55 wonderland kernel:  [<c0153954>] open_namei+0x84/0x3d0
Aug 12 12:58:56 wonderland kernel:  [<c013c8c2>] free_pgtables+0x82/0xa0
Aug 12 12:58:56 wonderland kernel:  [<c0145f9c>] filp_open+0x3c/0x60
Aug 12 12:58:56 wonderland kernel:  [<c0146383>] sys_open+0x53/0x90
Aug 12 12:58:56 wonderland kernel:  [<c01090b3>] syscall_call+0x7/0xb
Aug 12 12:58:56 wonderland kernel: Code: 0f 18 02 90 39 59 18 89 c8 74 10 85 d2 89 d1 75 ed 31 c0 83 


>>EIP; c015c80a <find_inode_fast+1a/60>   <=====

>>eax; c1539a0c <__crc_lock_may_read+ec59e/101eac>
>>ecx; d4bcb710 <__crc_xfrm_state_update+ef9/5bd312>
>>esi; df586a00 <__crc_inet_family_ops+bcd4b/142f72>
>>edi; c1539a0c <__crc_lock_may_read+ec59e/101eac>
>>ebp; dc753e48 <__crc_zlib_deflateInit2_+59274/71ff7>
>>esp; dc753e38 <__crc_zlib_deflateInit2_+59264/71ff7>

Trace; c015cd0b <iget_locked+4b/a0>
Trace; c017bc77 <ext3_lookup+67/c0>
Trace; c0152740 <real_lookup+c0/f0>
Trace; c0152984 <do_lookup+84/90>
Trace; c0152d84 <link_path_walk+3f4/760>
Trace; c0153954 <open_namei+84/3d0>
Trace; c013c8c2 <free_pgtables+82/a0>
Trace; c0145f9c <filp_open+3c/60>
Trace; c0146383 <sys_open+53/90>
Trace; c01090b3 <syscall_call+7/b>

Code;  c015c80a <find_inode_fast+1a/60>
00000000 <_EIP>:
Code;  c015c80a <find_inode_fast+1a/60>   <=====
   0:   0f 18 02                  prefetchnta (%edx)   <=====
Code;  c015c80d <find_inode_fast+1d/60>
   3:   90                        nop    
Code;  c015c80e <find_inode_fast+1e/60>
   4:   39 59 18                  cmp    %ebx,0x18(%ecx)
Code;  c015c811 <find_inode_fast+21/60>
   7:   89 c8                     mov    %ecx,%eax
Code;  c015c813 <find_inode_fast+23/60>
   9:   74 10                     je     1b <_EIP+0x1b>
Code;  c015c815 <find_inode_fast+25/60>
   b:   85 d2                     test   %edx,%edx
Code;  c015c817 <find_inode_fast+27/60>
   d:   89 d1                     mov    %edx,%ecx
Code;  c015c819 <find_inode_fast+29/60>
   f:   75 ed                     jne    fffffffe <_EIP+0xfffffffe>
Code;  c015c81b <find_inode_fast+2b/60>
  11:   31 c0                     xor    %eax,%eax
Code;  c015c81d <find_inode_fast+2d/60>
  13:   83 00 00                  addl   $0x0,(%eax)


1 warning and 1 error issued.  Results may not be reliable.

-- 
ciao, |
Marco | [1262 arSPQOzWtTbXY]
