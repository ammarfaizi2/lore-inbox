Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTBTNwU>; Thu, 20 Feb 2003 08:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTBTNwU>; Thu, 20 Feb 2003 08:52:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:15505
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265567AbTBTNwR>; Thu, 20 Feb 2003 08:52:17 -0500
Date: Thu, 20 Feb 2003 09:00:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0302200858540.10247-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Ingo Molnar wrote:

> 
> i think i managed to trigger a potentially useful oops, with BK-curr:
> 
> Unable to handle kernel paging request at virtual address 6b6b6b8b
>  printing eip:
> c011944b
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<c011944b>]    Not tainted
> EFLAGS: 00010046
> EIP is at do_page_fault+0x7b/0x4e4
> eax: 6b6b6b8b   ebx: 6b6b6b6b   ecx: 0000002b   edx: c02dd6ac
> esi: 6b6b6b8b   edi: ca095320   ebp: ca092170   esp: ca0920c8
> ds: 007b   es: 007b   ss: 0068
> Process start-threads (pid: 21685, threadinfo=ca090000 task=ca094ce0)
> Stack: c02dd6ac 0000002b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b8b 6b6b6b6b 6b6b6b6b
>        6b6b6b6b 00030001 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b
>        6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b
> Call Trace:

I've seen this with 2.5.62, it's here;

00407434086i[CPU0 ] task_switch: bad LDT segment at c0121a00
00407434086i[CPU0 ] task switch: posting exception 10 after commit point
00407434086p[CPU0 ] >>PANIC<< can_push(): SS invalidated.
00407434086i[SYS  ] Last time is 1045745354
00407434086i[XGUI ] Exit.
00407434086i[CPU0 ] protected mode
00407434086i[CPU0 ] CS.d_b = 32 bit
00407434086i[CPU0 ] SS.d_b = 32 bit
00407434086i[CPU0 ] | EAX=f7ffd6b4  EBX=ffffffff  ECX=0000007b  
EDX=f7f9c048
00407434086i[CPU0 ] | ESP=c02b97dc  EBP=00000001  ESI=00000000  
EDI=c0118250
00407434086i[CPU0 ] | IOPL=0 NV UP DI NG NZ NA PO NC
00407434086i[CPU0 ] | SEG selector     base    limit G D
00407434086i[CPU0 ] | SEG sltr(index|ti|rpl)     base    limit G D
00407434086i[CPU0 ] |  DS:007b( 000f| 0|  3) 00000000 000fffff 1 1
00407434086i[CPU0 ] |  ES:007b( 000f| 0|  3) 00000000 000fffff 1 1
00407434086i[CPU0 ] |  FS:0000( 0000| 0|  0) 00000000 000fffff 1 1
00407434086i[CPU0 ] |  GS:0000( 0000| 0|  0) 00000000 000fffff 1 1
00407434086i[CPU0 ] |  SS:0068( 000d| 0|  0) 00000000 000fffff 1 1
00407434086i[CPU0 ] |  CS:0060( 000c| 0|  0) 00000000 000fffff 1 1
00407434086i[CPU0 ] | EIP=c0121a00 (c0121a00)
00407434086i[CPU0 ] | CR0=0x8005003b CR1=0x00000000 CR2=0xf7f9bf88
00407434086i[CPU0 ] | CR3=0x00000000 CR4=0x000000b0
00407434086i[CPU0 ] >> 55
00407434086i[CPU0 ] >> : push EBP

(gdb) disassemble 0xc0121a00
Dump of assembler code for function do_exit:
0xc0121a00 <do_exit>:   push   %ebp
0xc0121a01 <do_exit+1>: push   %edi
0xc0121a02 <do_exit+2>: push   %esi
0xc0121a03 <do_exit+3>: push   %ebx

-- 
function.linuxpower.ca
