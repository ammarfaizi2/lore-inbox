Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbTGWLGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbTGWLGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:06:23 -0400
Received: from village.ehouse.ru ([193.111.92.18]:34832 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S269900AbTGWLGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:06:08 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22pre6aa1
Date: Wed, 23 Jul 2003 15:21:15 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307231521.15897.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

This is during `swapoff -a`, on a heavily loaded box:

ksymoops 2.4.9 on i686 2.4.22-pre6aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre6aa1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
ksymoops: No such file or directory
kernel BUG at shmem.c:490!
invalid operand: 0000 2.4.22-pre6aa1 #1 SMP Thu Jul 17 20:24:29 MSD 2003
CPU:    0
EIP:    0010:[<801424cb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000508   ebx: 8d846a00   ecx: c7919800   edx: c79198fc
esi: c79198fc   edi: 8d846b40   ebp: 97b999a0   esp: af853e34
ds: 0018   es: 0018   ss: 0018
Process oracle (pid: 23274, stackpage=af853000)
Stack: 8d846a00 8d846a00 80142460 c7919800 80161abf 8d846a00 00000000 00000000
       97b999a0 8d846a00 8d846a00 8015e98e 8d846a00 97b999a0 97b999a0 97b999b8
       8015ea5a 97b999a0 803349e0 8d141860 c78f6fa0 80148acb 97b999a0 9eb9f774
Call Trace:    [<80142460>] [<80161abf>] [<8015e98e>] [<8015ea5a>] 
[<80148acb>]
  [<80132695>] [<8011c35a>] [<80121c66>] [<80128069>] [<80127f13>] 
[<80128115>]
  [<801073a8>] [<801236c4>] [<80123562>] [<80127546>] [<80115b50>] 
[<80117b80>]
  [<80107614>]
Code: 0f 0b ea 01 24 c1 27 80 eb cd 0f 0b e9 01 24 c1 27 80 eb bc


>>EIP; 801424cb <alloc_pages_node+75b/2c70>   <=====

Trace; 80142460 <alloc_pages_node+6f0/2c70>
Trace; 80161abf <iput+14f/2b0>
Trace; 8015e98e <lock_may_write+21e/260>
Trace; 8015ea5a <dput+8a/150>
Trace; 80148acb <fput+db/110>
Trace; 80132695 <do_brk+3d5/700>
Trace; 8011c35a <remove_wait_queue+4fa/d10>
Trace; 80121c66 <exit_mm+4f6/770>
Trace; 80128069 <unblock_all_signals+109/150>
Trace; 80127f13 <flush_signal_handlers+103/110>
Trace; 80128115 <dequeue_signal+65/4f0>
Trace; 801073a8 <__read_lock_failed+11a8/17c0>
Trace; 801236c4 <tasklet_kill+f4/120>
Trace; 80123562 <__tasklet_hi_schedule+162/1a0>
Trace; 80127546 <del_timer_sync+a16/ca0>
Trace; 80115b50 <smp_call_function+ce0/19f0>
Trace; 80117b80 <__verify_write+230/ab0>
Trace; 80107614 <__read_lock_failed+1414/17c0>

Code;  801424cb <alloc_pages_node+75b/2c70>
00000000 <_EIP>:
Code;  801424cb <alloc_pages_node+75b/2c70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  801424cd <alloc_pages_node+75d/2c70>
   2:   ea 01 24 c1 27 80 eb      ljmp   $0xeb80,$0x27c12401
Code;  801424d4 <alloc_pages_node+764/2c70>
   9:   cd 0f                     int    $0xf
Code;  801424d6 <alloc_pages_node+766/2c70>
   b:   0b e9                     or     %ecx,%ebp
Code;  801424d8 <alloc_pages_node+768/2c70>
   d:   01 24 c1                  add    %esp,(%ecx,%eax,8)
Code;  801424db <alloc_pages_node+76b/2c70>
  10:   27                        daa
Code;  801424dc <alloc_pages_node+76c/2c70>
  11:   80 eb bc                  sub    $0xbc,%bl


1 warning and 1 error issued.  Results may not be reliable.
-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
