Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbUJXUqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUJXUqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUJXUqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:46:52 -0400
Received: from S010600a0c9f25a40.vn.shawcable.net ([24.87.160.169]:46976 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S261175AbUJXUqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:46:08 -0400
Date: Sun, 24 Oct 2004 13:46:04 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.9] pipe_wait (wine) Oops
Message-ID: <20041024204603.GA2735@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo,

During one of my 300-things-at-once sessions (burning a dvd, running
wine, playing mp3s, coding, ssh-copying-to-usb-drive,
nfs-copying-to-local-fs, web browsing, etc.), the box suddenly froze. 
This has happened a few times now, so I decided to actually check the
serial console.

Kernel is tainted with ATI's fglrx driver.  Sorry.  I'll try to break it
again without it if it may be related.  This is an Athlon 64 running in
32 bit mode with 512 MB of memory.

Config snippet:

# CONFIG_SMP is not set  
# CONFIG_PREEMPT is not set
CONFIG_NOHIGHMEM=y

Whole .config: http://0x.ca/sim/ref/oops/2004-10-24/0/2.6.9.config
Whole serial log: http://0x.ca/sim/ref/oops/2004-10-24/0/log
dmesg (next boot): http://0x.ca/sim/ref/oops/2004-10-24/0/dmesg
System.map: http://0x.ca/sim/ref/oops/2004-10-24/0/System.map
kallsyms: http://0x.ca/sim/ref/oops/2004-10-24/0/kallsyms
vmlinux: http://0x.ca/sim/ref/oops/2004-10-24/0/vmlinux

There were a number of Oopses, stopping finally with:

Recursive die() failure, output suppressed
 <0>Kernel panic - not syncing: Fatal exception in interrupt

...The first being:

ksymoops 2.4.9 on i686 2.6.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9/ (default)
     -m /proc/kallsyms (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000068
c015e38a
*pde = 0c342067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c015e38a>]    Tainted: P   VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.9) 
eax: dfc42560   ebx: d2a5bcd0   ecx: d2a5bcd0   edx: d224beec
esi: 00000000   edi: d224beec   ebp: 00000000   esp: d224becc
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 dfc42560 c011cbb0 d224bef8 d224bef8 00000040 c9caa034 c016b102 
       00000000 dfc42560 c011cbb0 d224bef8 d224bef8 417bff42 1fa50bd0 c9caa034 
       d2a5bc68 d7ccb8c0 00000000 c015e52e d2a5bc68 0000001d 00020002 00000040 
Call Trace:
 [<c011cbb0>] autoremove_wake_function+0x0/0x60
 [<c016b102>] update_atime+0x92/0xe0
 [<c011cbb0>] autoremove_wake_function+0x0/0x60
 [<c015e52e>] pipe_readv+0x18e/0x2a0
 [<c015e677>] pipe_read+0x37/0x40
 [<c0153008>] vfs_read+0xb8/0x130
 [<c01532f1>] sys_read+0x51/0x80
 [<c0105fe9>] sysenter_past_esp+0x52/0x71
Code: 86 e8 00 00 00 89 fa e8 45 e7 fb ff 89 d9 ff 46 68 0f 8e f7 0e 00 00 e8 c5 4a 2a 00 8b 86 e8 00 00 00 89 fa e8 d8 e7 fb ff 89 d9 <ff> 4e 68 0f 88 e4 0e 00 00 83 c4 40 5b 5e 5f c3 8d b6 00 00 00 


>>EIP; c015e38a <pipe_wait+8a/a0>   <=====

>>eax; dfc42560 <[tg3]per_cpu__softnet_data+1f6d6d80/203d4820>
>>ebx; d2a5bcd0 <[tg3]per_cpu__softnet_data+124f04f0/203d4820>
>>ecx; d2a5bcd0 <[tg3]per_cpu__softnet_data+124f04f0/203d4820>
>>edx; d224beec <[tg3]per_cpu__softnet_data+11ce070c/203d4820>
>>edi; d224beec <[tg3]per_cpu__softnet_data+11ce070c/203d4820>
>>esp; d224becc <[tg3]per_cpu__softnet_data+11ce06ec/203d4820>

Trace; c011cbb0 <autoremove_wake_function+0/60>
Trace; c016b102 <update_atime+92/e0>
Trace; c011cbb0 <autoremove_wake_function+0/60>
Trace; c015e52e <pipe_readv+18e/2a0>
Trace; c015e677 <pipe_read+37/40>
Trace; c0153008 <vfs_read+b8/130>
Trace; c01532f1 <sys_read+51/80>
Trace; c0105fe9 <sysenter_past_esp+52/71>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c015e35f <pipe_wait+5f/a0>
00000000 <_EIP>:
Code;  c015e35f <pipe_wait+5f/a0>
   0:   86 e8                     xchg   %ch,%al
Code;  c015e361 <pipe_wait+61/a0>
   2:   00 00                     add    %al,(%eax)
Code;  c015e363 <pipe_wait+63/a0>
   4:   00 89 fa e8 45 e7         add    %cl,0xe745e8fa(%ecx)
Code;  c015e369 <pipe_wait+69/a0>
   a:   fb                        sti    
Code;  c015e36a <pipe_wait+6a/a0>
   b:   ff 89 d9 ff 46 68         decl   0x6846ffd9(%ecx)
Code;  c015e370 <pipe_wait+70/a0>
  11:   0f 8e f7 0e 00 00         jle    f0e <_EIP+0xf0e>
Code;  c015e376 <pipe_wait+76/a0>
  17:   e8 c5 4a 2a 00            call   2a4ae1 <_EIP+0x2a4ae1>
Code;  c015e37b <pipe_wait+7b/a0>
  1c:   8b 86 e8 00 00 00         mov    0xe8(%esi),%eax
Code;  c015e381 <pipe_wait+81/a0>
  22:   89 fa                     mov    %edi,%edx
Code;  c015e383 <pipe_wait+83/a0>
  24:   e8 d8 e7 fb ff            call   fffbe801 <_EIP+0xfffbe801>
Code;  c015e388 <pipe_wait+88/a0>
  29:   89 d9                     mov    %ebx,%ecx

This decode from eip onwards should be reliable

Code;  c015e38a <pipe_wait+8a/a0>
00000000 <_EIP>:
Code;  c015e38a <pipe_wait+8a/a0>   <=====
   0:   ff 4e 68                  decl   0x68(%esi)   <=====
Code;  c015e38d <pipe_wait+8d/a0>
   3:   0f 88 e4 0e 00 00         js     eed <_EIP+0xeed>
Code;  c015e393 <pipe_wait+93/a0>
   9:   83 c4 40                  add    $0x40,%esp
Code;  c015e396 <pipe_wait+96/a0>
   c:   5b                        pop    %ebx
Code;  c015e397 <pipe_wait+97/a0>
   d:   5e                        pop    %esi
Code;  c015e398 <pipe_wait+98/a0>
   e:   5f                        pop    %edi
Code;  c015e399 <pipe_wait+99/a0>
   f:   c3                        ret    
Code;  c015e39a <pipe_wait+9a/a0>
  10:   8d                        .byte 0x8d
Code;  c015e39b <pipe_wait+9b/a0>
  11:   b6 00                     mov    $0x0,%dh


1 error issued.  Results may not be reliable.

Hey, DVD burning can be resumed with growisofs on the next boot.
Neat. :)

Additional information available upon request.

Simon-
