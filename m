Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbTAPIZy>; Thu, 16 Jan 2003 03:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbTAPIZy>; Thu, 16 Jan 2003 03:25:54 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48856 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265187AbTAPIZx>; Thu, 16 Jan 2003 03:25:53 -0500
Date: Thu, 16 Jan 2003 00:34:48 -0800
From: Anthony Lau <anthony@greyweasel.com>
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20: More INFO
In-reply-to: <20030110083714.GA702@kimagure>
To: linux-kernel@vger.kernel.org
Message-id: <20030116083448.GA619@kimagure>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030110083714.GA702@kimagure>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It took awhile for the next oops to appear. I modifed my boot
procedure by turning off swap with "swapoff -a" and allowed the
system to run. I waited until all of my 1.5GB of physical RAM was
allocated (cached or in use), and let the system to contiue to
run. The system ran stably for 2 days with normal use. I then
switch swap back on with "swapon -a".

I monitored VM usage with "vmstat" occasionally. VM paging was 0
in and 0 out up to about 2 hours before this latest oops.

Here is the oops log:


ksymoops 2.4.8 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19-hm (specified)

Jan 15 22:12:54 kimagure kernel: Unable to handle kernel paging request at virtual address 068677ae
Jan 15 22:12:54 kimagure kernel: c015dc02
Jan 15 22:12:54 kimagure kernel: *pde = 00000000
Jan 15 22:12:54 kimagure kernel: Oops: 0000
Jan 15 22:12:54 kimagure kernel: CPU:    0
Jan 15 22:12:54 kimagure kernel: EIP:    0010:[<c015dc02>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 15 22:12:54 kimagure kernel: EFLAGS: 00010217
Jan 15 22:12:54 kimagure kernel: eax: 00000000   ebx: 06867786   ecx: 000001d0   edx: 06867786
Jan 15 22:12:54 kimagure kernel: esi: db2e0c8c   edi: 00000000   ebp: 00000050   esp: c222df10
Jan 15 22:12:54 kimagure kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 22:12:54 kimagure kernel: Process kswapd (pid: 5, stackpage=c222d000)
Jan 15 22:12:54 kimagure kernel: Stack: c21fc900 000001d0 00000020 00000200 00000001 c015635a f767cc00 c21fc900 
Jan 15 22:12:54 kimagure kernel:        000001d0 c0135d68 c21fc900 000001d0 db2e0c8c c21fc900 c012d512 c21fc900 
Jan 15 22:12:54 kimagure kernel:        000001d0 00000020 000001d0 00000020 00000006 00000006 c222c000 0000c27d 
Jan 15 22:12:54 kimagure kernel: Call Trace:    [<c015635a>] [<c0135d68>] [<c012d512>] [<c012d750>] [<c012d7af>]
Jan 15 22:12:54 kimagure kernel:   [<c012d843>] [<c012d89e>] [<c012d9ad>] [<c0106ec8>]
Jan 15 22:12:54 kimagure kernel: Code: 8b 5b 28 f6 42 19 02 74 17 8d 44 24 10 50 52 e8 0a ff ff ff 


>>EIP; c015dc02 <journal_try_to_free_buffers+5a/98>   <=====

>>esi; db2e0c8c <_end+1aee4d68/3951b13c>
>>esp; c222df10 <_end+1e31fec/3951b13c>

Trace; c015635a <ext3_releasepage+22/28>
Trace; c0135d68 <try_to_release_page+30/48>
Trace; c012d512 <shrink_cache+1da/2ec>
Trace; c012d750 <shrink_caches+58/80>
Trace; c012d7af <try_to_free_pages+37/58>
Trace; c012d843 <kswapd_balance_pgdat+43/8c>
Trace; c012d89e <kswapd_balance+12/28>
Trace; c012d9ad <kswapd+99/bc>
Trace; c0106ec8 <kernel_thread+28/38>

Code;  c015dc02 <journal_try_to_free_buffers+5a/98>
00000000 <_EIP>:
Code;  c015dc02 <journal_try_to_free_buffers+5a/98>   <=====
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
Code;  c015dc05 <journal_try_to_free_buffers+5d/98>
   3:   f6 42 19 02               testb  $0x2,0x19(%edx)
Code;  c015dc09 <journal_try_to_free_buffers+61/98>
   7:   74 17                     je     20 <_EIP+0x20>
Code;  c015dc0b <journal_try_to_free_buffers+63/98>
   9:   8d 44 24 10               lea    0x10(%esp,1),%eax
Code;  c015dc0f <journal_try_to_free_buffers+67/98>
   d:   50                        push   %eax
Code;  c015dc10 <journal_try_to_free_buffers+68/98>
   e:   52                        push   %edx
Code;  c015dc11 <journal_try_to_free_buffers+69/98>
   f:   e8 0a ff ff ff            call   ffffff1e <_EIP+0xffffff1e>

Thanks in advance,

Anthony
