Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUGLSeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUGLSeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUGLSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:34:16 -0400
Received: from main.gmane.org ([80.91.224.249]:12227 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261405AbUGLSdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:33:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: 2.4.26: kernel BUG at page_alloc.c:235
Date: Mon, 12 Jul 2004 23:31:49 -0700
Message-ID: <m23c3wzacq.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:VEfH8EPyMdTL0T3eCm2DfFCJZ2A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.26 compiled with gcc-2.96 20000731 (RH7.1 2.96-85), running on
an Athlon XP2200+ clocked at 1800MHz.

Any ideas?

--J.

Jul 11 11:03:26 screech kernel: kernel BUG at page_alloc.c:235!
Jul 11 11:03:26 screech kernel: invalid operand: 0000
Jul 11 11:03:26 screech kernel: CPU:    0
Jul 11 11:03:26 screech kernel: EIP:    0010:[<c012f69e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 11 11:03:26 screech kernel: EFLAGS: 00010202
Jul 11 11:03:26 screech kernel: eax: 00000040   ebx: c125ca44   ecx: 00001000   edx: 0000dbde
Jul 11 11:03:26 screech kernel: esi: c02b86b8   edi: 00000001   ebp: 00000000   esp: d062be68
Jul 11 11:03:26 screech kernel: ds: 0018   es: 0018   ss: 0018
Jul 11 11:03:26 screech kernel: Process imapd (pid: 31910, stackpage=d062b000)
Jul 11 11:03:26 screech kernel: Stack: 00001000 0000cbde 00000282 00000000 c02b86b8 c02b888c 00000001 0000000c 
Jul 11 11:03:26 screech kernel:        00000001 c012f964 c02b86b8 c012e0b5 c125ca70 00000001 c02b86b8 c02b8888 
Jul 11 11:03:26 screech kernel:        00000000 000001d2 c125ca70 cffb3b34 00000010 00007637 df68c1a8 c0127cf1 
Jul 11 11:03:26 screech kernel: Call Trace:    [<c012f964>] [<c012e0b5>] [<c0127cf1>] [<c0128367>] [<c01285b8>]
Jul 11 11:03:26 screech kernel:   [<c0128bc6>] [<c0128ac0>] [<c0135975>] [<c0135640>] [<c01357ee>] [<c01086a3>]
Jul 11 11:03:26 screech kernel: Code: 0f 0b eb 00 73 ff 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b 

>>EIP; c012f69e <rmqueue+1fe/240>   <=====
Trace; c012f964 <__alloc_pages+74/2c0>
Trace; c012e0b5 <lru_cache_add+65/70>
Trace; c0127cf1 <page_cache_read+61/b0>
Trace; c0128367 <generic_file_readahead+117/150>
Trace; c01285b8 <do_generic_file_read+1d8/450>
Trace; c0128bc6 <generic_file_read+86/160>
Trace; c0128ac0 <file_read_actor+0/80>
Trace; c0135975 <sys_read+95/f0>
Trace; c0135640 <generic_file_llseek+0/b0>
Trace; c01357ee <sys_lseek+6e/80>
Trace; c01086a3 <system_call+33/38>
Code;  c012f69e <rmqueue+1fe/240>
00000000 <_EIP>:
Code;  c012f69e <rmqueue+1fe/240>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f6a0 <rmqueue+200/240>
   2:   eb 00                     jmp    4 <_EIP+0x4> c012f6a2 <rmqueue+202/240>
Code;  c012f6a2 <rmqueue+202/240>
   4:   73 ff                     jae    5 <_EIP+0x5> c012f6a3 <rmqueue+203/240>
Code;  c012f6a4 <rmqueue+204/240>
   6:   26 c0 8b 43 18 a9 80      rorb   $0x0,%es:0x80a91843(%ebx)
Code;  c012f6ab <rmqueue+20b/240>
   d:   00 
Code;  c012f6ac <rmqueue+20c/240>
   e:   00 00                     add    %al,(%eax)
Code;  c012f6ae <rmqueue+20e/240>
  10:   74 08                     je     1a <_EIP+0x1a> c012f6b8 <rmqueue+218/240>
Code;  c012f6b0 <rmqueue+210/240>
  12:   0f 0b                     ud2a   

Jul 11 11:03:29 screech kernel:  kernel BUG at page_alloc.c:235!
Jul 11 11:03:29 screech kernel: invalid operand: 0000
Jul 11 11:03:29 screech kernel: CPU:    0
Jul 11 11:03:29 screech kernel: EIP:    0010:[<c012f69e>]    Not tainted
Jul 11 11:03:29 screech kernel: EFLAGS: 00010202
Jul 11 11:03:29 screech kernel: eax: 00000040   ebx: c128cc18   ecx: 00001000   edx: 0000ed5d
Jul 11 11:03:29 screech kernel: esi: c02b86b8   edi: 00000001   ebp: 00000000   esp: d062be40
Jul 11 11:03:29 screech kernel: ds: 0018   es: 0018   ss: 0018
Jul 11 11:03:29 screech kernel: Process imapd (pid: 31916, stackpage=d062b000)
Jul 11 11:03:29 screech kernel: Stack: 00001000 0000dd5d 00000282 00000000 c02b86b8 c02b888c 00000001 0000000c 
Jul 11 11:03:29 screech kernel:        00000001 c012f964 c02b86b8 db31f7c0 ce38d8c0 ce38d8c0 c02b86b8 c02b8888 
Jul 11 11:03:29 screech kernel:        00000000 000001d2 ce38dd40 c138f4f4 00000001 ce38dd40 db9c98c0 c012590d 
Jul 11 11:03:29 screech kernel: Call Trace:    [<c012f964>] [<c012590d>] [<c0125eb4>] [<c0125a58>] [<c01264af>]
Jul 11 11:03:29 screech kernel:   [<c0114806>] [<c010d45a>] [<c012b48d>] [<c013550d>] [<c0114690>] [<c0108794>]
Jul 11 11:03:29 screech kernel: Code: 0f 0b eb 00 73 ff 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b 

>>EIP; c012f69e <rmqueue+1fe/240>   <=====
Trace; c012f964 <__alloc_pages+74/2c0>
Trace; c012590d <do_no_page+8d/180>
Trace; c0125eb4 <__vma_link+64/c0>
Trace; c0125a58 <handle_mm_fault+58/c0>
Trace; c01264af <do_mmap_pgoff+4af/560>
Trace; c0114806 <do_page_fault+176/4ab>
Trace; c010d45a <old_mmap+ea/120>
Trace; c012b48d <sys_mprotect+11d/208>
Trace; c013550d <filp_close+4d/60>
Trace; c0114690 <do_page_fault+0/4ab>
Trace; c0108794 <error_code+34/3c>
Code;  c012f69e <rmqueue+1fe/240>
00000000 <_EIP>:
Code;  c012f69e <rmqueue+1fe/240>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f6a0 <rmqueue+200/240>
   2:   eb 00                     jmp    4 <_EIP+0x4> c012f6a2 <rmqueue+202/240>
Code;  c012f6a2 <rmqueue+202/240>
   4:   73 ff                     jae    5 <_EIP+0x5> c012f6a3 <rmqueue+203/240>
Code;  c012f6a4 <rmqueue+204/240>
   6:   26 c0 8b 43 18 a9 80      rorb   $0x0,%es:0x80a91843(%ebx)
Code;  c012f6ab <rmqueue+20b/240>
   d:   00 
Code;  c012f6ac <rmqueue+20c/240>
   e:   00 00                     add    %al,(%eax)
Code;  c012f6ae <rmqueue+20e/240>
  10:   74 08                     je     1a <_EIP+0x1a> c012f6b8 <rmqueue+218/240>
Code;  c012f6b0 <rmqueue+210/240>
  12:   0f 0b                     ud2a   

18 warnings issued.  Results may not be reliable.

