Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262951AbSJBDbB>; Tue, 1 Oct 2002 23:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262952AbSJBDbB>; Tue, 1 Oct 2002 23:31:01 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:35654 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S262951AbSJBDbA>; Tue, 1 Oct 2002 23:31:00 -0400
From: brian@worldcontrol.com
Date: Tue, 1 Oct 2002 20:36:24 -0700
To: linux-kernel@vger.kernel.org
Subject: sleeping function called from illegal context at slab.c:1374
Message-ID: <20021002033624.GA1742@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.40 

I have software suspend enabled in the kernel but it doesn't
appear to be running (though I'm only familiar with the 2.4.18
version).

It also doesn't show up in the SysRq help list.

These show up during boot:

Debug: sleeping function called from illegal context at slab.c:1374
d7ecde60 c01358bc c02f2808 0000055e c03df09c c03df0d4 c03df09c 00000000 
       c0245df7 c13c9d54 000001d0 00000026 c03df0e8 c13e0800 c0257050 d7ec67c0 
       00000039 c03df09c c03df08c c03defe0 00000000 c0245e97 c03df09c c03df08c 
Call Trace: [<c01358bc>] [<c0245df7>] [<c0257050>] [<c0245e97>] [<c0109549>] [<c
025fea0>] [<c0258239>] [<c025faf0>] [<c0258460>] [<c025fea0>] [<c02588d8>] [<c02
5811d>] [<c026bb40>] [<c0257478>] [<c0105075>] [<c0105040>] [<c0105601>]
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
d7ecde60 c01358bc c02f2808 0000055e c03df658 c03df690 c03df658 00000000 
       c0245df7 c13c9d54 000001d0 00000022 c03df6a4 c13e0800 c0257050 d7ec67c0 
       00000039 c03df658 c03df648 c03df59c 00000000 c0245e97 c03df658 c03df648 
Call Trace: [<c01358bc>] [<c0245df7>] [<c0257050>] [<c0245e97>] [<c0109549>] [<c
025fea0>] [<c0258239>] [<c025faf0>] [<c0258460>] [<c025fea0>] [<c02588d8>] [<c02
5811d>] [<c026bb5f>] [<c0257478>] [<c0105075>] [<c0105040>] [<c0105601>]
ide1 at 0x170-0x177,0x376 on irq 15
...
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem Off showPc unRaw Sync sh
owTasks Unmount 
Debug: sleeping function called from illegal context at slab.c:1374
d4ee3f78 c01358bc c02f2808 0000055e d4ee2000 d5328fe0 00000000 00000001 
       c010b930 c13c72e8 000001d0 bfffb568 00000018 00000000 d4ee2000 08080728 
       0000001f bffff658 c01077cb 00000000 00000400 00000001 08080728 0000001f 
Call Trace: [<c01358bc>] [<c010b930>] [<c01077cb>]


The first output run through ksymoops:

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   60                        pusha  
Code;  00000001 Before first symbol
   1:   de ec                     fsubrp %st,%st(4)
Code;  00000003 Before first symbol
   3:   d7                        xlat   %ds:(%ebx)
Code;  00000004 Before first symbol
   4:   bc 58 13 c0 08            mov    $0x8c01358,%esp
Code;  00000009 Before first symbol
   9:   28 2f                     sub    %ch,(%edi)
Code;  0000000b Before first symbol
   b:   c0 5e 05 00               rcrb   $0x0,0x5(%esi)
Code;  0000000f Before first symbol
   f:   00 9c f0 3d c0 d4 f0      add    %bl,0xf0d4c03d(%eax,%esi,8)
Code;  00000016 Before first symbol
  16:   3d c0 9c f0 3d            cmp    $0x3df09cc0,%eax
Code;  0000001b Before first symbol
  1b:   c0 00 00                  rolb   $0x0,(%eax)

Trace; c01358bc <__kmem_cache_alloc+10c/120>
Trace; c0245df7 <blk_init_free_list+57/e0>
Trace; c0257050 <via_set_speed+210/2d0>
Trace; c0245e97 <blk_init_queue+17/160>
Trace; c0109549 <setup_irq+a9/e0>

-- 
Brian Litzinger
