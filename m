Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSKOBTc>; Thu, 14 Nov 2002 20:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSKOBTc>; Thu, 14 Nov 2002 20:19:32 -0500
Received: from ifup.net ([217.160.130.191]:43675 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S265426AbSKOBTZ>;
	Thu, 14 Nov 2002 20:19:25 -0500
Date: Fri, 15 Nov 2002 02:26:32 +0100
From: "Karsten 'soohrt' Desler" <linux-kernel@ml.soohrt.org>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.20-rc1-ac1 kernel BUG at page_alloc.c:127!
Message-ID: <20021115012632.GA20234@sit0.ifup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hit this kernel BUG while playing a little with mrtg on a vanilla
2.4.20-rc1-ac1.

ksymoops 2.4.6 on i686 2.4.20-rc1-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc1-ac1/ (default)
     -m /boot/System.map (specified)

Nov 15 01:45:03 pikelot kernel: kernel BUG at page_alloc.c:127!
Nov 15 01:45:03 pikelot kernel: invalid operand: 0000
Nov 15 01:45:03 pikelot kernel: CPU:    0
Nov 15 01:45:03 pikelot kernel: EIP:    0010:[__free_pages_ok+217/912]     Not tainted
Nov 15 01:45:03 pikelot kernel: EFLAGS: 00010286
Nov 15 01:45:03 pikelot kernel: eax: 01000010   ebx: c127a9a8   ecx: c127a9c4   edx: c127a990
Nov 15 01:45:03 pikelot kernel: esi: 00000000   edi: 086f6000   ebp: 00100000   esp: cd38bee0
Nov 15 01:45:03 pikelot kernel: ds: 0018   es: 0018   ss: 0018
Nov 15 01:45:03 pikelot kernel: Process mrtg (pid: 2357, stackpage=cd38b000)
Nov 15 01:45:03 pikelot kernel: Stack: c127a9a8 00080000 086f6000 00100000 0001eff0 c100000c c127a9dc c103400c
Nov 15 01:45:03 pikelot kernel:        c0220b98 00000212 c127a9a8 c0220b00 c01313fe c012e163 c012e603 c127a9a8
Nov 15 01:45:03 pikelot kernel:        c0121b70 c127a9a8 cbf22dd8 c0121fdd 0c343067 d94b4940 db4cf680 0045d000
Nov 15 01:45:03 pikelot kernel: Call Trace: [page_remove_rmap+126/160] [__free_pages+19/32] [free_page_and_swap_cache+51/64] [__free_pte+64/80] [zap_page_range+429/624]
Nov 15 01:45:03 pikelot kernel: Code: 0f 0b 7f 00 43 6e 1f c0 8b 43 18 24 eb 89 43 18 c6 43 24 05


>>ebx; c127a9a8 <_end+fdca90/2056f148>
>>ecx; c127a9c4 <_end+fdcaac/2056f148>
>>edx; c127a990 <_end+fdca78/2056f148>
>>esp; cd38bee0 <_end+d0edfc8/2056f148>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   7f 00                     jg     4 <_EIP+0x4> 00000004 Before first symbol
Code;  00000004 Before first symbol
   4:   43                        inc    %ebx
Code;  00000005 Before first symbol
   5:   6e                        outsb  %ds:(%esi),(%dx)
Code;  00000006 Before first symbol
   6:   1f                        pop    %ds
Code;  00000007 Before first symbol
   7:   c0 8b 43 18 24 eb 89      rorb   $0x89,0xeb241843(%ebx)
Code;  0000000e Before first symbol
   e:   43                        inc    %ebx
Code;  0000000f Before first symbol
   f:   18 c6                     sbb    %al,%dh
Code;  00000011 Before first symbol
  11:   43                        inc    %ebx
Code;  00000012 Before first symbol
  12:   24 05                     and    $0x5,%al


  Karsten
