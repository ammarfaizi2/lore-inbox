Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313483AbSDQK2j>; Wed, 17 Apr 2002 06:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313489AbSDQK2i>; Wed, 17 Apr 2002 06:28:38 -0400
Received: from smtp.acn.pl ([212.76.33.36]:29526 "EHLO mail.astercity.net")
	by vger.kernel.org with ESMTP id <S313483AbSDQK2i>;
	Wed, 17 Apr 2002 06:28:38 -0400
Date: Wed, 17 Apr 2002 12:27:13 +0200
From: Artur Brodowski <bzd@astercity.net>
To: linux-kernel@vger.kernel.org
Subject: oops report (or at least a try to make one)
Message-Id: <20020417122713.404e0cdd.bzd@astercity.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.

lately i was getting a swapoff error during shutdown, i found out this is
actually kernel oops message. so i run it thru ksymoops, as said in docs. 
unfortunately, i have no idea what to do with the output, i'm no hacker.
first i thought the reason could be that i use nvidia driver, as it gives
a warning about tainted kernel, but i used it for a while before on the
same machine/same kernel version, and there were no problems. also, this
error indicates it's kswapd issue.
since it's my first attempt to create oops report, i might missed things 
that are needed for a good info. if so, please give me a chance, don't 
ignore this mail.

this is ksymoops output i got:

ksymoops 2.4.5 on i686 2.4.19-r1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-r1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0128062>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0100001d   ebx: c108f040   ecx: c0257afc   edx: c02579a0
esi: 00000000   edi: c0257b24   ebp: 000000c0   esp: c7f8ff64
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c7f8f000)
Stack: c108f040 c108f05c c0257b24 000000c0 c0131c76 c108f040 00000030 c0257b24         000000c0 c0130297 c108f040 00000030 c108f040 c0128893 c0126138 c108f040 
              00000030 c108f040 c108f05c c01271b3 00000c54 c0257afc 0000148e 0008e000 
              Call Trace: [<c0131c76>] [<c0130297>] [<c0128893>] [<c0126138>] [<c01271b3>] 
                          [<c0127a9a>] [<c01054ef>] [<c01054f8>]
                       Code: 0f 0b 89 d8 2b 05 ec 86 2a c0 69 c0 c5 4e ec c4 c1 f8 02 3b


>>EIP; c0128062 <__free_pages_ok+42/22c>   <=====

>>eax; 0100001d Before first symbol
>>ebx; c108f040 <_end+dc4864/8571824>
>>ecx; c0257afc <contig_page_data+dc/3c0>
>>edx; c02579a0 <swapper_space+0/40>
>>edi; c0257b24 <contig_page_data+104/3c0>
>>esp; c7f8ff64 <_end+7cc5788/8571824>

Trace; c0131c76 <try_to_free_buffers+8a/dc>
Trace; c0130297 <try_to_release_page+43/4c>
Trace; c0128893 <__free_pages+1b/1c>
Trace; c0126138 <drop_page+30/1a4>
Trace; c01271b3 <refill_inactive_zone+1df/290>
Trace; c0127a9a <kswapd+262/2a8>
Trace; c01054ef <kernel_thread+1f/38>
Trace; c01054f8 <kernel_thread+28/38>

Code;  c0128062 <__free_pages_ok+42/22c>
00000000 <_EIP>:
Code;  c0128062 <__free_pages_ok+42/22c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0128064 <__free_pages_ok+44/22c>
   2:   89 d8                     mov    %ebx,%eax
Code;  c0128066 <__free_pages_ok+46/22c>
   4:   2b 05 ec 86 2a c0         sub    0xc02a86ec,%eax
Code;  c012806c <__free_pages_ok+4c/22c>
   a:   69 c0 c5 4e ec c4         imul   $0xc4ec4ec5,%eax,%eax
Code;  c0128072 <__free_pages_ok+52/22c>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c0128075 <__free_pages_ok+55/22c>
  13:   3b 00                     cmp    (%eax),%eax

1 warning issued.  Results may not be reliable.

regards,
artb.
-- 
is it a womb, or is it a tomb? or is it something completely different?

