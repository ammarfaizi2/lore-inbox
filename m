Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTDYRqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbTDYRqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:46:11 -0400
Received: from freeside.toyota.com ([63.87.74.7]:56715 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S263473AbTDYRqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:46:10 -0400
Message-ID: <3EA97735.8070005@tmsusa.com>
Date: Fri, 25 Apr 2003 10:58:13 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: 2.5.68-mm2+e100=trouble
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

This may be of interest...

kernel: 2.5.68-mm2

Linux distro: Red Hat 8.0 + updates

Hardware:
Celeron 1.2 Ghz on Intel Motherboard
512 MB RAM, 2x e100 ethernet

2.5.68-mm2 initially would not boot for me, and I noticed that
it was dying at the point where it was loading the e100 driver -

I booted -mm2 again specifying the eepro100 driver instead
and it came up fine.

To get another look at the e100 problem, I shut down networking
and removed the eepro100 module - all good, so far -

Then I said "modprobe e100" and the following oops occurred:

-------------------------- snip ------------------------------

Unable to handle kernel paging request at virtual address c048f190
 printing eip:
c048f190
*pde = 00103027
*pte = 0048f000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c048f190>]    Not tainted VLI
EFLAGS: 00010286
EIP is at apply_alternatives+0x0/0xf0
eax: e0e215be   ebx: e0e0f618   ecx: 0000008b   edx: 00000076
esi: c03df35b   edi: e0e0f36e   ebp: d566defc   esp: d566dee0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1524, threadinfo=d566c000 task=d58b8a00)
Stack: c011abe4 e0e21548 e0e215be e0e0f2d2 e0dff000 e0e0f3e8 000004d8 
d566df8c
       c0143f2b e0dff000 e0e0f3e8 e0e26280 00000018 e0e26280 00000001 
00000001
       00000000 00000500 000004d8 000002d0 e09d7000 e0e26280 00000013 
00000000
Call Trace:
 [<c011abe4>] module_finalize+0x94/0xa0
 [<c0143f2b>] load_module+0x6cb/0x910
 [<c014420b>] sys_init_module+0x9b/0x370
 [<c016df05>] sys_read+0x45/0x60
 [<c010a51b>] syscall_call+0x7/0xb

Code:  Bad EIP value.


