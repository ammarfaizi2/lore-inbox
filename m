Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTEOBvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEOBvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:51:02 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:10176 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263645AbTEOBu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:50:59 -0400
Subject: 2.5.69-mm5: pccard oops while booting: resolved
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 15 May 2003 04:03:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I was having the following Oops when booting 2.5.69-mm5:

Unable to handle kernel paging request at virtual address febf0000
 printing eip:
c0192498
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0192498>]    Not tainted VLI
EFLAGS: 00010286
EIP is at pci_bus_match+0x18/0xb0
eax: 00000000   ebx: c13c1000   ecx: febf0000   edx: 00000000
esi: c13c104c   edi: ffffffed   ebp: cff3944c   esp: cfde7ed0
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 10, threadinfo=cfde6000 task=c1390060)
Stack: cff46390 c01d044f c13c104c cff46390 cff463c0 c13c104c c03207dc
c01d04ef
       c13c104c cff46390 c13c104c c0320780 c13c1084 c01d06a4 c13c104c
c02c35e3
       c03270a0 c13c104c 00000000 c13c1084 c01cf874 c13c104c cffc3a40
c13c1000
Call Trace:
 [<c01d044f>] bus_match+0x2f/0x80
 [<c01d04ef>] device_attach+0x4f/0x90
 [<c01d06a4>] bus_add_device+0x64/0xb0
 [<c01cf874>] device_add+0xd4/0x110
 [<c018eb5e>] pci_bus_add_devices+0xae/0xe0
 [<c020339b>] cb_alloc+0xab/0xf0
 [<c02001d9>] socket_insert+0x69/0x80
 [<c01ff78a>] get_socket_status+0x1a/0x20
 [<c020041d>] pccardd+0x13d/0x1f0
 [<c0115e90>] default_wake_function+0x0/0x20
 [<c0109272>] ret_from_fork+0x6/0x14
 [<c0115e90>] default_wake_function+0x0/0x20
 [<c02002e0>] pccardd+0x0/0x1f0
 [<c010722d>] kernel_thread_helper+0x5/0x18

Code: 83 fa 06 7e f1 31 c0 c3 b8 e0 06 32 c0 c3 90 8d 74 26 00 53 8b 44
24 0c 8b 5c 24 08
83 e8 28 8b 48 0c 83 eb 4c 31 c0 85 c9 74 30 <8b> 11 85 d2 74 7a 89 f6
83 fa ff 74 2b 0f b
7 43 24 39 c2 74 23

This oops made me unable to use my 3Com CardBus NIC.

I've been able to pinpoint the culprit of this: it's the
"make-KOBJ_NAME-match-BUS_ID_SIZE.patch" patch that it's causing the
oops for me when booting 2.5.69.mm5.

Reverting this patch solves the oops for me.

I don't have the resources to investigate why this patch is causing the
oops for me, but I'm willing to help you, if you need it :-)

Thanks!


