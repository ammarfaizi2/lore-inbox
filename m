Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJMBjz>; Sat, 12 Oct 2002 21:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSJMBjz>; Sat, 12 Oct 2002 21:39:55 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:46579 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261397AbSJMBjx> convert rfc822-to-8bit; Sat, 12 Oct 2002 21:39:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre10aa1 oops report (was Re: Linux-2.4.20-pre8-aa2 oops report. [solved])
Date: Sun, 13 Oct 2002 11:53:29 +1000
User-Agent: KMail/1.4.3
Cc: Andrea Arcangeli <andrea@suse.de>
References: <200210051247.14368.harisri@bigpond.com> <20021010012626.GW2958@dualathlon.random> <200210102017.04048.harisri@bigpond.com>
In-Reply-To: <200210102017.04048.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210131153.30036.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thursday 10 October 2002 20:17, Srihari Vijayaraghavan wrote:
> Thanks. Unfortunately that did not fix the problem.
>
> I was able to reproduce 4 more oops. (all happened one after other)
>
> ksymoops 2.4.5 on i686 2.4.20-pre8aa2-p1.  Options used

Here is a similar oops report from 2.4.20-pre10aa1.

ksymoops 2.4.5 on i686 2.4.20-pre10aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre10aa1/ (default)
     -m /boot/System.map-2.4.20-pre10aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 11 22:43:19 localhost kernel: Unable to handle kernel paging request at 
virtual address cbe8e000
Oct 11 22:43:19 localhost kernel: c01e55e2
Oct 11 22:43:19 localhost kernel: *pde = 0bc001e3
Oct 11 22:43:19 localhost kernel: Oops: 0002 2.4.20-pre10aa1 #3 Fri Oct 11 
22:10:08 EST 2002
Oct 11 22:43:19 localhost kernel: CPU:    0
Oct 11 22:43:19 localhost kernel: EIP:    0010:[<c01e55e2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 11 22:43:19 localhost kernel: EFLAGS: 00013246
Oct 11 22:43:19 localhost kernel: eax: 0000003f   ebx: cbe8e000   ecx: 
c9f8e000   edx: 00000000
Oct 11 22:43:19 localhost kernel: esi: c3f7d4b0   edi: 000004b0   ebp: 
c120c084   esp: c9f8feac
Oct 11 22:43:19 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 11 22:43:19 localhost kernel: Process modprobe (pid: 1675, 
stackpage=c9f8f000)
Oct 11 22:43:19 localhost kernel: Stack: 00104025 c0126952 cbe8e000 c95bc420 
4212c1fc dff87e00 cbc1a140 c0126d7e 
Oct 11 22:43:19 localhost kernel:        dff87e00 cbc1a140 c3f7d4b0 c95bc420 
00000001 4212c1fc c9f8ff24 dff87e00 
Oct 11 22:43:19 localhost kernel:        cbc1a140 4212c1fc c9f8e000 c011240a 
dff87e00 cbc1a140 4212c1fc 00000001 
Oct 11 22:43:19 localhost kernel: Call Trace:    [<c0126952>] [<c0126d7e>] 
[<c011240a>] [<c012869f>] [<c01289d2>]
Oct 11 22:43:19 localhost kernel:   [<c0128a54>] [<c0112260>] [<c01075b0>]
Oct 11 22:43:19 localhost kernel: Code: 0f e7 03 0f e7 43 08 0f e7 43 10 0f e7 
43 18 0f e7 43 20 0f 


>>EIP; c01e55e2 <fast_clear_page+12/50>   <=====

>>ebx; cbe8e000 <[sr_mod].bss.end+54ea1a9/1925c229>
>>ecx; c9f8e000 <[sr_mod].bss.end+35ea1a9/1925c229>
>>esi; c3f7d4b0 <[agpgart].bss.end+200695/1b93265>
>>edi; 000004b0 Before first symbol
>>ebp; c120c084 <_end+f86b14/166cb10>
>>esp; c9f8feac <[sr_mod].bss.end+35ec055/1925c229>

Trace; c0126952 <do_anonymous_page+a2/110>
Trace; c0126d7e <handle_mm_fault+8e/160>
Trace; c011240a <do_page_fault+1aa/5a0>
Trace; c012869f <unmap_fixup+12f/140>
Trace; c01289d2 <do_munmap+292/2d0>
Trace; c0128a54 <sys_munmap+44/80>
Trace; c0112260 <do_page_fault+0/5a0>
Trace; c01075b0 <error_code+34/3c>

Code;  c01e55e2 <fast_clear_page+12/50>
00000000 <_EIP>:
Code;  c01e55e2 <fast_clear_page+12/50>   <=====
   0:   0f e7 03                  movntq %mm0,(%ebx)   <=====
Code;  c01e55e5 <fast_clear_page+15/50>
   3:   0f e7 43 08               movntq %mm0,0x8(%ebx)
Code;  c01e55e9 <fast_clear_page+19/50>
   7:   0f e7 43 10               movntq %mm0,0x10(%ebx)
Code;  c01e55ed <fast_clear_page+1d/50>
   b:   0f e7 43 18               movntq %mm0,0x18(%ebx)
Code;  c01e55f1 <fast_clear_page+21/50>
   f:   0f e7 43 20               movntq %mm0,0x20(%ebx)
Code;  c01e55f5 <fast_clear_page+25/50>
  13:   0f 00 00                  sldtl  (%eax)


1 warning issued.  Results may not be reliable.

The mainline (2.4.20-pre10) does not exhibit this issue. Unlike 
2.4.20-pre8aa1, 2.4.20-pre10aa1 rebooted itself after the above oops.

I am hoping some of these oops might reveal the real issue/reason/bug to 
kernel developers one of these days.

And my sincere thanks for your help.
-- 
Hari
harisri@bigpond.com

