Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbTGJX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbTGJX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:29:16 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:58263 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S269703AbTGJX3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:29:09 -0400
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.74 X.25+LAPB still kills the kernel
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Jul 2003 00:28:44 +0200
Message-ID: <m37k6qhv8j.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No need to actually use X.25+LAPB, it's enough to just compile it in.
Linux version 2.5.74 (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4))
You do not need Ethernet either, it will oops with just loopback as well.
Serial console dump follows (details available on request in case someone
need them).

gw:/# ip link
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

gw:/# ifconfig
lo        Link eUnable to handle kernel paging requestncap:Local Loopb at virtual address 6b6b6b6b
ack
          printing eip:
 inet addr:127.0c01a0f22
.0.1  Mask:255.0*pde = 00000000
.0.0
          Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01a0f22>]    Not tainted
EFLAGS: 00010202
EIP is at __release_sock+0x22/0x60
eax: 6b6b6b6b   ebx: 00000000   ecx: 00000000   edx: c3cd2c44
esi: c3cd2c44   edi: c3cd2c44   ebp: c10b7f00   esp: c10b7ef8
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 37, threadinfo=c10b6000 task=c10ce060)
Stack: 00000000 c3cd2c88 c10b7f18 c01ee728 c3cd2c44 c3cd2c44 c3ed1d2c c3cdb494
       c10b7f40 c01eebf8 c3cd2c44 c3cd2c44 00000000 00000000 00000000 c3cdb494
       00000000 c3cdb4b8 c10b7f54 c019e1d6 c3cdb494 c3cdb4b8 c3ced41c c10b7f64
Call Trace:
 [<c01ee728>] x25_destroy_socket+0x188/0x1a0
 [<c01eebf8>] x25_release+0x38/0xa0
 [<c019e1d6>] sock_release+0x56/0x80
 [<c019e9a3>] sock_close+0x23/0x40
 [<c01432b6>] __fput+0xd6/0xe0
 [<c0141cdb>] filp_close+0x3b/0x60
 [<c0141d47>] sys_close+0x47/0x60
 [<c010ac17>] syscall_call+0x7/0xb

Code: 8b 18 c7 00 00 00 00 00 50 56 ff 96 1c 01 00 00 85 db 5a 89
 UP LOOPBACK RUNN<0>Kernel panic: Fatal exception in interrupt
ING  MTU:16436  In interrupt handler - not syncing
Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
-- 
Krzysztof Halasa
Network Administrator
