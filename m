Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319189AbSHMXkA>; Tue, 13 Aug 2002 19:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319184AbSHMXiw>; Tue, 13 Aug 2002 19:38:52 -0400
Received: from holomorphy.com ([66.224.33.161]:44466 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319186AbSHMXiE>;
	Tue, 13 Aug 2002 19:38:04 -0400
Date: Tue, 13 Aug 2002 16:39:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.31 qlogicisp oops
Message-ID: <20020813233952.GC29459@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI aficionados, enjoy. Seen on 2.5.31.


Cheers,
Bill


ksymoops 2.4.6 on i686 2.5.31.  Options used
     -v vmlinux-2.5.31-akpm-11 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.31/ (default)
     -m /boot/System.map-2.5.31-akpm-11 (specified)

No modules in ksyms, skipping objects
Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 00000134
c01eef9e
*pde = 00104001
Oops: 0002
CPU:    1
EIP:    0010:[<c01eef9e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: f7987040   ecx: 00000000   edx: 00000000
esi: f79ba400   edi: 00000002   ebp: cc0ebf08   esp: cc0ebee4
ds: 0018   es: 0018   ss: 0018
Stack: f7987040 f79ba408 f79ba400 00000002 00000002 00000002 f79ba550 f79ba400
       00000000 cc0ebf28 c01eecca 00000013 f79ba400 cc0ebf74 cc098a40 24000001
       00000013 cc0ebf48 c0109404 00000013 f79ba400 cc0ebf74 c0307a70 c0307a60
Call Trace: [<c01eecca>] [<c0109404>] [<c0109658>] [<c0105394>] [<c0107d74>]
   [<c0105394>] [<c01053c2>] [<c0105469>] [<c0119766>]
Code: 89 82 34 01 00 00 83 c4 04 eb 14 8d b4 26 00 00 00 00 8b 4d


>>EIP; c01eef9e <isp1020_intr_handler+2ae/368>   <=====

Trace; c01eecca <do_isp1020_intr_handler+4e/74>
Trace; c0109404 <handle_IRQ_event+28/50>
Trace; c0109658 <do_IRQ+c0/15c>
Trace; c0105394 <default_idle+0/38>
Trace; c0107d74 <common_interrupt+18/20>
Trace; c0105394 <default_idle+0/38>
Trace; c01053c2 <default_idle+2e/38>
Trace; c0105469 <cpu_idle+41/50>
Trace; c0119766 <release_console_sem+ee/f8>

Code;  c01eef9e <isp1020_intr_handler+2ae/368>
00000000 <_EIP>:
Code;  c01eef9e <isp1020_intr_handler+2ae/368>   <=====
   0:   89 82 34 01 00 00         mov    %eax,0x134(%edx)   <=====
Code;  c01eefa4 <isp1020_intr_handler+2b4/368>
   6:   83 c4 04                  add    $0x4,%esp
Code;  c01eefa7 <isp1020_intr_handler+2b7/368>
   9:   eb 14                     jmp    1f <_EIP+0x1f> c01eefbd <isp1020_intr_handler+2cd/368>
Code;  c01eefa9 <isp1020_intr_handler+2b9/368>
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01eefb0 <isp1020_intr_handler+2c0/368>
  12:   8b 4d 00                  mov    0x0(%ebp),%ecx


$ addr2line -e vmlinux-2.5.31-akpm-11  c01eef9e
/mnt/b/akpm/linux-2.5.31/drivers/scsi/qlogicisp.c:1051

(despite the -akpm name, it's still virgin 2.5.31 I'm trying to get running)


Cheers,
Bill

P.S: disassembly with source intermixed available upon request
