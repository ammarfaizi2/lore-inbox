Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUFDXdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUFDXdC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266044AbUFDXdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:33:02 -0400
Received: from levante.wiggy.net ([195.85.225.139]:6376 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S266097AbUFDX2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:28:18 -0400
Date: Sat, 5 Jun 2004 01:28:17 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: [2.6.6] Oops when unloading processor module
Message-ID: <20040604232817.GA11305@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the IWP2100 driver has some issues with the acpi processor
module entering C3 I tried to unload the processor module which
resulted in the oops below.


Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017d66a>] remove_proc_entry+0x10a/0x150
 [<e08e5f0e>] acpi_thermal_remove_fs+0x1d/0x2d [thermal]
 [<e08e61a7>] acpi_thermal_remove+0x77/0x80 [thermal]
 [<c01eab6d>] acpi_driver_detach+0x39/0x7c
 [<c01eac21>] acpi_bus_unregister_driver+0x12/0x51
 [<e08e61ba>] acpi_thermal_exit+0xa/0x1e [thermal]
 [<c012bf10>] sys_delete_module+0x150/0x1a0
 [<c0142faa>] do_munmap+0x14a/0x190
 [<c010411b>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address e08c628c
 printing eip:
e08c628c
*pde = 0146e067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<e08c628c>]    Not tainted
EFLAGS: 00010282   (2.6.6) 
EIP is at 0xe08c628c
eax: 00000000   ebx: 002e8456   ecx: 00000008   edx: 00000000
esi: df52e8f8   edi: 002e7f16   ebp: df52e800   esp: c03fbfbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03fa000 task=c0380a40)
Stack: 00099100 00000000 c03fa000 00099100 c0422c80 0046d007 c01020e4 c03fa000 
       c03fc73f c0380a40 00000000 c0419e50 00000018 c03fc490 c0422a80 00000816 
       c010019f 
Call Trace:
 [<c01020e4>] cpu_idle+0x34/0x40
 [<c03fc73f>] start_kernel+0x15f/0x180
 [<c03fc490>] unknown_bootoption+0x0/0x120

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
