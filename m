Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132579AbRC2Foc>; Thu, 29 Mar 2001 00:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132680AbRC2FoW>; Thu, 29 Mar 2001 00:44:22 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:53002 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S132579AbRC2FoQ>; Thu, 29 Mar 2001 00:44:16 -0500
Date: Thu, 29 Mar 2001 02:46:41 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel panic in 2.4.2
Message-ID: <20010329024641.B4303@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I arrived at my machine tonight it was dead, with a nice
panic on the screen as a greeting. On rebooting I found something
in the logs, which is rare because it said "not syncing". So I'm
assuming this isn't the panic that killed the box, but she
probably knows (of) him, so let's interrogate her anyway:

Unable to handle kernel paging request at virtual address 00020008
c0139fad
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[bdput+5/96]
EFLAGS: 00010206
eax: 00020000   ebx: 00020000   ecx: ca59a648   edx: c15ddfa4
esi: c15ddfa4   edi: c97b9428   ebp: c15ddfac   esp: c15ddf6c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c15dd000)
Stack: ca59a640 c0146ef2 00020000 ca59a640 c0146f47 ca59a640 c97b9608 c97b9600
       c0147179 c15ddfa4 00010f00 00000004 00000000 000036dd ca59a828 c29620c8
       00000000 c01471a9 00000000 c012cde3 00000006 00000004 00000006 00000004
Call Trace: [clear_inode+194/220] [dispose_list+59/84] [prune_icache+261/276] [shrink_icache_memory+33/48] [do_try_to_free_pages+103/124] [kswapd+101/240] [kernel_thread+40/56]
Code: f0 ff 4b 08 0f 94 c0 84 c0 74 4d f0 fe 0d 60 25 24 c0 0f 88
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol            00000000 <_EIP>:
Code;  00000000 Before first symbol               0:   f0 ff 4b 08               lock decl 0x8(%ebx)
Code;  00000004 Before first symbol               4:   0f 94 c0                  sete   %al
Code;  00000007 Before first symbol               7:   84 c0                     test   %al,%al
Code;  00000009 Before first symbol               9:   74 4d                     je     58 <_EIP+0x58> 00000058 Before first symbol
Code;  0000000b Before first symbol               b:   f0 fe 0d 60 25 24 c0      lock decb 0xc0242560
Code;  00000012 Before first symbol              12:   0f 88 00 00 00 00         js     18 <_EIP+0x18> 00000018 Before first symbol

kernel BUG at exit.c:458!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_exit+668/680]
EFLAGS: 00010286
eax: 0000001a   ebx: c023d020   ecx: 00000002   edx: 02000000
activating NMI Watchdog ... done.
cpu: 0, clocks: 1002544, slice: 334181
cpu: 1, clocks: 1002544, slice: 334181


oh, kernel 2.4.2. I'd be using 2.4.2-ac*, but my radeon doesn't
like it (and no I can't report a bug on that, because I have
nothing to repot on that).

Cheers!

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
What you don't know won't help you much either.
		-- D. Bennett
