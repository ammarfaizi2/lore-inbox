Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268361AbTBNLkd>; Fri, 14 Feb 2003 06:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268363AbTBNLkd>; Fri, 14 Feb 2003 06:40:33 -0500
Received: from mx7.mail.ru ([194.67.57.17]:23571 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S268361AbTBNLkb>;
	Fri, 14 Feb 2003 06:40:31 -0500
From: Alexander Vodomerov <shurvod@mail.ru>
Reply-To: shurvod@mail.ru
Organization: MSU
To: linux-kernel@vger.kernel.org
Subject: kswapd crashes with oops (2.4.20 on i686)
Date: Fri, 14 Feb 2003 14:48:30 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302141448.30896.shurvod@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello!

kswapd crashed 2 times during last two days. After that, system worked 
unstable. Can anybody understand this oops? Any suggestions?
I've 2.4.20 kernel with lm_sensors and i2c patches applied. No unusual 
hardware is used. I'm using RedHat 8.0.

Please, send me CC of your answers because I'm not subscribed to mailing 
list.

Feb 11 11:27:34 lorien kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000018
Feb 11 11:27:34 lorien kernel: c013d3d0
Feb 11 11:27:34 lorien kernel: *pde = 00000000
Feb 11 11:27:34 lorien kernel: Oops: 0000
Feb 11 11:27:34 lorien kernel: CPU:    0
Feb 11 11:27:34 lorien kernel: EIP:    0010:[<c013d3d0>]
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 11 11:27:34 lorien kernel: EFLAGS: 00010207
Feb 11 11:27:34 lorien kernel: eax: 00000000   ebx: 00000000   ecx: 000001d0   
edx: 00000000
Feb 11 11:27:34 lorien kernel: esi: c10e8c20   edi: c9d69740   ebp: c10e8c20   
esp: c15b9f28
Feb 11 11:27:34 lorien kernel: ds: 0018   es: 0018   ss: 0018
Feb 11 11:27:34 lorien kernel: Process kswapd (pid: 5, stackpage=c15b9000)
Feb 11 11:27:34 lorien kernel: Stack: 0000a3ce 00000000 c10e8c20 00001ecb 
c0338750 c0131585 c10e8c20 000001d0 
Feb 11 11:27:34 lorien kernel:        c15b8000 00000200 000001d0 0000001a 
0000001f 000001d0 00000020 00000006 
Feb 11 11:27:34 lorien kernel:        c0131783 00000006 c676c000 c0338750 
00000006 000001d0 c0338750 00000000 
Feb 11 11:27:34 lorien kernel: Call Trace:    [<c0131585>] [<c0131783>] 
[<c01317f6>] [<c013190c>] [<c0131988>]
Feb 11 11:27:34 lorien kernel:   [<c0131abd>] [<c0105000>] [<c010578e>] 
[<c0131a20>]
Feb 11 11:27:34 lorien kernel: Code: 8b 53 18 8b 43 10 83 e2 06 09 d0 0f 85 
89 00 00 00 8b 5b 28 

>>EIP; c013d3d0 <try_to_free_buffers+10/f0>   <=====

>>esi; c10e8c20 <_end+d148c8/22475d08>
>>edi; c9d69740 <_end+99953e8/22475d08>
>>ebp; c10e8c20 <_end+d148c8/22475d08>
>>esp; c15b9f28 <_end+11e5bd0/22475d08>

Trace; c0131585 <shrink_cache+265/310>
Trace; c0131783 <shrink_caches+63/a0>
Trace; c01317f6 <try_to_free_pages_zone+36/50>
Trace; c013190c <kswapd_balance_pgdat+5c/b0>
Trace; c0131988 <kswapd_balance+28/40>
Trace; c0131abd <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010578e <kernel_thread+2e/40>
Trace; c0131a20 <kswapd+0/c0>

Code;  c013d3d0 <try_to_free_buffers+10/f0>
00000000 <_EIP>:
Code;  c013d3d0 <try_to_free_buffers+10/f0>   <=====
   0:   8b 53 18                  mov    0x18(%ebx),%edx   <=====
Code;  c013d3d3 <try_to_free_buffers+13/f0>
   3:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c013d3d6 <try_to_free_buffers+16/f0>
   6:   83 e2 06                  and    $0x6,%edx
Code;  c013d3d9 <try_to_free_buffers+19/f0>
   9:   09 d0                     or     %edx,%eax
Code;  c013d3db <try_to_free_buffers+1b/f0>
   b:   0f 85 89 00 00 00         jne    9a <_EIP+0x9a>
Code;  c013d3e1 <try_to_free_buffers+21/f0>
  11:   8b 5b 28                  mov    0x28(%ebx),%ebx

And the second oops:

Feb 13 19:07:41 lorien kernel: Unable to handle kernel paging request at 
virtual address 0005dcf1
Feb 13 19:07:41 lorien kernel: c013d320
Feb 13 19:07:41 lorien kernel: *pde = 00000000
Feb 13 19:07:41 lorien kernel: Oops: 0000
Feb 13 19:07:41 lorien kernel: CPU:    0
Feb 13 19:07:41 lorien kernel: EIP:    0010:[<c013d320>]
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 13 19:07:41 lorien kernel: EFLAGS: 00010207
Feb 13 19:07:41 lorien kernel: eax: c15b8000   ebx: 0005dcd9   ecx: 00000040   
edx: 00000010
Feb 13 19:07:41 lorien kernel: esi: 00000001   edi: c9d05740   ebp: c11a04c8   
esp: c15b9f10
Feb 13 19:07:41 lorien kernel: ds: 0018   es: 0018   ss: 0018
Feb 13 19:07:41 lorien kernel: Process kswapd (pid: 5, stackpage=c15b9000)
Feb 13 19:07:41 lorien kernel: Stack: 00000003 d49adea0 c9c05740 c11a04c8 
c9d05740 c013d48d c9d05740 00000000 
Feb 13 19:07:41 lorien kernel:        c11a04c8 000044a3 c0338750 c0131585 
c11a04c8 000001d0 c15b8000 00000200 
Feb 13 19:07:41 lorien kernel:        000001d0 0000001e 0000001e 000001d0 
00000020 00000006 c0131783 00000006 
Feb 13 19:07:41 lorien kernel: Call Trace:    [<c013d48d>] [<c0131585>] 
[<c0131783>] [<c01317f6>] [<c013190c>]
Feb 13 19:07:41 lorien kernel:   [<c0131988>] [<c0131abd>] [<c0105000>] 
[<c010578e>] [<c0131a20>]
Feb 13 19:07:41 lorien kernel: Code: f7 43 18 06 00 00 00 74 37 b8 07 00 00 
00 0f ab 43 18 19 c0 

>>EIP; c013d320 <sync_page_buffers+20/c0>   <=====

>>eax; c15b8000 <_end+11e3ca8/22475d08>
>>ebx; 0005dcd9 Before first symbol
>>edi; c9d05740 <_end+99313e8/22475d08>
>>ebp; c11a04c8 <_end+dcc170/22475d08>
>>esp; c15b9f10 <_end+11e5bb8/22475d08>

Trace; c013d48d <try_to_free_buffers+cd/f0>
Trace; c0131585 <shrink_cache+265/310>
Trace; c0131783 <shrink_caches+63/a0>
Trace; c01317f6 <try_to_free_pages_zone+36/50>
Trace; c013190c <kswapd_balance_pgdat+5c/b0>
Trace; c0131988 <kswapd_balance+28/40>
Trace; c0131abd <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010578e <kernel_thread+2e/40>
Trace; c0131a20 <kswapd+0/c0>

Code;  c013d320 <sync_page_buffers+20/c0>
00000000 <_EIP>:
Code;  c013d320 <sync_page_buffers+20/c0>   <=====
   0:   f7 43 18 06 00 00 00      testl  $0x6,0x18(%ebx)   <=====
Code;  c013d327 <sync_page_buffers+27/c0>
   7:   74 37                     je     40 <_EIP+0x40>
Code;  c013d329 <sync_page_buffers+29/c0>
   9:   b8 07 00 00 00            mov    $0x7,%eax
Code;  c013d32e <sync_page_buffers+2e/c0>
   e:   0f ab 43 18               bts    %eax,0x18(%ebx)
Code;  c013d332 <sync_page_buffers+32/c0>
  12:   19 c0                     sbb    %eax,%eax

With best regards,
   Alexander Vodomerov.
