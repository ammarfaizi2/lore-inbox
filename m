Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSEWLrs>; Thu, 23 May 2002 07:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316459AbSEWLrr>; Thu, 23 May 2002 07:47:47 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:16001 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S315988AbSEWLrq>;
	Thu, 23 May 2002 07:47:46 -0400
Message-ID: <00ec01c2024f$9809db90$f6de11cc@black>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: page_alloc bug in 2.4.17-pre8
Date: Thu, 23 May 2002 07:47:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine had been up for 2-1/2 days and had run this backup (afio) twice successfully.

Here's line 108 of page_alloc.c:
        if (PageLRU(page))
                BUG();

Hopefully this doesn't indicate a CPU problem?  The power supply on this thing blew Saturday but has run OK until now.

May 22 00:51:01 picard kernel: kernel BUG at page_alloc.c:108!
May 22 00:51:01 picard kernel: invalid operand: 0000
May 22 00:51:01 picard kernel: CPU:    1
May 22 00:51:01 picard kernel: EIP:    0010:[swap_duplicate+82/192]    Not tainted
May 22 00:51:01 picard kernel: EFLAGS: 00010286
May 22 00:51:01 picard kernel: eax: 01000009   ebx: c176aed0   ecx: c176aed0   edx: cfd67690
May 22 00:51:01 picard kernel: esi: 00000000   edi: cfd67690   ebp: 000000e3   esp: ce55fef8
May 22 00:51:01 picard kernel: ds: 0018   es: 0018   ss: 0018
May 22 00:51:01 picard kernel: Process afio (pid: 15467, stackpage=ce55f000)
May 22 00:51:01 picard kernel: Stack: c176aed0 00001000 cfd67690 000000e3 00008000 f09fb2ac 00015f90 00000000
May 22 00:51:01 picard kernel:        c176aed0 c176aed0 efd5ae28 cfd67690 000000e2 c0131858 c012a04d ce55ff8c
May 22 00:51:01 picard kernel:        c176aed0 00000000 00001000 00000000 dd3318a0 ffffffea 00008000 00001000
May 22 00:51:01 picard kernel: Call Trace: [<f09fb2ac>] [shmem_truncate+172/524] [generic_file_write+1781/1856] [mprotect_fixup+270/
1176] [change_protection+268/348]
May 22 00:51:01 picard kernel:    [create_empty_buffers+75/80] [probe_irq_on+15/292]
May 22 00:51:01 picard kernel:
May 22 00:51:01 picard kernel: Code: 0f 0b 6c 00 93 b3 24 c0 89 d8 2b 05 f0 70 30 c0 69 c0 ab aa

Michael D. Black mblack@csihq.com
http://www.csihq.com/
http://www.csihq.com/~mike
321-676-2923, x203
Melbourne FL

