Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318419AbSGYL33>; Thu, 25 Jul 2002 07:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318420AbSGYL33>; Thu, 25 Jul 2002 07:29:29 -0400
Received: from sendar.prophecy.lu ([213.166.63.242]:9867 "EHLO
	sendar.prophecy.lu") by vger.kernel.org with ESMTP
	id <S318419AbSGYL32>; Thu, 25 Jul 2002 07:29:28 -0400
Message-Id: <4.1.20020725133008.01c251c0@quigon>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1 
Date: Thu, 25 Jul 2002 13:33:13 +0200
To: linux-kernel@vger.kernel.org
From: Emil Eifrem <emil-spam@eifrem.com>
Subject: FS corruption on Dell Inspiron 8k w/ IBM-DJSA-220
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had quite a lot of problems with my Dell Inspiron 8000 laptop under
Linux, with random filesystem corruption and arbitrary kernel panics on (I
believe) high disk traffic. I have an IBM DJSA-220 20 gig harddisk:

/dev/hda:

 Model=IBM-DJSA-220, FwRev=JS4OAC3A, SerialNo=44K44SH8203
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39070080
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5 

I think other people have problems with similar setups, as recorded for
example in the thread starting here:

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.0/0627.html

Anyway, I just got a "Kernel BUG" dump so I figured since this problem
seems to have stuck with us for a while I might as well report it here and
see if anyone might wanna make a go at it. I'm running the kernel that
ships with RH 7.3, reportedly 2.4.18-3. I was in runlevel 1 with basically
no other user processes running (it happened during a partition transfer),
which is good except that I couldn't copy and paste the dump to file. Thus,
the log below has been typed manually by me -- I was quite careful but
there may be typos.

--------------------------[ cut here ] ----------------------
Kernel BUG at page_alloc.c:117!
invalid operand: 0000
maestro3 ac97_codec soundcore agpgart NVdriver binfmt_misc autofs eepro100 ipc
CPU:	0
EIP:	0010:[<c01316e7>]	Tainted: P
EFLAGS:	00010282

EIP is at __free_pages_ok [kernel] 0x57 (2.4.18-3)
eax: 00000020	ebx: c12c4a38	ecx: 00000001	edx: 00002512
esi: 00000000	edi: c02c473c	ebp: 00000000	esp: c139bf58
ds: 0018	es: 0018	ss: 0018
Process kswapd (pid: 5, stackpage=c139b000)

Stack: [snipped]

Call Trace: [<c013d0e3>] try_to_free_buffers [kernel] 0xb3
[<c013b23a>] try_to_release_page [kernel] 0x3a
[<c012f164>] drop_page [kernel] 0x34
[<c0130726>] refill_inactive_zone [kernel] 0x206
[<c0131090>] kswapd [kernel] 0x280
[<c0105000>] stext [kernel] 0x0
[<c0107136>] kernel_thread [kernel] 0x26
[<c0130e10>] kswapd [kernel] 0x0

Code: 0f 0b 5d 58 8b 3d f0 e2 32 c0 89 d8 29 f8 69 c0 b7 6d db b6


Thanks in advance,

- - -
Emil Eifrem   [ emil@eifrem.com || www.eifrem.com || www.javamud.org ]

