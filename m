Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274897AbTHPSKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 14:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274899AbTHPSKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 14:10:10 -0400
Received: from remt25.cluster1.charter.net ([209.225.8.35]:57290 "EHLO
	remt25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S274897AbTHPSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 14:10:00 -0400
Date: Sat, 16 Aug 2003 14:09:23 -0400
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: 2.6.0-test3-mm2 kernel BUG at mm/filemap.c:1930 
Message-ID: <20030816180923.GA6332@charter.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test3-mm1 i686
X-Processor: Athlon XP 2000+
X-Uptime: 14:03:23 up 14 min,  5 users,  load average: 1.19, 1.66, 1.04
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this while trying to mount the rootfs.  It was ext3 if that makes
any diff.  

ksymoops 2.4.8 on i686 2.6.0-test3-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test3-mm1/ (default)
     -m /usr/src/2.5/linux-2.6.0-test2/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
<4>kernel BUG at mm/filemap.c:1930!
<4>invalid operand: 0000 [#1]
<4>CPU:    0
<4>EIP:    0060:[<c0137d19>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
<4>EFLAGS: 00010286
<4>eax: dfa7d140   ebx: 001f0000   ecx: dfbff3d8   edx: dfb9e298
<4>esi: 00000000   edi: dfb61f6c   ebp: dfb61e84   esp: dfb61e40
<4>ds: 007b   es: 007b   ss: 0068
<4>Stack: dfb78000 00000015 dfb60000 dfb60000 c01357bc dfd87980 dfd87a10 dfd65cc0 
<4>       dfb61e84 dfd65cc0 dfd65ce0 00001000 c0137e92 dfb61e84 dfb61f6c 00000001 
<4>       dfd65ce0 dfd65c40 00000246 00000000 00000001 ffffffff dfd65cc0 dfd5f2e8 
<4>Call Trace:
<4> [<c01357bc>] find_get_page+0x2c/0x60
<4> [<c0137e92>] generic_file_write_nolock+0xa2/0xc0
<4> [<c011c2d0>] autoremove_wake_function+0x0/0x50
<4> [<c01b50b0>] tty_write+0x0/0x300
<4> [<c0118cf1>] do_page_fault+0x251/0x454
<4> [<c01b514f>] tty_write+0x9f/0x300
<4> [<c015830f>] blkdev_put+0xcf/0x1b0
<4> [<c0158440>] blkdev_file_write+0x0/0x40
<4> [<c0158477>] blkdev_file_write+0x37/0x40
<4> [<c014fa78>] vfs_write+0xb8/0x130
<4> [<c0157300>] block_llseek+0x0/0xe0
<4> [<c014fba2>] sys_write+0x42/0x70
<4> [<c02ba907>] syscall_call+0x7/0xb
<4>Code: eb f2 8b 44 24 40 89 7c 24 04 c7 44 24 08 01 00 00 00 89 2c 24 89 44 24 0c e8 94 f4 ff ff 83 7d 10 ff 89 c7 75 ce e9 6f ff ff ff <0f> 0b 8a 07 7f f0 2c c0 e9 53 ff ff ff 8d 76 00 8d bc 27 00 00 


>>EIP; c0137d19 <generic_file_aio_write_nolock+e9/100>   <=====

>>eax; dfa7d140 <_end+1f6c1d88/3fc41c48>
>>ecx; dfbff3d8 <_end+1f844020/3fc41c48>
>>edx; dfb9e298 <_end+1f7e2ee0/3fc41c48>
>>edi; dfb61f6c <_end+1f7a6bb4/3fc41c48>
>>ebp; dfb61e84 <_end+1f7a6acc/3fc41c48>
>>esp; dfb61e40 <_end+1f7a6a88/3fc41c48>

Trace; c01357bc <find_get_page+2c/60>
Trace; c0137e92 <generic_file_write_nolock+a2/c0>
Trace; c011c2d0 <autoremove_wake_function+0/50>
Trace; c01b50b0 <tty_write+0/300>
Trace; c0118cf1 <do_page_fault+251/454>
Trace; c01b514f <tty_write+9f/300>
Trace; c015830f <blkdev_put+cf/1b0>
Trace; c0158440 <blkdev_file_write+0/40>
Trace; c0158477 <blkdev_file_write+37/40>
Trace; c014fa78 <vfs_write+b8/130>
Trace; c0157300 <block_llseek+0/e0>
Trace; c014fba2 <sys_write+42/70>
Trace; c02ba907 <syscall_call+7/b>

Code;  c0137cee <generic_file_aio_write_nolock+be/100>
00000000 <_EIP>:
Code;  c0137cee <generic_file_aio_write_nolock+be/100>
   0:   eb f2                     jmp    fffffff4 <_EIP+0xfffffff4>
Code;  c0137cf0 <generic_file_aio_write_nolock+c0/100>
   2:   8b 44 24 40               mov    0x40(%esp,1),%eax
Code;  c0137cf4 <generic_file_aio_write_nolock+c4/100>
   6:   89 7c 24 04               mov    %edi,0x4(%esp,1)
Code;  c0137cf8 <generic_file_aio_write_nolock+c8/100>
   a:   c7 44 24 08 01 00 00      movl   $0x1,0x8(%esp,1)
Code;  c0137cff <generic_file_aio_write_nolock+cf/100>
  11:   00 
Code;  c0137d00 <generic_file_aio_write_nolock+d0/100>
  12:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c0137d03 <generic_file_aio_write_nolock+d3/100>
  15:   89 44 24 0c               mov    %eax,0xc(%esp,1)
Code;  c0137d07 <generic_file_aio_write_nolock+d7/100>
  19:   e8 94 f4 ff ff            call   fffff4b2 <_EIP+0xfffff4b2>
Code;  c0137d0c <generic_file_aio_write_nolock+dc/100>
  1e:   83 7d 10 ff               cmpl   $0xffffffff,0x10(%ebp)
Code;  c0137d10 <generic_file_aio_write_nolock+e0/100>
  22:   89 c7                     mov    %eax,%edi
Code;  c0137d12 <generic_file_aio_write_nolock+e2/100>
  24:   75 ce                     jne    fffffff4 <_EIP+0xfffffff4>
Code;  c0137d14 <generic_file_aio_write_nolock+e4/100>
  26:   e9 6f ff ff ff            jmp    ffffff9a <_EIP+0xffffff9a>
Code;  c0137d19 <generic_file_aio_write_nolock+e9/100>   <=====
  2b:   0f 0b                     ud2a      <=====
Code;  c0137d1b <generic_file_aio_write_nolock+eb/100>
  2d:   8a 07                     mov    (%edi),%al
Code;  c0137d1d <generic_file_aio_write_nolock+ed/100>
  2f:   7f f0                     jg     21 <_EIP+0x21>
Code;  c0137d1f <generic_file_aio_write_nolock+ef/100>
  31:   2c c0                     sub    $0xc0,%al
Code;  c0137d21 <generic_file_aio_write_nolock+f1/100>
  33:   e9 53 ff ff ff            jmp    ffffff8b <_EIP+0xffffff8b>
Code;  c0137d26 <generic_file_aio_write_nolock+f6/100>
  38:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0137d29 <generic_file_aio_write_nolock+f9/100>
  3b:   8d                        .byte 0x8d
Code;  c0137d2a <generic_file_aio_write_nolock+fa/100>
  3c:   bc                        .byte 0xbc
Code;  c0137d2b <generic_file_aio_write_nolock+fb/100>
  3d:   27                        daa    


1 error issued.  Results may not be reliable.


-- 
--- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
Linux, the choice            | They that can give up essential liberty
of a GNU generation     -o)  | to obtain a little temporary safety deserve 
Kernel 2.4.20-ck6        /\  | neither liberty or safety. 
on a Athlon-XP          _\_v |                          -Benjamin Franklin
