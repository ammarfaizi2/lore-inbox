Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUENRuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUENRuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUENRui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:50:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:25023 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261980AbUENRtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:49:23 -0400
Date: Fri, 14 May 2004 10:40:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: BUG: ps2esdi causes kobject badness + OOPS
Message-Id: <20040514104033.56e9ede4.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in 2.6.6 and 2.6.6-mm2.


Calling initcall 0xc0fefc7e: ps2esdi_init+0x0/0x90()
Badness in kobject_get at lib/kobject.c:429
 [<c010707f>] dump_stack+0x17/0x1c
 [<c03a34da>] kobject_get+0x4c/0x4e
 [<c042e56a>] get_bus+0x16/0x2e
 [<c042de82>] bus_for_each_dev+0x1a/0xc2
 [<c08111ff>] mca_find_adapter+0x3b/0x68
 [<c0fefdf7>] ps2esdi_geninit+0x15/0x488
 [<c0fefcdb>] ps2esdi_init+0x5d/0x90
 [<c0fd2822>] do_initcalls+0x2a/0xb2
 [<c0100529>] init+0xe5/0x280
 [<c010429d>] kernel_thread_helper+0x5/0xc

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c042dec8
*pde = 00000000
       ___      ______
      0--,|    /OOOOOO\
     {_o  /  /OO plop OO\
       \__\_/OO oh dear OOO\s
          \OOOOOOOOOOOOOOOO/
           __XXX__   __XXX__
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c042dec8>]    Not tainted VLI
EFLAGS: 00010202   (2.6.6-mm2) 
EIP is at bus_for_each_dev+0x60/0xc2
eax: c0ebd98c   ebx: fffffff8   ecx: c0b2fad5   edx: 00000000
esi: c0ebd940   edi: c0ebd98c   ebp: f7f9af50   esp: f7f9af38
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9a000 task=f7f9ba50)
Stack: 00000000 c0ebd9f0 f7f9af5c f7f9af5c 00000001 00000000 f7f9af70 c08111ff 
       c081119c 0000df9f 00000000 00000000 f73cbe18 c1062424 f7f9af9c c0fefdf7 
       f73cbe18 c0446428 f7f9af9c c04339aa f7f9afac c01258d2 c1062424 00000001 
Call Trace:
 [<c0107052>] show_stack+0x7a/0x90
 [<c01071d6>] show_registers+0x152/0x1b4
 [<c0107397>] die+0xcf/0x194
 [<c011ba9c>] do_page_fault+0x1ee/0x51c
 [<c0106d19>] error_code+0x2d/0x38
 [<c08111ff>] mca_find_adapter+0x3b/0x68
 [<c0fefdf7>] ps2esdi_geninit+0x15/0x488
 [<c0fefcdb>] ps2esdi_init+0x5d/0x90
 [<c0fd2822>] do_initcalls+0x2a/0xb2
 [<c0100529>] init+0xe5/0x280
 [<c010429d>] kernel_thread_helper+0x5/0xc

Code: 45 ec ba 2b 00 00 00 8d 86 a8 00 00 00 0f 44 d8 b8 d5 fa b2 c0 e8 cb 3d cf ff 89 f8 f0 ff 00 0f 88 06 08 00 00 8b 53 08 8d 5a f8 <8b> 43 08 0f 18 00 90 3b 55 ec 74 32 89 d8 e8 e1 f3 ff ff 8b 55 
 <0>Kernel panic: Attempted to kill init!


--
~Randy
