Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTHTOWI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTHTOWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:22:08 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29645 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261969AbTHTOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:22:02 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 20 Aug 2003 16:21:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, green@namesys.com, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (yet another oops for rc2)
Message-Id: <20030820162145.0dc9910d.skraw@ithnet.com>
In-Reply-To: <1060952100.5046.2.camel@tiny.suse.com>
References: <20030814084518.GA5454@namesys.com>
	<Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
	<20030814194226.2346dc14.skraw@ithnet.com>
	<1060913337.1493.29.camel@tiny.suse.com>
	<20030815122827.067bd429.skraw@ithnet.com>
	<1060952100.5046.2.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

todays' oops is:

ksymoops 2.4.8 on i686 2.4.22-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc2/ (default)
     -m /boot/System.map-2.4.22-rc2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at slab.c:1225!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0137ebd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000005   ebx: 00000005   ecx: 00000088   edx: 00000000
esi: f6df2000   edi: f6df20a0   ebp: f6df2348   esp: c345df04
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c345d000)
Stack: f6df234c f6df2348 f6df23cc f6df2000 c0139107 c342b4d0 f6df2000 f6df2348
       c342b4d0 0000007d c346040c c3460400 c01384e2 c342b4d0 f6df234c 00000000 
       00000001 00000000 00000000 00000000 00000020 000001d0 00000020 00000006
Call Trace:    [<c0139107>] [<c01384e2>] [<c0139c78>] [<c0139d2e>] [<c0139e3c>]
  [<c0139ec8>] [<c0139ff8>] [<c0139f60>] [<c0105000>] [<c010592e>] [<c0139f60>]
Code: 0f 0b c9 04 44 92 2c c0 8b 44 86 18 83 f8 ff 75 eb 89 f6 8b


>>EIP; c0137ebd <kmem_extra_free_checks+6d/a0>   <=====

>>esi; f6df2000 <_end+36a2a9a0/38462a00>
>>edi; f6df20a0 <_end+36a2aa40/38462a00>
>>ebp; f6df2348 <_end+36a2ace8/38462a00>
>>esp; c345df04 <_end+30968a4/38462a00>

Trace; c0139107 <kmem_cache_free_one+f7/220>
Trace; c01384e2 <kmem_cache_reap+b2/290>
Trace; c0139c78 <shrink_caches+28/a0>
Trace; c0139d2e <try_to_free_pages_zone+3e/60>
Trace; c0139e3c <kswapd_balance_pgdat+4c/b0>
Trace; c0139ec8 <kswapd_balance+28/40>
Trace; c0139ff8 <kswapd+98/c0>
Trace; c0139f60 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; c0139f60 <kswapd+0/c0>

Code;  c0137ebd <kmem_extra_free_checks+6d/a0>
00000000 <_EIP>:
Code;  c0137ebd <kmem_extra_free_checks+6d/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0137ebf <kmem_extra_free_checks+6f/a0>
   2:   c9                        leave  
Code;  c0137ec0 <kmem_extra_free_checks+70/a0>
   3:   04 44                     add    $0x44,%al
Code;  c0137ec2 <kmem_extra_free_checks+72/a0>
   5:   92                        xchg   %eax,%edx
Code;  c0137ec3 <kmem_extra_free_checks+73/a0>
   6:   2c c0                     sub    $0xc0,%al
Code;  c0137ec5 <kmem_extra_free_checks+75/a0>
   8:   8b 44 86 18               mov    0x18(%esi,%eax,4),%eax
Code;  c0137ec9 <kmem_extra_free_checks+79/a0>
   c:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0137ecc <kmem_extra_free_checks+7c/a0>
   f:   75 eb                     jne    fffffffc <_EIP+0xfffffffc>
Code;  c0137ece <kmem_extra_free_checks+7e/a0>
  11:   89 f6                     mov    %esi,%esi
Code;  c0137ed0 <kmem_extra_free_checks+80/a0>
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.


This is still with ext3 and about 24 hours uptime (rough guess).

Regards,
Stephan

