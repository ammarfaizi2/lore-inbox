Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272828AbTHPL1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272836AbTHPL1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:27:35 -0400
Received: from attila.bofh.it ([213.92.8.2]:1485 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S272828AbTHPL13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:27:29 -0400
Date: Sat, 16 Aug 2003 13:27:19 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: Re: an oops in 2.6-test2 (oops)
Message-ID: <20030816112719.GA1073@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12, Marco d'Itri <md@Linux.IT> wrote:

 >I have been getting a few of these too (now with -test3), usually
 >reproducibles:
I've got another one yesterday:


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
Aug 15 14:35:44 wonderland kernel: 8139too Fast Ethernet driver 0.9.26
Aug 16 07:26:51 wonderland kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 16 07:26:51 wonderland kernel: c015c80a
Aug 16 07:26:51 wonderland kernel: *pde = 00000000
Aug 16 07:26:51 wonderland kernel: Oops: 0000 [#1]
Aug 16 07:26:51 wonderland kernel: CPU:    0
Aug 16 07:26:51 wonderland kernel: EIP:    0060:[<c015c80a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 16 07:26:51 wonderland kernel: EFLAGS: 00010286
Aug 16 07:26:51 wonderland kernel: eax: c1521110   ebx: 0005fa96   ecx: d19b1b50   edx: 00000000
Aug 16 07:26:51 wonderland kernel: esi: df60aa00   edi: c1521110   ebp: cd54de2c   esp: cd54de1c
Aug 16 07:26:51 wonderland kernel: ds: 007b   es: 007b   ss: 0068
Aug 16 07:26:51 wonderland kernel: Stack: df530300 0005fa96 0005fa96 df60aa00 cd54de50 c015cd0b df60aa00 c1521110 
Aug 16 07:26:51 wonderland kernel:        0005fa96 c1521110 0005fa96 c615e300 df60aa00 cd54de70 c017bc77 df60aa00 
Aug 16 07:26:51 wonderland kernel:        0005fa96 df4facec fffffff4 df5c54b8 df5c5450 cd54de94 c0152740 df5c5450 
Aug 16 07:26:51 wonderland kernel: Call Trace:
Aug 16 07:26:51 wonderland kernel:  [<c015cd0b>] iget_locked+0x4b/0xa0
Aug 16 07:26:51 wonderland kernel:  [<c017bc77>] ext3_lookup+0x67/0xc0
Aug 16 07:26:51 wonderland kernel:  [<c0152740>] real_lookup+0xc0/0xf0
Aug 16 07:26:51 wonderland kernel:  [<c0152984>] do_lookup+0x84/0x90
Aug 16 07:26:51 wonderland kernel:  [<c0152d84>] link_path_walk+0x3f4/0x760
Aug 16 07:26:51 wonderland kernel:  [<c015353e>] __user_walk+0x3e/0x60
Aug 16 07:26:51 wonderland kernel:  [<c014efbe>] vfs_stat+0x1e/0x60
Aug 16 07:26:51 wonderland kernel:  [<c013c8c2>] free_pgtables+0x82/0xa0
Aug 16 07:26:51 wonderland kernel:  [<c013c956>] unmap_vma+0x76/0x80
Aug 16 07:26:51 wonderland kernel:  [<c014f62b>] sys_stat64+0x1b/0x40
Aug 16 07:26:51 wonderland kernel:  [<c014643b>] filp_close+0x4b/0x80
Aug 16 07:26:51 wonderland kernel:  [<c01464c1>] sys_close+0x51/0x60
Aug 16 07:26:51 wonderland kernel:  [<c01090b3>] syscall_call+0x7/0xb
Aug 16 07:26:51 wonderland kernel: Code: 0f 18 02 90 39 59 18 89 c8 74 10 85 d2 89 d1 75 ed 31 c0 83 


>>EIP; c015c80a <find_inode_fast+1a/60>   <=====

>>eax; c1521110 <__crc_lock_may_read+d3ca2/101eac>
>>ecx; d19b1b50 <__crc_find_inode_number+11efe1/25f51d>
>>esi; df60aa00 <__crc_inet_family_ops+140d4b/142f72>
>>edi; c1521110 <__crc_lock_may_read+d3ca2/101eac>
>>ebp; cd54de2c <__crc___scm_send+175362/1b3d66>
>>esp; cd54de1c <__crc___scm_send+175352/1b3d66>

Trace; c015cd0b <iget_locked+4b/a0>
Trace; c017bc77 <ext3_lookup+67/c0>
Trace; c0152740 <real_lookup+c0/f0>
Trace; c0152984 <do_lookup+84/90>
Trace; c0152d84 <link_path_walk+3f4/760>
Trace; c015353e <__user_walk+3e/60>
Trace; c014efbe <vfs_stat+1e/60>
Trace; c013c8c2 <free_pgtables+82/a0>
Trace; c013c956 <unmap_vma+76/80>
Trace; c014f62b <sys_stat64+1b/40>
Trace; c014643b <filp_close+4b/80>
Trace; c01464c1 <sys_close+51/60>
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
Marco | [1302 arB35F5/Z7koA]
