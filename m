Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTHGPyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHGPx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:53:27 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:51923 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S270322AbTHGPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:52:16 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 7 Aug 2003 17:52:13 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030807175213.63a56f9b.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308070942540.6582-100000@logos.cnet>
References: <20030807041440.12341286.skraw@ithnet.com>
	<Pine.LNX.4.44.0308070942540.6582-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 09:45:36 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> The decoded oops should be sufficient. 

Well, how about this one:


ksymoops 2.4.8 on i686 2.4.22-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc1/ (default)
     -m /boot/System.map-2.4.22-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 63eabdb3
c0145f31 
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0145f31>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000000   ecx: 00000061   edx: 63eabd93
esi: 00000000   edi: 00001000   ebp: 00000000   esp: c34f7e60
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=c34f7000)
Stack: 00000000 f7afb1f0 c0146018 00000000 c01312e9 00000000 c1849dd0 00001000
       00001000 00000803 c014823a c1849dd0 00001000 00000000 f79b7fa4 00001e18
       c0148428 f79b7fa4 00001e18 00001000 e9640000 00000000 00000803 00001000
Call Trace:    [<c0146018>] [<c01312e9>] [<c014823a>] [<c0148428>] [<c0145b36>]
  [<c0197328>] [<c019ceb9>] [<c019c4f5>] [<c0188e94>] [<c01498cb>] [<c014887c>]
  [<c0148be9>] [<c0105000>] [<c010592e>] [<c0148af0>]
Code: 8b 42 20 a3 30 c6 37 c0 8d 41 ff a3 34 c6 37 c0 c6 05 c0 bb


>>EIP; c0145f31 <get_unused_buffer_head+21/b0>   <=====

>>esp; c34f7e60 <_end+314cc40/3852ee40>

Trace; c0146018 <create_buffers+28/100>
Trace; c01312e9 <find_or_create_page+109/110>
Trace; c014823a <grow_dev_page+7a/c0>
Trace; c0148428 <grow_buffers+98/110>
Trace; c0145b36 <getblk+46/80>
Trace; c0197328 <journal_getblk+28/30>
Trace; c019ceb9 <do_journal_end+139/bb0>
Trace; c019c4f5 <flush_old_commits+135/1d0>
Trace; c0188e94 <reiserfs_write_super+64/90>
Trace; c01498cb <sync_supers+14b/170>
Trace; c014887c <sync_old_buffers+3c/b0>
Trace; c0148be9 <kupdate+f9/130>
Trace; c0105000 <_stext+0/0>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; c0148af0 <kupdate+0/130>

Code;  c0145f31 <get_unused_buffer_head+21/b0>
00000000 <_EIP>:
Code;  c0145f31 <get_unused_buffer_head+21/b0>   <=====
   0:   8b 42 20                  mov    0x20(%edx),%eax   <=====
Code;  c0145f34 <get_unused_buffer_head+24/b0>
   3:   a3 30 c6 37 c0            mov    %eax,0xc037c630
Code;  c0145f39 <get_unused_buffer_head+29/b0>
   8:   8d 41 ff                  lea    0xffffffff(%ecx),%eax
Code;  c0145f3c <get_unused_buffer_head+2c/b0>
   b:   a3 34 c6 37 c0            mov    %eax,0xc037c634
Code;  c0145f41 <get_unused_buffer_head+31/b0>
  10:   c6 05 c0 bb 00 00 00      movb   $0x0,0xbbc0


1 warning issued.  Results may not be reliable.


After that I received this one:


ksymoops 2.4.8 on i686 2.4.22-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc1/ (default)
     -m /boot/System.map-2.4.22-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

 NMI Watchdog detected LOCKUP on CPU1, eip c011a747, registers:
CPU:    1
EIP:    0010:[<c011a747>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000082
eax: cef0b8dc   ebx: cef0b894   ecx: 00000001   edx: 00000003  
esi: 00000008   edi: cef0b8dc   ebp: ec8efe48   esp: ec8efe28
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 13603, stackpage=ec8ef000)
Stack: 00000000 cef0b894 00000000 00000282 00000003 cef0b894 00000008 cef0b8dc
       00000000 c01c4f41 00000000 cef0b894 00000000 0001679d cef0b894 00001000 
       c0146c87 00000000 cef0b894 cef0b894 00000004 cef0b894 ec8ee000 00000001
Call Trace:    [<c01c4f41>] [<c0146c87>] [<c013ae92>] [<c0119630>] [<c0130d7e>]
  [<c017ff50>] [<c013146f>] [<c0131751>] [<c0131d50>] [<c0131ffc>] [<c0131d50>]
  [<c014328b>] [<c010782f>]
Code: 7e f9 e9 d9 ec ff ff 80 38 00 f3 90 7e f9 e9 5d ed ff ff 80 


>>EIP; c011a747 <.text.lock.sched+3f/178>   <=====

>>eax; cef0b8dc <_end+eb606bc/3852ee40>
>>ebx; cef0b894 <_end+eb60674/3852ee40>
>>edi; cef0b8dc <_end+eb606bc/3852ee40>
>>ebp; ec8efe48 <_end+2c544c28/3852ee40>
>>esp; ec8efe28 <_end+2c544c08/3852ee40>

Trace; c01c4f41 <submit_bh+a1/c0>
Trace; c0146c87 <block_read_full_page+2d7/2f0>
Trace; c013ae92 <__alloc_pages+42/190>
Trace; c0119630 <wait_for_completion+70/b0>
Trace; c0130d7e <page_cache_read+be/e0>
Trace; c017ff50 <reiserfs_get_block+0/1490>
Trace; c013146f <generic_file_readahead+af/1a0>
Trace; c0131751 <do_generic_file_read+1c1/470>
Trace; c0131d50 <file_read_actor+0/110>
Trace; c0131ffc <generic_file_read+19c/1b0>
Trace; c0131d50 <file_read_actor+0/110>
Trace; c014328b <sys_read+9b/180>
Trace; c010782f <system_call+33/38>

Code;  c011a747 <.text.lock.sched+3f/178>
00000000 <_EIP>:
Code;  c011a747 <.text.lock.sched+3f/178>   <=====
   0:   7e f9                     jle    fffffffb <_EIP+0xfffffffb>   <=====
Code;  c011a749 <.text.lock.sched+41/178>
   2:   e9 d9 ec ff ff            jmp    ffffece0 <_EIP+0xffffece0>
Code;  c011a74e <.text.lock.sched+46/178>
   7:   80 38 00                  cmpb   $0x0,(%eax)
Code;  c011a751 <.text.lock.sched+49/178>
   a:   f3 90                     repz nop 
Code;  c011a753 <.text.lock.sched+4b/178>
   c:   7e f9                     jle    7 <_EIP+0x7>
Code;  c011a755 <.text.lock.sched+4d/178>
   e:   e9 5d ed ff ff            jmp    ffffed70 <_EIP+0xffffed70>
Code;  c011a75a <.text.lock.sched+52/178>
  13:   80 00 00                  addb   $0x0,(%eax)


1 warning issued.  Results may not be reliable.


There were no I/O errors or any other spectacular things happening. It just
died while I was sitting right next to it during the verify run of tar.

Regards,
Stephan
