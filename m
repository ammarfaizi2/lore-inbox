Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUFEVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUFEVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUFEVeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:34:15 -0400
Received: from [80.72.36.106] ([80.72.36.106]:41396 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261984AbUFEVeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:34:11 -0400
Date: Sat, 5 Jun 2004 23:33:57 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, len.brown@intel.com
Subject: modprobing ACPI(?) module gives oops (2.6.7-rc2-mm2)
In-Reply-To: <20040604214739.61232c26.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0406052321080.19576@alpha.polcom.net>
References: <1118873EE1755348B4812EA29C55A9722AF016@esnmail.esntechnologies.co.in>
 <20040604214739.61232c26.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You ACPI people (with great support from the USB people of course) are 
really extremly powerful: you can break any kernel for me... :-)

2.6.6-mm4 worked ok while with 2.6.7-rc2-mm2 my (Gentoo) startup scripts 
got this:

Jun  4 19:17:02 polb01 Unable to handle kernel paging request at virtual 
address c04e8840
Jun  4 19:17:02 polb01 printing eip:
Jun  4 19:17:02 polb01 c03129ab
Jun  4 19:17:02 polb01 *pde = 00533027
Jun  4 19:17:02 polb01 *pte = 004e8000
Jun  4 19:17:02 polb01 Oops: 0002 [#1]
Jun  4 19:17:02 polb01 PREEMPT DEBUG_PAGEALLOC
Jun  4 19:17:02 polb01 Modules linked in: ac psmouse pppoatm atm 
ppp_deflate zlib_deflate zlib_inflate ppp_generic slhc capability 
commoncap unix
Jun  4 19:17:02 polb01 CPU:    0
Jun  4 19:17:02 polb01 EIP:    0060:[<c03129ab>]    Not tainted VLI
Jun  4 19:17:02 polb01 EFLAGS: 00010246   (2.6.7-rc2-mm2)
Jun  4 19:17:02 polb01 EIP is at acpi_bus_register_driver+0xd3/0x173
Jun  4 19:17:02 polb01 eax: c04e8840   ebx: e5909160   ecx: 000001e2   
edx: ffffffed
Jun  4 19:17:02 polb01 esi: 00000000   edi: e59092c0   ebp: de5bdf84   
esp: de5bdf7c
Jun  4 19:17:02 polb01 ds: 007b   es: 007b   ss: 0068
Jun  4 19:17:02 polb01 Process modprobe (pid: 4996, threadinfo=de5bc000 
task=de5ee9f0)
Jun  4 19:17:02 polb01 Stack: c044a9a0 de5bc000 de5bdf8c e590f032 de5bdfbc 
c0140645 dd9b8f4c dee08eb0
Jun  4 19:17:02 polb01 dee08910 de3e0d4c de3e0d6c 00000000 de5bdfbc 
4014b008 0805b168 40096b7b
Jun  4 19:17:02 polb01 de5bc000 c010583d 4014b008 0002e917 0805b168 
0805b168 40096b7b 0805b168
Jun  4 19:17:02 polb01 Call Trace:
Jun  4 19:17:02 polb01 [<c0105e4a>] show_stack+0x7a/0x90
Jun  4 19:17:02 polb01 [<c0105fcd>] show_registers+0x14d/0x1b0
Jun  4 19:17:02 polb01 [<c01061c9>] die+0xf9/0x250
Jun  4 19:17:02 polb01 [<c01184e3>] do_page_fault+0x1d3/0x55b
Jun  4 19:17:02 polb01 [<c0105abd>] error_code+0x2d/0x38
Jun  4 19:17:02 polb01 [<e590f032>] init_module+0x32/0x51 [ac]
Jun  4 19:17:02 polb01 [<c0140645>] sys_init_module+0x1c5/0x390
Jun  4 19:17:02 polb01 [<c010583d>] sysenter_past_esp+0x52/0x71
Jun  4 19:17:02 polb01
Jun  4 19:17:02 polb01 Code: ac 89 45 c0 01 00 00 00 c7 05 b8 89 45 c0 1e 
7d 42 c0 c7 05 bc 89 45 c0 59 01 00 00 89 1d 2c 8a 45 c0 c7 03 28 8a 45 c0 
89 43 04 <89> 18 81 3d a8 89 45 c0 3c 4b 24 1d 74 1c 68 a8 89 45 c0 68 5b
Jun  4 19:17:02 polb01 <6>note: modprobe[4996] exited with preempt_count 1
Jun  4 19:17:02 polb01 Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Jun  4 19:17:02 polb01 in_atomic():1, irqs_disabled():0
Jun  4 19:17:02 polb01 [<c0105e77>] dump_stack+0x17/0x20
Jun  4 19:17:02 polb01 [<c011c934>] __might_sleep+0xb4/0xe0
Jun  4 19:17:02 polb01 [<c012419f>] do_exit+0xaf/0x980
Jun  4 19:17:02 polb01 [<c010631b>] die+0x24b/0x250
Jun  4 19:17:02 polb01 [<c01184e3>] do_page_fault+0x1d3/0x55b
Jun  4 19:17:02 polb01 [<c0105abd>] error_code+0x2d/0x38
Jun  4 19:17:02 polb01 [<e590f032>] init_module+0x32/0x51 [ac]
Jun  4 19:17:02 polb01 [<c0140645>] sys_init_module+0x1c5/0x390
Jun  4 19:17:02 polb01 [<c010583d>] sysenter_past_esp+0x52/0x71
Jun  4 19:17:02 polb01
Jun  4 19:17:02 polb01 bad: scheduling while atomic!
Jun  4 19:17:02 polb01 [<c0105e77>] dump_stack+0x17/0x20
Jun  4 19:17:02 polb01 [<c03f2e57>] schedule+0x717/0x720
Jun  4 19:17:02 polb01 [<c015b0c0>] unmap_vmas+0x1f0/0x2e0
Jun  4 19:17:02 polb01 [<c0160ba8>] exit_mmap+0xc8/0x270
Jun  4 19:17:02 polb01 [<c011d7fe>] mmput+0xbe/0x140
Jun  4 19:17:02 polb01 [<c01242c4>] do_exit+0x1d4/0x980
Jun  4 19:17:02 polb01 [<c010631b>] die+0x24b/0x250
Jun  4 19:17:02 polb01 [<c01184e3>] do_page_fault+0x1d3/0x55b
Jun  4 19:17:02 polb01 [<c0105abd>] error_code+0x2d/0x38
Jun  4 19:17:02 polb01 [<e590f032>] init_module+0x32/0x51 [ac]
Jun  4 19:17:02 polb01 [<c0140645>] sys_init_module+0x1c5/0x390
Jun  4 19:17:02 polb01 [<c010583d>] sysenter_past_esp+0x52/0x71
Jun  4 19:17:02 polb01
Jun  4 19:17:02 polb01 drivers/acpi/scan.c:345: 
spin_lock(drivers/acpi/scan.c:c04589a8) already locked by 
drivers/acpi/scan.c/345


What can cause this? Is this a known problem or something new? What can I 
do to help track this down?


Thanks in advance,

Grzegorz Kulewski

