Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTLGQto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTLGQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:49:44 -0500
Received: from pool-141-152-252-159.phil.east.verizon.net ([141.152.252.159]:1540
	"EHLO orac.homeunix.net") by vger.kernel.org with ESMTP
	id S264454AbTLGQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:49:42 -0500
Message-ID: <3FD35A33.6030909@zulutango.com>
Date: Sun, 07 Dec 2003 11:49:55 -0500
From: "Thomas R. Sibley" <tom+kernel@zulutango.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Oops] Unable to handle kernel NULL pointer dereference
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I built a kernel (2.4.20-gentoo-r9) for a machine, but when I go to boot 
using it, I get an Oops error and subsequent kernel panic.  It appears 
to be a problem with the init code, but I'm no kernel hacker, so I can't 
diagnose the problem much further.

In any case, I copied down the error in full and ran it through ksymoops 
on another machine (after copying over the System.map and 
/lib/modules/... dir) which produced the following report:

----------------------------------------------------------------------
ksymoops 2.4.9 on i686 2.4.20-gentoo-r6.  Options used
      -V (default)
      -K (specified)
      -L (specified)
      -o 2.4.20-gentoo-r9/ (specified)
      -m System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0201569
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c0201569>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000 ebx: c01e3b74 ecx: c0196728 edx: 00000000
esi: c0173fb4 edi: c0179000 ebp: 0008e000 esp: c113dfc4
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=c113d000)
Stack: c0179000 c01e3b74 c01e4452 c013c000 c01e449f c02032d3 00000000 
00010f00
        c0173fb4 c0179000 0008e000 c0203b4e 00000000 c02032b0 00000000
Call Trace: [<c02032d3>] [<c0203b4e>] [<c02032b0>]
Code: f0 ff 40 10 a1 48 ee 14 c0 83 48 14 18 a1 34 ee 14 c0 f0 ff


 >>EIP; c0201569 <init+9/90>   <=====

 >>ebx; c01e3b74 <__initcall_init+0/4>
 >>ecx; c0196728 <irq_stat+8/400>
 >>esi; c0173fb4 <init_task_union+1fb4/2000>
 >>edi; c0179000 <__bss_start+0/0>

Trace; c02032d3 <init+23/1b0>
Trace; c0203b4e <arch_kernel_thread+2e/40>
Trace; c02032b0 <init+0/1b0>

Code;  c0201569 <init+9/90>
00000000 <_EIP>:
Code;  c0201569 <init+9/90>   <=====
    0:   f0 ff 40 10               lock incl 0x10(%eax)   <=====
Code;  c020156d <init+d/90>
    4:   a1 48 ee 14 c0            mov    0xc014ee48,%eax
Code;  c0201572 <init+12/90>
    9:   83 48 14 18               orl    $0x18,0x14(%eax)
Code;  c0201576 <init+16/90>
    d:   a1 34 ee 14 c0            mov    0xc014ee34,%eax
Code;  c020157b <init+1b/90>
   12:   f0 ff 00                  lock incl (%eax)

  <0>Kernel panic: Attempted to kill init!
----------------------------------------------------------------------

This is the first time I've encountered an Oops, so hopefully I've 
understood the docs and provided all the correct information.  If 
hardware stats are needed, I can post them.  Any help with this issue 
would be greatly appreciated.

Cheers,
Tom
