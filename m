Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSGJFrF>; Wed, 10 Jul 2002 01:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSGJFrE>; Wed, 10 Jul 2002 01:47:04 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:9939 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S317480AbSGJFrD>; Wed, 10 Jul 2002 01:47:03 -0400
Date: Wed, 10 Jul 2002 07:49:16 +0200
From: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Oops with kernel BUG at dcache.c:345
Message-ID: <20020710054916.GA1800@Ado.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

My Linux machine just crashed during the morning cronjob with an Oops. Yes,
I know my kernel is tainted because I have the NVidia driver loaded, but
consider that maybe this driver is not the direct cause of the Oops but only
exposing an obscure bug in the kernel?

It also seems that enabling AGP using the kernel agpgart module makes this
Oops more likely to happen. Also forcing the AGP rate to 1x instead of 2x
does not seem to make any difference. With AGP disabled this machine reaches
quite respectable uptimes despite using the NVidia driver...

Because the machine was hung with the screen blanked I could not use
ksymoops, but this is the output of my syslog:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013c437
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[prune_dcache+167/328]    Tainted: P
EFLAGS: 00010286
eax: c3f21418   ebx: c3f21400   ecx: c3f2143c   edx: 00000000
esi: c3f213e8   edi: c3f213f0   ebp: 00001e55   esp: c1437f60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1437000)
Stack: 00000002 000001d0 00000020 00000006 c013c72b 00003c5f c0127471 00000006
       000001d0 00000006 000001d0 c01ee568 00000000 c01ee568 c01274bc 00000020
       c01ee568 00000001 c1436000 c0127553 c01ee4c0 00000000 c1436249 0008e000
Call Trace: [shrink_dcache_memory+27/52] [shrink_caches+105/128]
            [try_to_free_pages+52/84] [kswapd_balance_pgdat+67/140] 
            [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]

Code: 89 4a 04 89 11 89 46 30 89 40 04 8b 46 4c 85 c0 74 17 8b 40
 kernel BUG at dcache.c:345!
invalid operand: 0000
CPU:    0
EIP:    0010:[prune_dcache+108/328]    Tainted: P
EFLAGS: 00010282
eax: 0000001c   ebx: c3f21480   ecx: c01ed3c0   edx: 000042e4
esi: c3f21468   edi: 00000020   ebp: 00003969   esp: ca101ebc
ds: 0018   es: 0018   ss: 0018
Process frcode (pid: 26959, stackpage=ca101000)
Stack: c01ca0b4 00000159 0000001e 000001d2 00000020 00000006 c013c72b 00003969
       c0127471 00000006 000001d2 00000006 000001d2 c01ee568 c01ee568 c01ee568
       c01274bc 00000020 ca100000 00000000 000001d2 c0127e7f c01ee6e4 00000120
Call Trace: [shrink_dcache_memory+27/52] [shrink_caches+105/128]
            [try_to_free_pages+52/84] [balance_classzone+103/564]
            [__alloc_pages+254/352] [generic_file_write+982/1736]
            [_alloc_pages+22/24] [generic_file_write+1011/1736]
            [sys_write+145/240] [system_call+51/64]

Code: 0f 0b 83 c4 08 8d 46 10 8b 48 04 8b 53 f8 89 4a 04 89 11 89


Thanks for looking at this report,


Arjan

