Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281368AbRKEVtR>; Mon, 5 Nov 2001 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281370AbRKEVtH>; Mon, 5 Nov 2001 16:49:07 -0500
Received: from [202.73.165.1] ([202.73.165.1]:1664 "EHLO maravillo.q-linux.com")
	by vger.kernel.org with ESMTP id <S281368AbRKEVsx>;
	Mon, 5 Nov 2001 16:48:53 -0500
Date: Tue, 6 Nov 2001 05:48:41 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Cc: mike.maravillo@q-linux.com
Subject: 2.4.13-ac7: prune_icache oops!
Message-ID: <20011106054841.A7334@maravillo.q-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling the kernel and running nuvrec, the following oops
popped up.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0141e65>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: fbc8fd27   ebx: c0008908   ecx: cf232e40   edx: c5d71ac0
esi: c0008900   edi: f71af875   ebp: c14c1fa4   esp: c14c1f88
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c14c1000)
Stack: 00000000 0000000f cf232e48 c69a7908 00000000 000000c0 00000000 0008e000 
       c0141f2a fffffff1 000025d0 c012a0f2 00000000 000000c0 c14270c0 000000c0 
       00000080 00000000 00000006 000000c0 c012a187 000000c0 00000000 00010f00 
Call Trace: [<c0141f2a>] [<c012a0f2>] [<c012a187>] [<c0105000>] [<c01054f6>] 
   [<c012a120>] 
Code: 0f 0b 0b 86 d4 00 00 00 75 d9 56 e8 4b ef fe ff 85 c0 59 75 

>>EIP; c0141e65 <prune_icache+45/e0>   <=====
Trace; c0141f2a <shrink_icache_memory+2a/50>
Trace; c012a0f2 <do_try_to_free_pages+22/50>
Trace; c012a187 <kswapd+67/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01054f6 <kernel_thread+26/30>
Trace; c012a120 <kswapd+0/c0>
Code;  c0141e65 <prune_icache+45/e0>
00000000 <_EIP>:
Code;  c0141e65 <prune_icache+45/e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0141e67 <prune_icache+47/e0>
   2:   0b 86 d4 00 00 00         or     0xd4(%esi),%eax
Code;  c0141e6d <prune_icache+4d/e0>
   8:   75 d9                     jne    ffffffe3 <_EIP+0xffffffe3> c0141e48 <prune_icache+28/e0>
Code;  c0141e6f <prune_icache+4f/e0>
   a:   56                        push   %esi
Code;  c0141e70 <prune_icache+50/e0>
   b:   e8 4b ef fe ff            call   fffeef5b <_EIP+0xfffeef5b> c0130dc0 <inode_has_buffers+0/20>
Code;  c0141e75 <prune_icache+55/e0>
  10:   85 c0                     test   %eax,%eax
Code;  c0141e77 <prune_icache+57/e0>
  12:   59                        pop    %ecx
Code;  c0141e78 <prune_icache+58/e0>
  13:   75 00                     jne    15 <_EIP+0x15> c0141e7a <prune_icache+5a/e0>

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
