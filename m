Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbTE1PDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264761AbTE1PDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:03:10 -0400
Received: from [65.37.126.18] ([65.37.126.18]:9867 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S264760AbTE1PDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:03:07 -0400
Date: Wed, 28 May 2003 08:16:20 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: OOPs report
Message-ID: <20030528151620.GA21579@the-penguin.otak.com>
Mail-Followup-To: Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.5.70-mm1 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all I have a oops report, happened overnight don't know why,
other then it looks devfs related. 

System is running debian sid.

More then happy to be flamed, apply patches, dance a jig.



ksymoops 2.4.8 on i686 2.5.70-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.70-mm1/ (default)
     -m /System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at include/linux/list.h:140!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011a44b>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010093
eax: e4ddfea8   ebx: 00000296   ecx: e4ddfeb4   edx: df081e40
esi: df081e40   edi: e4dde000   ebp: e1048c80   esp: e4ddfe6c
ds: 007b   es: 007b   ss: 0068
Stack: e4ddfea8 c01a693c c037e360 e4ddfe98 d3a607e0 df081e3c efd4ebc0 00000000 
       c6cbf980 c0119140 00000000 00000000 00000286 00000000 e735f960 00000000 
       c6cbf980 c0119140 df081e40 df081e40 eee9c005 000056ed 00000001 e1048c80 
Call Trace:
 [<c01a693c>] devfs_d_revalidate_wait+0x12c/0x130
 [<c0119140>] default_wake_function+0x0/0x30
 [<c0119140>] default_wake_function+0x0/0x30
 [<c015631c>] do_lookup+0x6c/0xb0
 [<c0156770>] link_path_walk+0x410/0x790
 [<c01573c6>] open_namei+0x76/0x3d0
 [<c0148a0e>] filp_open+0x3e/0x70
 [<c0148e0b>] sys_open+0x5b/0x90
 [<c010a8cb>] syscall_call+0x7/0xb
Code: 53 89 d0 9c 5b fa 8d 4a 0c 8b 51 04 39 0a 75 1b 8b 40 0c 39 48 04 75 09 89 50 04 89 02 53 9d 5b c3 0f 0b 8d 00 f2 65 29 c0 eb ed <0f> 0b 8c 00 f2 65 29 c0 eb db 8d 74 26 00 8d bc 27 00 00 00 00 


>>EIP; c011a44b <remove_wait_queue+2b/40>   <=====

>>eax; e4ddfea8 <_end+24a50300/3fc6e458>
>>ecx; e4ddfeb4 <_end+24a5030c/3fc6e458>
>>edx; df081e40 <_end+1ecf2298/3fc6e458>
>>esi; df081e40 <_end+1ecf2298/3fc6e458>
>>edi; e4dde000 <_end+24a4e458/3fc6e458>
>>ebp; e1048c80 <_end+20cb90d8/3fc6e458>
>>esp; e4ddfe6c <_end+24a502c4/3fc6e458>

Trace; c01a693c <devfs_d_revalidate_wait+12c/130>
Trace; c0119140 <default_wake_function+0/30>
Trace; c0119140 <default_wake_function+0/30>
Trace; c015631c <do_lookup+6c/b0>
Trace; c0156770 <link_path_walk+410/790>
Trace; c01573c6 <open_namei+76/3d0>
Trace; c0148a0e <filp_open+3e/70>
Trace; c0148e0b <sys_open+5b/90>
Trace; c010a8cb <syscall_call+7/b>

Code;  c011a420 <remove_wait_queue+0/40>
00000000 <_EIP>:
Code;  c011a420 <remove_wait_queue+0/40>
   0:   53                        push   %ebx
Code;  c011a421 <remove_wait_queue+1/40>
   1:   89 d0                     mov    %edx,%eax
Code;  c011a423 <remove_wait_queue+3/40>
   3:   9c                        pushf  
Code;  c011a424 <remove_wait_queue+4/40>
   4:   5b                        pop    %ebx
Code;  c011a425 <remove_wait_queue+5/40>
   5:   fa                        cli    
Code;  c011a426 <remove_wait_queue+6/40>
   6:   8d 4a 0c                  lea    0xc(%edx),%ecx
Code;  c011a429 <remove_wait_queue+9/40>
   9:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c011a42c <remove_wait_queue+c/40>
   c:   39 0a                     cmp    %ecx,(%edx)
Code;  c011a42e <remove_wait_queue+e/40>
   e:   75 1b                     jne    2b <_EIP+0x2b>
Code;  c011a430 <remove_wait_queue+10/40>
  10:   8b 40 0c                  mov    0xc(%eax),%eax
Code;  c011a433 <remove_wait_queue+13/40>
  13:   39 48 04                  cmp    %ecx,0x4(%eax)
Code;  c011a436 <remove_wait_queue+16/40>
  16:   75 09                     jne    21 <_EIP+0x21>
Code;  c011a438 <remove_wait_queue+18/40>
  18:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c011a43b <remove_wait_queue+1b/40>
  1b:   89 02                     mov    %eax,(%edx)
Code;  c011a43d <remove_wait_queue+1d/40>
  1d:   53                        push   %ebx
Code;  c011a43e <remove_wait_queue+1e/40>
  1e:   9d                        popf   
Code;  c011a43f <remove_wait_queue+1f/40>
  1f:   5b                        pop    %ebx
Code;  c011a440 <remove_wait_queue+20/40>
  20:   c3                        ret    
Code;  c011a441 <remove_wait_queue+21/40>
  21:   0f 0b                     ud2a   
Code;  c011a443 <remove_wait_queue+23/40>
  23:   8d 00                     lea    (%eax),%eax
Code;  c011a445 <remove_wait_queue+25/40>
  25:   f2                        repnz
Code;  c011a446 <remove_wait_queue+26/40>
  26:   65                        gs
Code;  c011a447 <remove_wait_queue+27/40>
  27:   29 c0                     sub    %eax,%eax
Code;  c011a449 <remove_wait_queue+29/40>
  29:   eb ed                     jmp    18 <_EIP+0x18>
Code;  c011a44b <remove_wait_queue+2b/40>   <=====
  2b:   0f 0b                     ud2a      <=====
Code;  c011a44d <remove_wait_queue+2d/40>
  2d:   8c 00                     movl   %es,(%eax)
Code;  c011a44f <remove_wait_queue+2f/40>
  2f:   f2                        repnz
Code;  c011a450 <remove_wait_queue+30/40>
  30:   65                        gs
Code;  c011a451 <remove_wait_queue+31/40>
  31:   29 c0                     sub    %eax,%eax
Code;  c011a453 <remove_wait_queue+33/40>
  33:   eb db                     jmp    10 <_EIP+0x10>
Code;  c011a455 <remove_wait_queue+35/40>
  35:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c011a459 <remove_wait_queue+39/40>
  39:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi


1 error issued.  Results may not be reliable.
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


