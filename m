Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131961AbRASQGk>; Fri, 19 Jan 2001 11:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133047AbRASQGa>; Fri, 19 Jan 2001 11:06:30 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:55045 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131961AbRASQGU>;
	Fri, 19 Jan 2001 11:06:20 -0500
Date: Fri, 19 Jan 2001 17:06:15 +0100
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: 2.4.0 crash [bdflush?]
To: linux-kernel@vger.kernel.org
Message-id: <14952.26103.873508.985330@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.89 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0 + aic7xxx (http://people.FreeBSD.org/~gibbs/linux/ patch)
+ 2GB RAM (CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y) crashed.
Before the crash, I observed zombie bdflush for some time.

This is the first crash fingerprint in kern.log:

Jan 17 15:25:25 jerolim kernel: kernel BUG at page_alloc.c:74!
Jan 17 15:25:25 jerolim kernel: invalid operand: 0000

I can send complete oops and other info if needed.
This is the beginning of oops (without warnings):

ksymoops 2.3.4 on i686 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (specified)
     -m /boot/System.map-2.4.0 (specified)

Jan 17 15:25:25 jerolim kernel: invalid operand: 0000
Jan 17 15:25:25 jerolim kernel: CPU:    0
Jan 17 15:25:25 jerolim kernel: EIP:    0010:[__free_pages_ok+62/776]
Jan 17 15:25:25 jerolim kernel: EFLAGS: 00010286
Jan 17 15:25:25 jerolim kernel: eax: 0000001f   ebx: c2100010   ecx: c027e1e8   edx: 00000000
Jan 17 15:25:25 jerolim kernel: esi: c2100038   edi: 00000000   ebp: 00000000   esp: c3233f78
Jan 17 15:25:25 jerolim kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 15:25:25 jerolim kernel: Process bdflush (pid: 5, stackpage=c3233000)
Jan 17 15:25:25 jerolim kernel: Stack: c022d3eb c022d5d9 0000004a c2100010 c2100038 00000000 00000000 00000000 
Jan 17 15:25:25 jerolim kernel:        00000000 00000000 00000001 c0128553 c0129cfe c0128745 c3232000 00000041 
Jan 17 15:25:25 jerolim kernel:        c323223a c322dfa4 00000004 00000000 0002a065 000416cd 00000000 c013254e 
Jan 17 15:25:25 jerolim kernel: Call Trace: [page_launder+899/2172] [__free_pages+26/28] [page_launder+1397/2172] [bdflush+134/208] [kernel_thread+40/56] 
Jan 17 15:25:25 jerolim kernel: Code: 0f 0b 83 c4 0c 89 d8 2b 05 98 4b 2e c0 69 c0 f1 f0 f0 f0 c1 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   89 d8                     mov    %ebx,%eax
Code;  00000007 Before first symbol
   7:   2b 05 98 4b 2e c0         sub    0xc02e4b98,%eax
Code;  0000000d Before first symbol
   d:   69 c0 f1 f0 f0 f0         imul   $0xf0f0f0f1,%eax,%eax
Code;  00000013 Before first symbol
  13:   c1 00 00                  roll   $0x0,(%eax)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
