Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJFKBW>; Sat, 6 Oct 2001 06:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJFKBF>; Sat, 6 Oct 2001 06:01:05 -0400
Received: from dupla.xtdnet.nl ([213.160.202.75]:3457 "EHLO dupla.xtdnet.nl")
	by vger.kernel.org with ESMTP id <S275097AbRJFKAW>;
	Sat, 6 Oct 2001 06:00:22 -0400
Date: Sat, 6 Oct 2001 11:59:59 +0200 (MET DST)
From: Paul Wouters <paul@xtdnet.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9ac3 smp oops (__alloc_pages?)
Message-ID: <Pine.LNX.4.40.0110061153080.1027-100000@dupla.xtdnet.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After running for a quite a while in a quite stable consotion, I had to reset
one of our servers today due to a re-powering of cables. A few hours later
I got the following oops.

The machine is a Dual Pentium II Deschutes, Asus mainboard, SCSI, EEpro,
256M RAM and 256M swap

Oct  6 11:14:43 dupla kernel: invalid operand: 0000
Oct  6 11:14:43 dupla kernel: CPU:    1
Oct  6 11:14:43 dupla kernel: EIP:    0010:[rmqueue+443/488]
Oct  6 11:14:43 dupla kernel: EFLAGS: 00010202
Oct  6 11:14:43 dupla kernel: eax: 00000048   ebx: c119994c   ecx: c029fa94   edx: 0000605f
Oct  6 11:14:43 dupla kernel: esi: 00000001   edi: c029fab8   ebp: 00000000   esp: c8cdfe64
Oct  6 11:14:43 dupla kernel: ds: 0018   es: 0018   ss: 0018
Oct  6 11:14:43 dupla kernel: Process ypserv (pid: 12216, stackpage=c8cdf000)
Oct  6 11:14:43 dupla kernel: Stack: 000000d2 c029fc20 00000001 c11bdac4 0000505f 00000286 c029fac4 00000000
Oct  6 11:14:43 dupla kernel:        c029fa94 c012e25c 000000d2 ca99b500 068dd065 c11bdac4 00000000 c1000010
Oct  6 11:14:43 dupla kernel:        00000001 c029fc1c 000000d2 c012e200 c1000010 c01237ea cc9a2d20 ca99b500
Oct  6 11:14:43 dupla kernel: Call Trace: [__alloc_pages+88/584] [_alloc_pages+24/28] [do_wp_page+342/576] [handle_mm_fault+167/220] [do_page_fault+387/1228]
Oct  6 11:14:43 dupla kernel:    [do_page_fault+0/1228] [filp_close+155/164] [sys_close+95/116] [error_code+56/64]
Oct  6 11:14:43 dupla kernel:
Oct  6 11:14:43 dupla kernel: Code: 0f 0b 89 d8 eb 1f 47 83 44 24 18 0c 83 ff 09 0f 86 60 fe ff
Oct  6 11:14:43 dupla kernel:  invalid operand: 0000
Oct  6 11:14:43 dupla kernel: CPU:    0
Oct  6 11:14:43 dupla kernel: EIP:    0010:[rmqueue+443/488]
Oct  6 11:14:43 dupla kernel: EFLAGS: 00010282
Oct  6 11:14:44 dupla kernel: eax: 00000088   ebx: c1199908   ecx: c029fa94   edx: 0000605e
Oct  6 11:14:44 dupla kernel: esi: 00000001   edi: c029fab8   ebp: 00000000   esp: c85d1e64
Oct  6 11:14:44 dupla kernel: ds: 0018   es: 0018   ss: 0018
Oct  6 11:14:44 dupla kernel: Process ypserv (pid: 12214, stackpage=c85d1000)
Oct  6 11:14:44 dupla kernel: Stack: 000000d2 c029fc20 00000001 c13f7cdc 0000505e 00000286 c029fab8 00000000
Oct  6 11:14:44 dupla kernel:        c029fa94 c012e25c 000000d2 ca99b0a0 0ef03045 c13f7cdc 00000000 cec3cb00
Oct  6 11:14:44 dupla kernel:        00000001 c029fc1c 000000d2 c012e200 c1000010 c01237ea caed8a20 ca99b0a0
Oct  6 11:14:44 dupla kernel: Call Trace: [__alloc_pages+88/584] [_alloc_pages+24/28] [do_wp_page+342/576] [handle_mm_fault+167/220] [do_page_fault+387/1228]
Oct  6 11:14:44 dupla kernel:    [do_page_fault+0/1228] [update_atime+68/72] [do_generic_file_read+1322/1336]
[generic_file_read+99/128] [file_read_actor+0/84] [sys_read+187/196]
Oct  6 11:14:44 dupla kernel:    [error_code+56/64]
Oct  6 11:14:44 dupla kernel:
Oct  6 11:14:44 dupla kernel: Code: 0f 0b 89 d8 eb 1f 47 83 44 24 18 0c 83 ff 09 0f 86 60 fe ff
Oct  6 11:14:44 dupla kernel:  invalid operand: 0000
Oct  6 11:14:44 dupla kernel: CPU:    1
Oct  6 11:14:44 dupla kernel: EIP:    0010:[rmqueue+443/488]
Oct  6 11:14:44 dupla kernel: EFLAGS: 00010282
Oct  6 11:14:44 dupla kernel: eax: 00000088   ebx: c11588d8   ecx: c029fa94   edx: 00005112
Oct  6 11:14:44 dupla kernel: esi: 00000001   edi: c029fab8   ebp: 00000000   esp: cf7d1e64
Oct  6 11:14:44 dupla kernel: ds: 0018   es: 0018   ss: 0018
Oct  6 11:14:44 dupla kernel: Process ypserv (pid: 12217, stackpage=cf7d1000)
Oct  6 11:14:44 dupla kernel: Stack: 000000d2 c029fc20 00000001 c13c8a7c 00004112 00000286 c029fac4 00000000
Oct  6 11:14:44 dupla kernel:        c029fa94 c012e25c 000000d2 ca99bbe0 0e3eb065 c13c8a7c 00000000 c1000010
Oct  6 11:14:44 dupla kernel:        00000001 c029fc1c 000000d2 c012e200 c1000010 c01237ea ce096520 ca99bbe0
Oct  6 11:14:44 dupla kernel: Call Trace: [__alloc_pages+88/584] [_alloc_pages+24/28] [do_wp_page+342/576] [handle_mm_fault+167/220] [do_page_fault+387/1228]
Oct  6 11:14:44 dupla kernel:    [do_page_fault+0/1228] [schedule+1058/1568] [filp_close+155/164] [sys_close+95/116] [error_code+56/64]
Oct  6 11:14:44 dupla kernel:
Oct  6 11:14:44 dupla kernel: Code: 0f 0b 89 d8 eb 1f 47 83 44 24 18 0c 83 ff 09 0f 86 60 fe ff

The machine had to be powercycled from here (remotely, I didn't see console)


