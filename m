Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVL0Q6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVL0Q6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVL0Q6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:58:41 -0500
Received: from smtp-8.smtp.ucla.edu ([169.232.47.137]:56243 "EHLO
	smtp-8.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S932308AbVL0Q6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:58:40 -0500
Date: Tue, 27 Dec 2005 08:58:39 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine that oopsed twice in the last 3 weeks.  Immediately 
before each oops was a "filemap.c:2234: bad pmd" message.  The first oops 
happened with 2.4.30, the second with 2.4.32.  The oops from 2.4.30 is 
below.  I don't have the oops from 2.4.32.

The machine is a usenet feeder and does a constant ~110mbit/s traffic.  I 
have the tg3 and bonding modules loaded.  There are 2 Adaptec controllers, 
one onboard, one pci (aic7899 and 3960D).  There are 5 disks off the first 
channel of aic7899 (comes up as scsi2), 4 of which are in a RAID5.  The 
other 3 channels are unused.  I have the .config for 2.4.30 available if 
needed.

Pointers for where to look if/when it happens again would be appreciated. 
Thanks.


-Chris

filemap.c:2234: bad pmd 00c001e3.
filemap.c:2234: bad pmd 010001e3.
Unable to handle kernel paging request at virtual address c13aef08
  printing eip:
c012d7b6
*pde = 010001e3
*pte = ce919a00
Oops: 0000
CPU:    1
EIP:    0010:[mark_page_accessed+6/48]    Not tainted
EFLAGS: 00010296
eax: c13aeef0   ebx: c13aeef0   ecx: 0005d800   edx: ee030900
esi: 0005d7a0   edi: 0005d8a9   ebp: f66b1c3c   esp: f66b1c38
ds: 0018   es: 0018   ss: 0018
Process innfeed (pid: 526, stackpage=f66b1000)
Stack: c13aeef0 f66b1c70 c012ea08 ee030900 0005d7a0 0005d8a9 0005d8a9 f7fa1d60
        f6628080 f6628144 f7628200 ee030900 c012e830 f77f4d80 f66b1cb8 c012a18e
        ee030900 63ca0000 00000000 f66b1ce4 c027404c 00000000 f77f4d80 00000106
Call Trace:    [filemap_nopage+472/544] [filemap_nopage+0/544] [do_no_page+126/608] [ip_queue_xmit+780/1424] [handle_mm_fault+121/272]
   [do_page_fault+1024/1472] [tcp_write_xmit+353/688] [tcp_new_space+137/160] [tcp_rcv_established+716/2480] [memcpy_toiovec+67/112] [do_page_fault+0/1472]
   [error_code+52/60] [csum_partial_copy_generic+61/260] [tcp_sendmsg+2367/4512] [inet_sendmsg+65/80] [sock_sendmsg+102/176] [sock_readv_writev+116/176]
   [sock_writev+79/96] [do_readv_writev+567/608] [sys_writev+88/128] [system_call+51/56]

Code: 8b 40 18 a8 80 75 07 8b 43 18 a8 04 75 0c f0 0f ba 6b 18 02



