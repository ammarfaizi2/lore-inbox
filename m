Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUDWLcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUDWLcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUDWLcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 07:32:54 -0400
Received: from nacho.alt.net ([207.14.113.18]:6590 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S264782AbUDWLcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 07:32:50 -0400
Date: Fri, 23 Apr 2004 04:32:48 -0700 (PDT)
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.25 prune_icache() called from kswapd
Message-ID: <Pine.LNX.4.44.0404230428490.15913-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Chris Caputo <ccaputo@alt.net>
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen the following twice with 2.4.25.  (13 days apart, fairly busy
file server)

Am now running 2.4.26 and will report if it happens again with that.

Chris

---

ksymoops 2.4.9 on i686 2.4.26custom.  Options used
     -v /usr/src/linux-2.4.25/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25custom (specified)
     -m System.map-2.4.25custom (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0000
CPU:    0
EIP:    0010:[<c015b465>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a97
eax: 830418da   ebx: 5954e741   ecx: c40fdf18   edx: c0318f08
esi: 5954e739   edi: 5954e741   ebp: 000001b4   esp: c40fdf10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=c40fd000)
Stack: f718b780 000013a1 f718b788 d04d3988 00000001 c3cfe850 c0317fd8 00023d9e
       c015b664 00001555 c0138f35 00000006 000001d0 ffffffff 000001d0 00000001
              00000004 000001d0 c0317fd8 c0317fd8 c013936a c40fdf84 000001d0 0000003c
Call Trace:    [<c015b664>] [<c0138f35>] [<c013936a>] [<c01393e2>] [<c0139596>]
                [<c0139608>] [<c0139748>] [<c01396b0>] [<c0105000>] [<c010587e>] [<c01396b0>]
Code: 8b 5b 04 8b 86 1c 01 00 00 a8 38 0f 84 5d 01 00 00 81 fb 08


>>EIP; c015b465 <prune_icache+45/220>   <=====

>>edx; c0318f08 <inode_unused+0/8>

Trace; c015b664 <shrink_icache_memory+24/40>
Trace; c0138f35 <shrink_cache+185/410>
Trace; c013936a <shrink_caches+4a/60>
Trace; c01393e2 <try_to_free_pages_zone+62/f0>
Trace; c0139596 <kswapd_balance_pgdat+66/b0>
Trace; c0139608 <kswapd_balance+28/40>
Trace; c0139748 <kswapd+98/c0>
Trace; c01396b0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010587e <arch_kernel_thread+2e/40>
Trace; c01396b0 <kswapd+0/c0>

Code;  c015b465 <prune_icache+45/220>
00000000 <_EIP>:
Code;  c015b465 <prune_icache+45/220>   <=====
   0:   8b 5b 04                  mov    0x4(%ebx),%ebx   <=====
Code;  c015b468 <prune_icache+48/220>
   3:   8b 86 1c 01 00 00         mov    0x11c(%esi),%eax
Code;  c015b46e <prune_icache+4e/220>
   9:   a8 38                     test   $0x38,%al
Code;  c015b470 <prune_icache+50/220>
   b:   0f 84 5d 01 00 00         je     16e <_EIP+0x16e>
Code;  c015b476 <prune_icache+56/220>
  11:   81 fb 08 00 00 00         cmp    $0x8,%ebx

