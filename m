Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbSJHC4w>; Mon, 7 Oct 2002 22:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262932AbSJHC4w>; Mon, 7 Oct 2002 22:56:52 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3200 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262778AbSJHC4u>;
	Mon, 7 Oct 2002 22:56:50 -0400
Date: Mon, 7 Oct 2002 22:02:28 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: problems removing ide-scsi modules
Message-ID: <Pine.LNX.4.44.0210072152540.1002-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In another thread beginning with:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103388771007676&w=2

a problem is reported with loading ide-scsi modules.  In addition to the 
problems noted in loading those modules, I've noted problems removing the 
modules since at least 2.5.38.  Following is an example of the oops I get 
when this happens.  This doesn't lock up the kernel, but I do get a freeze 
during a subsequent reboot which I've documented at

http://marc.theaimsgroup.com/?l=linux-kernel&m=103351991417181&w=2

Unable to handle kernel paging request at virtual address 5a5a5a62
 printing eip:
c01a79ac
*pde = 00000000
Oops: 0000
sr_mod cdrom sg ide-scsi scsi_mod ymfpci soundcore ac97_codec parport_pc 
lp parport rtc
CPU:    0
EIP:    0060:[<c01a79ac>]    Not tainted
EFLAGS: 00010206
EIP is at devclass_remove_device+0xc/0x40
eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: d90ab268   edx: d7118820
esi: d7118820   edi: 00000000   ebp: d90ab268   esp: d5c3df50
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 951, threadinfo=d5c3c000 task=d65026c0)
Stack: 5a5a5a5a d7118820 c01a6d16 d7118820 d7118820 d7118838 c01a6dce 
d7118820
       d90ab268 00000000 00000000 d5d0a000 c01a780b d90ab268 d90a8000 
d90a8ff3
       d90ab268 c01193de d90a8000 00000000 fffffff0 c01188b7 d90a8000 
00000000
Call Trace:
 [<c01a6d16>] device_detach+0x16/0x30
 [<c01a6dce>] driver_detach+0x3e/0x60
 [<d90ab268>] sr_template+0x48/0xa0 [sr_mod]
 [<c01a780b>] __remove_driver+0xb/0x30
 [<d90ab268>] sr_template+0x48/0xa0 [sr_mod]
 [<d90a8ff3>] exit_sr+0x43/0x50 [sr_mod]
 [<d90ab268>] sr_template+0x48/0xa0 [sr_mod]
 [<c01193de>] free_module+0x1e/0xb0
 [<c01188b7>] sys_delete_module+0xe7/0x1c0
 [<c0108adf>] syscall_call+0x7/0xb

Code: 8b 58 08 85 db 74 1c 56 53 e8 96 01 00 00 56 53 e8 7f ff ff
 Segmentation fault



