Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTDHKBS (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 06:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTDHKBR (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 06:01:17 -0400
Received: from attila.bofh.it ([213.92.8.2]:41418 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261294AbTDHKBN (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 06:01:13 -0400
Date: Tue, 8 Apr 2003 12:13:32 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: [2.5.67] BUG at kernel/softirq.c:105
Message-ID: <20030408101332.GC1738@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this happened after killing pppd, but I'm not 100% sure.

ksymoops 2.4.8 on i686 2.5.67.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.67/ (default)
     -m /boot/System.map-2.5.67 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr  8 10:52:54 wonderland kernel: kernel BUG at kernel/softirq.c:105!
Apr  8 10:52:54 wonderland kernel: invalid operand: 0000 [#1]
Apr  8 10:52:54 wonderland kernel: CPU:    0
Apr  8 10:52:54 wonderland kernel: EIP:    0060:[<c011c7b8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr  8 10:52:54 wonderland kernel: EFLAGS: 00010002
Apr  8 10:52:54 wonderland kernel: eax: 00000001   ebx: d8694000   ecx: 00000000   edx: d8694094
Apr  8 10:52:54 wonderland kernel: esi: 00000000   edi: 00000000   ebp: d81c3de4   esp: d81c3de4
Apr  8 10:52:54 wonderland kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 10:52:54 wonderland kernel: Stack: d81c3e14 e085bb80 00000000 dfe0aa40 dfe0aa40 d81c3e14 dfa93000 00000000 
Apr  8 10:52:54 wonderland kernel:        00000001 dfa93000 d8694000 dfa939e4 d81c3e28 e085b4d1 d8694000 dfa93000 
Apr  8 10:52:54 wonderland kernel:        d7fd5000 d81c3e3c c01e3fdb dfa93000 d7fd5000 dfa93000 d81c3e48 c01e0db3 
Apr  8 10:52:54 wonderland kernel: Call Trace:
Apr  8 10:52:54 wonderland kernel:  [<e085bb80>] ppp_async_push+0x90/0x170 [ppp_async]
Apr  8 10:52:54 wonderland kernel:  [<e085b4d1>] ppp_asynctty_wakeup+0x31/0x60 [ppp_async]
Apr  8 10:52:54 wonderland kernel:  [<c01e3fdb>] pty_unthrottle+0x5b/0x60
Apr  8 10:52:54 wonderland kernel:  [<c01e0db3>] check_unthrottle+0x33/0x40
Apr  8 10:52:54 wonderland kernel:  [<c01e0e34>] n_tty_flush_buffer+0x14/0x50
Apr  8 10:52:54 wonderland kernel:  [<c01e4374>] pty_flush_buffer+0x64/0x70
Apr  8 10:52:54 wonderland kernel:  [<c01de135>] do_tty_hangup+0x2f5/0x340
Apr  8 10:52:54 wonderland kernel:  [<c01df3b8>] release_dev+0x628/0x670
Apr  8 10:52:54 wonderland kernel:  [<c013766e>] zap_pmd_range+0x4e/0x70
Apr  8 10:52:54 wonderland kernel:  [<c01376d1>] unmap_page_range+0x41/0x70
Apr  8 10:52:54 wonderland kernel:  [<c01df7e1>] tty_release+0x11/0x20
Apr  8 10:52:54 wonderland kernel:  [<c0145a99>] __fput+0xc9/0xe0
Apr  8 10:52:54 wonderland kernel:  [<c01443db>] filp_close+0x4b/0x80
Apr  8 10:52:54 wonderland kernel:  [<c011a4d9>] put_files_struct+0x69/0xd0
Apr  8 10:52:54 wonderland kernel:  [<c011af60>] do_exit+0x100/0x300
Apr  8 10:52:54 wonderland kernel:  [<c011b224>] do_group_exit+0x54/0x80
Apr  8 10:52:54 wonderland kernel:  [<c010909f>] syscall_call+0x7/0xb
Apr  8 10:52:54 wonderland kernel: Code: 0f 0b 69 00 cd 02 2a c0 eb d1 8d b4 26 00 00 00 00 8d bc 27 


>>EIP; c011c7b8 <local_bh_enable+48/60>   <=====

>>ebx; d8694000 <__crc_posix_acl_equiv_mode+411010/4b5218>
>>edx; d8694094 <__crc_posix_acl_equiv_mode+4110a4/4b5218>
>>ebp; d81c3de4 <__crc_seq_open+3a99bd/468bc9>
>>esp; d81c3de4 <__crc_seq_open+3a99bd/468bc9>

Trace; e085bb80 <__crc_proc_root+12d1d8/363541>
Trace; e085b4d1 <__crc_proc_root+12cb29/363541>
Trace; c01e3fdb <pty_unthrottle+5b/60>
Trace; c01e0db3 <check_unthrottle+33/40>
Trace; c01e0e34 <n_tty_flush_buffer+14/50>
Trace; c01e4374 <pty_flush_buffer+64/70>
Trace; c01de135 <do_tty_hangup+2f5/340>
Trace; c01df3b8 <release_dev+628/670>
Trace; c013766e <zap_pmd_range+4e/70>
Trace; c01376d1 <unmap_page_range+41/70>
Trace; c01df7e1 <tty_release+11/20>
Trace; c0145a99 <__fput+c9/e0>
Trace; c01443db <filp_close+4b/80>
Trace; c011a4d9 <put_files_struct+69/d0>
Trace; c011af60 <do_exit+100/300>
Trace; c011b224 <do_group_exit+54/80>
Trace; c010909f <syscall_call+7/b>

Code;  c011c7b8 <local_bh_enable+48/60>
00000000 <_EIP>:
Code;  c011c7b8 <local_bh_enable+48/60>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011c7ba <local_bh_enable+4a/60>
   2:   69 00 cd 02 2a c0         imul   $0xc02a02cd,(%eax),%eax
Code;  c011c7c0 <local_bh_enable+50/60>
   8:   eb d1                     jmp    ffffffdb <_EIP+0xffffffdb>
Code;  c011c7c2 <local_bh_enable+52/60>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c011c7c9 <local_bh_enable+59/60>
  11:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi


1 warning and 1 error issued.  Results may not be reliable.

-- 
ciao, |
Marco | [326 abOXhLK0mwZ5w]
