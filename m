Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132755AbRDQQhc>; Tue, 17 Apr 2001 12:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRDQQha>; Tue, 17 Apr 2001 12:37:30 -0400
Received: from pop.gmx.net ([194.221.183.20]:30669 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132755AbRDQQg7>;
	Tue, 17 Apr 2001 12:36:59 -0400
Message-ID: <3ADC70DD.EECB4A3B@gmx.de>
Date: Tue, 17 Apr 2001 18:35:41 +0200
From: ernte23@gmx.de
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: crashing in module unload
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> It's crashing in module unload, and it appears that the module is
> freeing things which were not allocated (or freeing something twice).
> It's a module bug --- report it on linux-kernel.  This does not look
> like a mm bug.

I was using 2.4.4-pre1 when this happened.
The system is an Athlon / VIA KT133A.
Maybe it's already fixed.

kernel BUG at page_alloc.c:73!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+34/784]
EFLAGS: 00010286
eax: 0000001f   ebx: c13b3a34   ecx: cedda200   edx: 00000008
esi: c144c400   edi: ce1b2d40   ebp: 00000000   esp: c37cdf1c
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 1310, stackpage=c37cd000)
Stack: c01dbba5 c01dbc7a 00000049 ce1b2c00 c144c400 ce1b2d40 bfffedbc
c144c474 
       c144c478 c019dc31 c02023f4 db800000 c012a2fa c012a324 c010bb9e
d08fbb1b 
       c144c400 00000200 cdef9000 0def9000 c144c400 ce1b2c00 c144c400
d08fc6a0 
Call Trace: [pci_release_regions+129/160] [<db800000>]
[__free_pages+26/32] [free_pages+36/48] [pci_free_consistent+30/32]
[<d08fbb1b>] [<d08fc6a0>] 
       [pci_unregister_driver+47/80] [<d08fa000>] [<d08fa000>]
[<d08fbb6a>] [<d08fc6a0>] [free_module+27/160] [<d08fa000>]
[nls_iso8859-15:__insmod_nls_iso8859-15_O/var/2.4.4-pre1/kernel/fs/nls/nls_+0/96] 
       [sys_delete_module+382/464] [<d08fa000>] [system_call+51/56] 

Code: 0f 0b 83 c4 0c 83 7b 08 00 74 16 6a 4b 68 7a bc 1d c0 68 a5 
kernel BUG at swap.c:183!
invalid operand: 0000
CPU:    0
EIP:    0010:[deactivate_page_nolock+187/320]
EFLAGS: 00010292
eax: 0000001a   ebx: c13b3a34   ecx: 00000000   edx: ffffffff
esi: c13b3a50   edi: 000002cc   ebp: 00000000   esp: c147bf74
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c147b000)
Stack: c01db645 c01db707 000000b7 c13b3a50 c13b3a34 c012907e c13b3a34
00000006 
       00000495 c147a000 00000a5e c012931e 00000006 00000001 00010f00
00000000 
       00000004 00000000 c01293a9 00000004 00000000 00010f00 c01db9f1
c147a239 
Call Trace: [refill_inactive_scan+158/256] [refill_inactive+94/160]
[do_try_to_free_pages+73/128] [kswapd+111/272] [init+0/336]
[kernel_thread+35/48] 

Code: 0f 0b 83 c4 0c 8b 43 18 a8 40 75 0f 8b 43 18 a8 80 75 08 8b 
kernel BUG at exit.c:458!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_exit+526/544]
EFLAGS: 00010286
eax: 0000001a   ebx: c01ffe80   ecx: 00000000   edx: ffffffff
esi: c147a000   edi: 0000000b   ebp: 00000000   esp: c147be7c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c147b000)
Stack: c01d9305 c01d939c 000001ca c147bf40 00000000 c0107640 c0107402
0000000b 
       c01076bf c01d1cda c147bf40 00000000 c147a000 00000000 00000004
00000000 
       00030002 c012797b 0000280e 00000000 00000001 00000021 c019f997
00000000 
Call Trace: [do_invalid_op+0/144] [die+66/80] [do_invalid_op+127/144]
[deactivate_page_nolock+187/320] [vgacon_cursor+439/448]
[set_cursor+110/128] [vt_console_print+724/752] 
       [error_code+52/60] [deactivate_page_nolock+187/320]
[refill_inactive_scan+158/256] [refill_inactive+94/160]
[do_try_to_free_pages+73/128] [kswapd+111/272] [init+0/336]
[kernel_thread+35/48] 

Code: 0f 0b 83 c4 0c e9 42 fe ff ff 90 8d b4 26 00 00 00 00 8b 4c 
kernel BUG at exit.c:458!
