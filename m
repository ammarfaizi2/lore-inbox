Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbTFWMtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 08:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbTFWMtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 08:49:18 -0400
Received: from rzcomm7.rz.tu-bs.de ([134.169.9.53]:3015 "EHLO
	rzcomm7.rz.tu-bs.de") by vger.kernel.org with ESMTP id S266009AbTFWMtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:49:08 -0400
Date: Mon, 23 Jun 2003 12:16:48 +0200
From: Torsten Wolf <t.wolf@tu-bs.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd 2.4.2? ext3
Message-ID: <20030623101648.GA1736@b147.apm.etc.tu-bs.de>
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
X-Mailer: Mutt http://www.mutt.org/
Organization: TU Braunschweig
X-Editor: Vim http://www.vim.org/
X-OpenPGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xEE27B69C
X-Fingerprint: 24EE 9FD9 5333 0206 541F  4602 C6A4 5F61 EE27 B69C
X-Uptime: 12:01:37 up 1 min,  4 users,  load average: 0.62, 0.28, 0.10
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Son, 22 Jun 2003, John Duthie wrote:

>I don't think kswap should be doing this ....

The same here; I posted this a few weeks ago but as I was advised to
reproduce the error without the modules (that I need) loaded at that
time, the issue wasn't further investigated.

I also have 2.4.20 with several ext3 filesystems in use. Occasionally
(and only since 2.4.20) I get the error attached below. Perhaps Andrew's
suggestion (flaky hardware) aims in the right direction as I seldom
encounter problems with bzip2; however, memtest never found an error on
this machine.


Jun 21 09:07:16 b147 kernel: kernel BUG at page_alloc.c:102!
Jun 21 09:07:16 b147 kernel: invalid operand: 0000
Jun 21 09:07:16 b147 kernel: CPU:    0
Jun 21 09:07:16 b147 kernel: EIP:    0010:[<c0133bc3>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 21 09:07:16 b147 kernel: EFLAGS: 00010286
Jun 21 09:07:16 b147 kernel: eax: c13d854c   ebx: c1959240   ecx:
00000000   edx: f7ecdd24
Jun 21 09:07:16 b147 kernel: esi: c1959240   edi: 00000000   ebp:
c02c7f00   esp: f7ef5f0c
Jun 21 09:07:16 b147 kernel: ds: 0018   es: 0018   ss: 0018
Jun 21 09:07:16 b147 kernel: Process kswapd (pid: 4, stackpage=f7ef5000)
Jun 21 09:07:16 b147 kernel: Stack: 00000282 00000003 f1e4d240 f1e4d240
f1e4d240 c1959240 c013f312 f1e4d240 
Jun 21 09:07:16 b147 kernel: f7ecdd24 c1959240 00005a10 c02c7f00
c0133009 c1959240 000001d0 f7ef4000 
Jun 21 09:07:16 b147 kernel: 00000200 000001d0 0000001e 00000020
000001d0 00000020 00000006 c01331e1 
Jun 21 09:07:16 b147 kernel: Call Trace:    [<c013f312>] [<c0133009>]
[<c01331e1>] [<c0133256>] [<c0133384>]
Jun 21 09:07:16 b147 kernel: [<c01333e9>] [<c013351d>] [<c0105000>]
[<c01072be>] [<c0133480>]
Jun 21 09:07:16 b147 kernel: Code: 0f 0b 66 00 db cc 28 c0 89 d8 2b 05
50 51 34 c0 c1 f8 04 69


>>EIP; c0133bc3 <__free_pages_ok+43/290>   <=====

>>eax; c13d854c <_end+106ad74/385858a8>
>>ebx; c1959240 <_end+15eba68/385858a8>
>>edx; f7ecdd24 <_end+37b6054c/385858a8>
>>esi; c1959240 <_end+15eba68/385858a8>
>>ebp; c02c7f00 <contig_page_data+160/340>
>>esp; f7ef5f0c <_end+37b88734/385858a8>

Trace; c013f312 <try_to_free_buffers+82/100>
Trace; c0133009 <shrink_cache+279/300>
Trace; c01331e1 <shrink_caches+61/a0>
Trace; c0133256 <try_to_free_pages_zone+36/60>
Trace; c0133384 <kswapd_balance_pgdat+54/a0>
Trace; c01333e9 <kswapd_balance+19/30>
Trace; c013351d <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01072be <arch_kernel_thread+2e/40>
Trace; c0133480 <kswapd+0/c0>

Code;  c0133bc3 <__free_pages_ok+43/290>
00000000 <_EIP>:
Code;  c0133bc3 <__free_pages_ok+43/290>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0133bc5 <__free_pages_ok+45/290>
   2:   66                        data16
Code;  c0133bc6 <__free_pages_ok+46/290>
   3:   00 db                     add    %bl,%bl
Code;  c0133bc8 <__free_pages_ok+48/290>
   5:   cc                        int3   
Code;  c0133bc9 <__free_pages_ok+49/290>
   6:   28 c0                     sub    %al,%al
Code;  c0133bcb <__free_pages_ok+4b/290>
   8:   89 d8                     mov    %ebx,%eax
Code;  c0133bcd <__free_pages_ok+4d/290>
   a:   2b 05 50 51 34 c0         sub    0xc0345150,%eax
Code;  c0133bd3 <__free_pages_ok+53/290>
  10:   c1 f8 04                  sar    $0x4,%eax
Code;  c0133bd6 <__free_pages_ok+56/290>
    13:   69 00 00 00 00 00         imul $0x0,(%eax),%eax

Best wishes,
Torsten
