Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274905AbTHFHl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274906AbTHFHl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:41:58 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:20941 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S274905AbTHFHlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:41:52 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 6 Aug 2003 09:41:50 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030806094150.4d7b0610.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308051340010.2848-100000@logos.cnet>
References: <20030802142734.5df93471.skraw@ithnet.com>
	<Pine.LNX.4.44.0308051340010.2848-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 13:40:48 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> Stephan,
> 
> Is this _STOCK_ 2.4.22-pre10 (no vmware, no other modules) ? 

Hello Marcelo,

today I have a fresh -pre10 oops for you.

Everything seems to start with (there is no i/o error or the like, is it
possible that the fs got damaged during former crashes?):

sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478481)[dev:blocknr]:
bit already cleared
sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478445)[dev:blocknr]:
bit already cleared
sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478441)[dev:blocknr]:
bit already cleared
sd(8,17):vs-4080: reiserfs_free_block: free_block (0811:14478348)[dev:blocknr]:
bit already cleared

An then:

ksymoops 2.4.8 on i686 2.4.22-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre10/ (default)
     -m /boot/System.map-2.4.22-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000006
c0144b14
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0144b14>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f0f66540   ecx: f0f66540   edx: 00000006
esi: f0f66540   edi: f0f66540   ebp: c2ce0350   esp: c345df24
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c345d000)
Stack: c0147ddf f0f66540 00000000 c2ce0350 0001bcad c02eab68 c0139228 c2ce0350
       000001d0 00000200 000001d0 00000016 00000020 000001d0 00000020 00000006
       c01394b3 00000006 c345c000 c02eab68 000001d0 00000006 c02eab68 00000000 
Call Trace:    [<c0147ddf>] [<c0139228>] [<c01394b3>] [<c013952e>] [<c013963c>]
  [<c01396c8>] [<c01397f8>] [<c0139760>] [<c0105000>] [<c010592e>] [<c0139760>]
Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 e9 7a ff ff ff 8d 76 


>>EIP; c0144b14 <__remove_from_queues+14/30>   <=====

>>ebx; f0f66540 <_end+30bbb320/3852ee40>
>>ecx; f0f66540 <_end+30bbb320/3852ee40>
>>esi; f0f66540 <_end+30bbb320/3852ee40>
>>edi; f0f66540 <_end+30bbb320/3852ee40>
>>ebp; c2ce0350 <_end+2935130/3852ee40>
>>esp; c345df24 <_end+30b2d04/3852ee40>

Trace; c0147ddf <try_to_free_buffers+7f/170>
Trace; c0139228 <shrink_cache+298/3b0>
Trace; c01394b3 <shrink_caches+63/a0>
Trace; c013952e <try_to_free_pages_zone+3e/60>
Trace; c013963c <kswapd_balance_pgdat+4c/b0>
Trace; c01396c8 <kswapd_balance+28/40>
Trace; c01397f8 <kswapd+98/c0>
Trace; c0139760 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; c0139760 <kswapd+0/c0>

Code;  c0144b14 <__remove_from_queues+14/30>
00000000 <_EIP>:
Code;  c0144b14 <__remove_from_queues+14/30>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0144b16 <__remove_from_queues+16/30>
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  c0144b1d <__remove_from_queues+1d/30>
   9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)
Code;  c0144b21 <__remove_from_queues+21/30>
   d:   e9 7a ff ff ff            jmp    ffffff8c <_EIP+0xffffff8c>
Code;  c0144b26 <__remove_from_queues+26/30>
  12:   8d 76 00                  lea    0x0(%esi),%esi


1 warning issued.  Results may not be reliable.

Regards,
Stephan


